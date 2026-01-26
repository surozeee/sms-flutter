import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dio/dio.dart';
import '../api/dio_client.dart';
import '../api/api_endpoints.dart';
import '../models/register_request.dart';
import '../models/register_response.dart';
import '../models/login_request.dart';
import '../models/login_response.dart';

part 'auth_provider.g.dart';

@riverpod
DioClient dioClient(DioClientRef ref) {
  return DioClientSingleton.instance;
}

@riverpod
class Register extends _$Register {
  @override
  Future<RegisterResponse?> build() async {
    return null;
  }

  Future<RegisterResponse> register(RegisterRequest request) async {
    state = const AsyncValue.loading();

    try {
      final dioClient = ref.read(dioClientProvider);
      
      final response = await dioClient.postJson(
        ApiEndpoints.userRegister,
        data: request.toJson(),
        requiresAuth: false, // Registration doesn't require auth
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final registerResponse = RegisterResponse.fromJson(
          response.data is Map<String, dynamic>
              ? response.data
              : {'data': response.data},
        );
        
        state = AsyncValue.data(registerResponse);
        return registerResponse;
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          message: 'Registration failed with status: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      final errorMessage = e.response?.data?['message'] ?? 
                           e.response?.data?['error'] ?? 
                           e.message ?? 
                           'Registration failed';
      
      state = AsyncValue.error(errorMessage, StackTrace.current);
      rethrow;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }
}

@riverpod
class Login extends _$Login {
  @override
  Future<LoginResponse?> build() async {
    return null;
  }

  Future<LoginResponse> login(LoginRequest request) async {
    state = const AsyncValue.loading();

    try {
      final dioClient = ref.read(dioClientProvider);
      
      final response = await dioClient.postJson(
        ApiEndpoints.userLogin,
        data: request.toJson(),
        requiresAuth: false, // Login doesn't require auth
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final loginResponse = LoginResponse.fromJson(
          response.data is Map<String, dynamic>
              ? response.data
              : {'data': response.data},
        );
        
        // Store tokens if login is successful
        if (loginResponse.success == true && loginResponse.data != null) {
          final accessToken = loginResponse.data?.accessToken;
          final refreshToken = loginResponse.data?.refreshToken;
          
          if (accessToken != null) {
            dioClient.setAuthToken(accessToken);
          }
          if (refreshToken != null) {
            dioClient.setRefreshToken(refreshToken);
          }
        }
        
        state = AsyncValue.data(loginResponse);
        return loginResponse;
      } else {
        // Handle error response
        final errorResponse = LoginResponse.fromJson(
          response.data is Map<String, dynamic>
              ? response.data
              : {'success': false, 'message': 'Login failed'},
        );
        
        state = AsyncValue.data(errorResponse);
        return errorResponse;
      }
    } on DioException catch (e) {
      // Parse error response if available
      if (e.response != null && e.response!.data != null) {
        try {
          final errorResponse = LoginResponse.fromJson(
            e.response!.data is Map<String, dynamic>
                ? e.response!.data
                : {'success': false, 'message': e.message ?? 'Login failed'},
          );
          state = AsyncValue.data(errorResponse);
          return errorResponse;
        } catch (_) {
          // If parsing fails, use default error
          final errorResponse = LoginResponse(
            success: false,
            message: e.response?.data?['message'] ?? 
                     e.message ?? 
                     'Login failed',
            code: e.response?.data?['code'],
          );
          state = AsyncValue.data(errorResponse);
          return errorResponse;
        }
      } else {
        final errorResponse = LoginResponse(
          success: false,
          message: e.message ?? 'Login failed. Please check your connection.',
        );
        state = AsyncValue.data(errorResponse);
        return errorResponse;
      }
    } catch (e) {
      final errorResponse = LoginResponse(
        success: false,
        message: e.toString(),
      );
      state = AsyncValue.data(errorResponse);
      return errorResponse;
    }
  }
}
