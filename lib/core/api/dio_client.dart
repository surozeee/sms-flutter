import 'package:dio/dio.dart';

import 'api_endpoints.dart';
import 'api_interceptors.dart';

/// Dio Client
/// Centralized HTTP client configuration with interceptors
class DioClient {
  late Dio _dio;
  final ApiInterceptors _interceptors = ApiInterceptors();

  DioClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrlWithVersion,
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
        // headers: {
        //   'Content-Type': 'application/x-www-form-urlencoded',
        //   'Accept': 'application/json',
        // },
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'X-XSRF-TOKEN': 'BquLOJXXt2ng415MpvK4a8F0CF/w/1iawsnFqHzPGeo=',
        },
      ),
    );

    // Add interceptors
    _dio.interceptors.add(_interceptors);
  }

  /// Get Dio instance
  Dio get dio => _dio;

  /// Set authentication token
  void setAuthToken(String? token) {
    _interceptors.setAuthToken(token);
  }

  /// Set refresh token
  void setRefreshToken(String? token) {
    _interceptors.setRefreshToken(token);
  }

  /// Clear authentication tokens
  void clearTokens() {
    _interceptors.clearTokens();
  }

  /// GET request
  /// [requiresAuth] defaults to true - set to false for public endpoints
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool requiresAuth = true,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      // Merge options with requiresAuth flag
      final mergedOptions = options?.copyWith(
            extra: {
              ...?options.extra,
              'requiresAuth': requiresAuth,
            },
          ) ??
          Options(
            extra: {'requiresAuth': requiresAuth},
          );

      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: mergedOptions,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// POST request
  /// [requiresAuth] defaults to true - set to false for public endpoints
  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool requiresAuth = true,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      // Merge options with requiresAuth flag
      final mergedOptions = options?.copyWith(
            extra: {
              ...?options.extra,
              'requiresAuth': requiresAuth,
            },
          ) ??
          Options(
            extra: {'requiresAuth': requiresAuth},
          );

      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: mergedOptions,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// PUT request
  /// [requiresAuth] defaults to true - set to false for public endpoints
  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool requiresAuth = true,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      // Merge options with requiresAuth flag
      final mergedOptions = options?.copyWith(
            extra: {
              ...?options.extra,
              'requiresAuth': requiresAuth,
            },
          ) ??
          Options(
            extra: {'requiresAuth': requiresAuth},
          );

      final response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: mergedOptions,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// PATCH request
  Future<Response> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// DELETE request
  /// [requiresAuth] defaults to true - set to false for public endpoints
  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool requiresAuth = true,
    CancelToken? cancelToken,
  }) async {
    try {
      // Merge options with requiresAuth flag
      final mergedOptions = options?.copyWith(
            extra: {
              ...?options.extra,
              'requiresAuth': requiresAuth,
            },
          ) ??
          Options(
            extra: {'requiresAuth': requiresAuth},
          );

      final response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: mergedOptions,
        cancelToken: cancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// POST request with JSON data and extra dynamic data
  /// Merges the provided data with extra data if provided
  /// [requiresAuth] defaults to true - set to false for public endpoints
  Future<Response> postJson(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? extra,
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool requiresAuth = true,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      // Merge data with extra data
      Map<String, dynamic>? jsonData;
      if (data != null || extra != null) {
        jsonData = <String, dynamic>{};
        if (data != null) {
          jsonData.addAll(data);
        }
        if (extra != null) {
          jsonData.addAll(extra);
        }
      }

      // Merge options with requiresAuth flag
      final mergedOptions = options?.copyWith(
            extra: {
              ...?options.extra,
              'requiresAuth': requiresAuth,
            },
          ) ??
          Options(
            contentType: 'application/json',
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            extra: {'requiresAuth': requiresAuth},
          );

      final response = await _dio.post(
        path,
        data: jsonData,
        queryParameters: queryParameters,
        options: mergedOptions,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// PUT request with JSON data and extra dynamic data
  /// Merges the provided data with extra data if provided
  /// [requiresAuth] defaults to true - set to false for public endpoints
  Future<Response> putJson(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? extra,
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool requiresAuth = true,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      // Merge data with extra data
      Map<String, dynamic>? jsonData;
      if (data != null || extra != null) {
        jsonData = <String, dynamic>{};
        if (data != null) {
          jsonData.addAll(data);
        }
        if (extra != null) {
          jsonData.addAll(extra);
        }
      }

      // Merge options with requiresAuth flag
      final mergedOptions = options?.copyWith(
            extra: {
              ...?options.extra,
              'requiresAuth': requiresAuth,
            },
          ) ??
          Options(
            contentType: 'application/json',
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            extra: {'requiresAuth': requiresAuth},
          );

      final response = await _dio.put(
        path,
        data: jsonData,
        queryParameters: queryParameters,
        options: mergedOptions,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// DELETE request with JSON data and extra dynamic data
  /// Merges the provided data with extra data if provided
  /// [requiresAuth] defaults to true - set to false for public endpoints
  Future<Response> deleteJson(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? extra,
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool requiresAuth = true,
    CancelToken? cancelToken,
  }) async {
    try {
      // Merge data with extra data
      Map<String, dynamic>? jsonData;
      if (data != null || extra != null) {
        jsonData = <String, dynamic>{};
        if (data != null) {
          jsonData.addAll(data);
        }
        if (extra != null) {
          jsonData.addAll(extra);
        }
      }

      // Merge options with requiresAuth flag
      final mergedOptions = options?.copyWith(
            extra: {
              ...?options.extra,
              'requiresAuth': requiresAuth,
            },
          ) ??
          Options(
            contentType: 'application/json',
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            extra: {'requiresAuth': requiresAuth},
          );

      final response = await _dio.delete(
        path,
        data: jsonData,
        queryParameters: queryParameters,
        options: mergedOptions,
        cancelToken: cancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// Upload file
  Future<Response> uploadFile(
    String path,
    String filePath, {
    String fileKey = 'file',
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
  }) async {
    try {
      final formData = FormData.fromMap({
        ...?data,
        fileKey: await MultipartFile.fromFile(filePath),
      });

      final response = await _dio.post(
        path,
        data: formData,
        queryParameters: queryParameters,
        options: options ??
            Options(
              contentType: 'multipart/form-data',
            ),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// Download file
  Future<Response> downloadFile(
    String urlPath,
    String savePath, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.download(
        urlPath,
        savePath,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}

/// Singleton instance of DioClient
class DioClientSingleton {
  static DioClient? _instance;

  static DioClient get instance {
    _instance ??= DioClient();
    return _instance!;
  }

  static void reset() {
    _instance = null;
  }
}
