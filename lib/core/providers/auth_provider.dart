import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dio/dio.dart';
import '../api/dio_client.dart';
import '../api/api_endpoints.dart';
import '../models/register_request.dart';
import '../models/register_response.dart';

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
