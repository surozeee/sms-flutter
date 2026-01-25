import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../api/api_endpoints.dart';

/// API Interceptors
/// Handles authentication, logging, and error handling for API requests
class ApiInterceptors extends Interceptor {
  // Token storage - you can integrate with your auth service
  String? _authToken;
  String? _refreshToken;

  /// Set authentication token
  void setAuthToken(String? token) {
    _authToken = token;
  }

  /// Set refresh token
  void setRefreshToken(String? token) {
    _refreshToken = token;
  }

  /// Clear tokens
  void clearTokens() {
    _authToken = null;
    _refreshToken = null;
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Check if authentication is required for this request
    // Default to true if not specified (backward compatibility)
    final requiresAuth = options.extra['requiresAuth'] as bool? ?? true;

    // Add authentication token to headers only if required
    if (requiresAuth && _authToken != null && _authToken!.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $_authToken';
    }

    // Add common headers (only if not already set)
    if (!options.headers.containsKey('Content-Type')) {
      options.headers['Content-Type'] = 'application/json';
    }
    if (!options.headers.containsKey('Accept')) {
      options.headers['Accept'] = 'application/json';
    }

    // Logging interceptor (only in debug mode)
    if (kDebugMode) {
      print('┌─────────────────────────────────────────────────────────');
      print('│ REQUEST: ${options.method} ${options.uri}');
      print('│ Headers: ${options.headers}');
      if (options.data != null) {
        print('│ Data: ${options.data}');
      }
      if (options.queryParameters.isNotEmpty) {
        print('│ Query Parameters: ${options.queryParameters}');
      }
      print('└─────────────────────────────────────────────────────────');
    }

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Logging interceptor (only in debug mode)
    if (kDebugMode) {
      print('┌─────────────────────────────────────────────────────────');
      print(
          '│ RESPONSE: ${response.statusCode} ${response.requestOptions.uri}');
      print('│ Data: ${response.data}');
      print('└─────────────────────────────────────────────────────────');
    }

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Logging error (only in debug mode)
    if (kDebugMode) {
      print('┌─────────────────────────────────────────────────────────');
      print('│ ERROR: ${err.type}');
      print('│ URL: ${err.requestOptions.uri}');
      print('│ Status Code: ${err.response?.statusCode}');
      print('│ Message: ${err.message}');
      if (err.response?.data != null) {
        print('│ Error Data: ${err.response?.data}');
      }
      print('└─────────────────────────────────────────────────────────');
    }

    // Handle 401 Unauthorized - Token expired
    // Only attempt token refresh if the request required authentication
    final requiresAuth = err.requestOptions.extra['requiresAuth'] as bool? ?? true;
    if (err.response?.statusCode == 401 && requiresAuth) {
      try {
        // Attempt to refresh token
        final refreshed = await _refreshAuthToken();
        if (refreshed) {
          // Retry the original request with new token
          final opts = err.requestOptions;
          opts.headers['Authorization'] = 'Bearer $_authToken';

          final dio = Dio();
          dio.interceptors.add(ApiInterceptors()
            ..setAuthToken(_authToken)
            ..setRefreshToken(_refreshToken));

          try {
            final response = await dio.request(
              opts.path,
              options: Options(
                method: opts.method,
                headers: opts.headers,
                extra: opts.extra,
              ),
              data: opts.data,
              queryParameters: opts.queryParameters,
            );
            return handler.resolve(response);
          } catch (e) {
            // If retry fails, clear tokens and return error
            clearTokens();
            return handler.reject(err);
          }
        } else {
          // Refresh failed, clear tokens
          clearTokens();
          return handler.reject(err);
        }
      } catch (e) {
        clearTokens();
        return handler.reject(err);
      }
    }

    // Handle other errors
    final errorMessage = _getErrorMessage(err);
    final customError = DioException(
      requestOptions: err.requestOptions,
      response: err.response,
      type: err.type,
      error: err.error,
      message: errorMessage,
    );

    handler.reject(customError);
  }

  /// Refresh authentication token
  Future<bool> _refreshAuthToken() async {
    if (_refreshToken == null || _refreshToken!.isEmpty) {
      return false;
    }

    try {
      final dio = Dio();
      final response = await dio.post(
        ApiEndpoints.buildUrl(ApiEndpoints.refreshToken),
        data: {'refresh_token': _refreshToken},
      );

      if (response.statusCode == 200 && response.data != null) {
        // Update tokens from response
        // Adjust these keys based on your API response structure
        _authToken = response.data['access_token'] ?? response.data['token'];
        _refreshToken = response.data['refresh_token'] ?? _refreshToken;
        return true;
      }
      return false;
    } catch (e) {
      if (kDebugMode) {
        print('Token refresh failed: $e');
      }
      return false;
    }
  }

  /// Get user-friendly error message
  String _getErrorMessage(DioException err) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Connection timeout. Please check your internet connection.';

      case DioExceptionType.badResponse:
        final statusCode = err.response?.statusCode;
        if (statusCode == 400) {
          return 'Bad request. Please check your input.';
        } else if (statusCode == 401) {
          return 'Unauthorized. Please login again.';
        } else if (statusCode == 403) {
          return 'Access forbidden. You don\'t have permission.';
        } else if (statusCode == 404) {
          return 'Resource not found.';
        } else if (statusCode == 500) {
          return 'Server error. Please try again later.';
        } else {
          return err.response?.data['message'] ??
              err.response?.data['error'] ??
              'An error occurred. Status code: $statusCode';
        }

      case DioExceptionType.cancel:
        return 'Request cancelled.';

      case DioExceptionType.unknown:
        if (err.error?.toString().contains('SocketException') ?? false) {
          return 'No internet connection. Please check your network.';
        }
        return 'Unknown error occurred. Please try again.';

      default:
        return err.message ?? 'An unexpected error occurred.';
    }
  }
}

extension ApiOptionsExtension on Options {
  /// Create Options with requiresAuth set to true
  /// Use this for authenticated endpoints
  ///
  /// Example:
  /// ```dart
  /// options: ApiOptionsExtension.withAuth()
  /// ```
  static Options withAuth({Map<String, dynamic>? headers}) {
    final extra = <String, dynamic>{'requiresAuth': true};
    return Options(
      extra: extra,
      headers: headers,
      contentType: 'application/json',
      followRedirects: true,
    );
  }

  /// Create Options with requiresAuth explicitly set to false
  /// Use this when you want to explicitly mark an endpoint as public
  ///
  /// Example:
  /// ```dart
  /// options: ApiOptionsExtension.withoutAuth(headers: customHeaders)
  /// ```
  static Options withoutAuth({Map<String, dynamic>? headers}) {
    return Options(
      extra: {'requiresAuth': false},
      headers: headers,
      contentType: 'application/json',
    );
  }
}
