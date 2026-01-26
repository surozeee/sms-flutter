import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../api/api_endpoints.dart';
import '../services/auth_cache_service.dart';
import '../../screens/auth/role_selection_screen.dart';
import '../../main.dart';

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

    // Handle 401 Unauthorized - Token expired or invalid
    if (err.response?.statusCode == 401) {
      final requiresAuth = err.requestOptions.extra['requiresAuth'] as bool? ?? true;
      
      // Only attempt token refresh if the request required authentication
      if (requiresAuth) {
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
              // If retry fails, clear tokens and redirect to login
              await _handleUnauthorized();
              return handler.reject(err);
            }
          } else {
            // Refresh failed, clear tokens and redirect to login
            await _handleUnauthorized();
            return handler.reject(err);
          }
        } catch (e) {
          // On any error, clear tokens and redirect to login
          await _handleUnauthorized();
          return handler.reject(err);
        }
      } else {
        // 401 on non-auth request - still clear tokens and redirect
        await _handleUnauthorized();
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
        final newAccessToken = response.data['access_token'] ?? response.data['token'];
        final newRefreshToken = response.data['refresh_token'] ?? _refreshToken;
        
        if (newAccessToken != null) {
          _authToken = newAccessToken;
          // Update cache
          await AuthCacheService.updateAccessToken(newAccessToken);
        }
        
        if (newRefreshToken != null && newRefreshToken != _refreshToken) {
          _refreshToken = newRefreshToken;
          // Update cache
          await AuthCacheService.updateRefreshToken(newRefreshToken);
        }
        
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

  /// Handle unauthorized access (401) - Clear tokens and redirect to login
  Future<void> _handleUnauthorized() async {
    // Clear tokens
    clearTokens();
    
    // Clear cached login data
    await AuthCacheService.clearLoginData();
    
    // Navigate to RoleSelectionScreen using global navigator key
    if (navigatorKey.currentContext != null) {
      navigatorKey.currentState?.pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const RoleSelectionScreen(),
        ),
        (route) => false, // Remove all previous routes
      );
    }
  }

  /// Get user-friendly error message
  /// Prioritizes API response messages over system messages
  String _getErrorMessage(DioException err) {
    // First, try to extract error message from API response data
    if (err.response?.data != null) {
      final responseData = err.response!.data;
      
      // Handle different response data formats
      String? apiMessage;
      if (responseData is Map<String, dynamic>) {
        // Try common error message fields
        apiMessage = responseData['message'] as String? ??
            responseData['error'] as String? ??
            responseData['errorMessage'] as String? ??
            responseData['msg'] as String?;
        
        // If message is a list, join it
        if (apiMessage == null && responseData['message'] is List) {
          final messages = responseData['message'] as List;
          if (messages.isNotEmpty) {
            apiMessage = messages.map((e) => e.toString()).join(', ');
          }
        }
        
        // Check for nested error objects
        if (apiMessage == null && responseData['error'] is Map) {
          final errorObj = responseData['error'] as Map;
          apiMessage = errorObj['message'] as String? ??
              errorObj['error'] as String?;
        }
      } else if (responseData is String) {
        // If response is a plain string, use it
        apiMessage = responseData;
      }
      
      // If we found an API message, return it
      if (apiMessage != null && apiMessage.isNotEmpty) {
        return apiMessage;
      }
    }
    
    // Fallback to system messages only if no API message found
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
          return 'An error occurred. Status code: $statusCode';
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
