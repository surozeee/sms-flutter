import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dio/dio.dart';
import '../api/dio_client.dart';
import '../api/api_endpoints.dart';
import '../models/register_request.dart';
import '../models/register_response.dart';
import '../models/login_request.dart';
import '../models/login_response.dart';
import '../models/user_profile.dart';
import '../services/auth_cache_service.dart';
import '../services/profile_cache_service.dart';

part 'auth_provider.g.dart';

@riverpod
Future<DioClient> dioClient(DioClientRef ref) async {
  final client = DioClientSingleton.instance;
  
  // Load cached tokens on initialization
  final accessToken = await AuthCacheService.getAccessToken();
  final refreshToken = await AuthCacheService.getRefreshToken();
  
  if (accessToken != null && accessToken.isNotEmpty) {
    client.setAuthToken(accessToken);
  }
  
  if (refreshToken != null && refreshToken.isNotEmpty) {
    client.setRefreshToken(refreshToken);
  }
  
  return client;
}

/// Provider to check if user is logged in
@riverpod
Future<bool> isLoggedIn(IsLoggedInRef ref) async {
  return await AuthCacheService.isLoggedIn();
}

/// Provider to get cached user type
@riverpod
Future<String?> userType(UserTypeRef ref) async {
  return await AuthCacheService.getUserType();
}

/// Provider to get cached access token
@riverpod
Future<String?> accessToken(AccessTokenRef ref) async {
  return await AuthCacheService.getAccessToken();
}

/// Provider to get cached refresh token
@riverpod
Future<String?> refreshToken(RefreshTokenRef ref) async {
  return await AuthCacheService.getRefreshToken();
}

/// Provider to get all cached login data
@riverpod
Future<Map<String, String?>> loginData(LoginDataRef ref) async {
  return await AuthCacheService.getLoginData();
}

/// Provider for logout functionality
@riverpod
class Logout extends _$Logout {
  @override
  Future<void> build() async {
    // Initialize with no-op
  }

  Future<void> logout() async {
    // Clear cached login data
    await AuthCacheService.clearLoginData();
    
    // Clear cached profile data
    await ProfileCacheService.clearProfile();
    
    // Clear tokens from DioClient
    final dioClient = await ref.read(dioClientProvider.future);
    dioClient.clearTokens();
    
    // Invalidate related providers to update UI
    ref.invalidate(isLoggedInProvider);
    ref.invalidate(userTypeProvider);
    ref.invalidate(accessTokenProvider);
    ref.invalidate(refreshTokenProvider);
    ref.invalidate(loginDataProvider);
    ref.invalidate(loginProvider); // Clear login state
    ref.invalidate(userProfileProviderProvider); // Clear profile
    ref.invalidate(profileDataProvider); // Clear profile data
    ref.invalidate(userBalanceProvider); // Clear balance
    
    state = const AsyncValue.data(null);
  }
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
      final dioClient = await ref.read(dioClientProvider.future);
      
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
      final dioClient = await ref.read(dioClientProvider.future);
      
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
          final userType = loginResponse.data?.userType;
          
          if (accessToken != null && refreshToken != null && userType != null) {
            // Store in DioClient for immediate use
            dioClient.setAuthToken(accessToken);
            dioClient.setRefreshToken(refreshToken);
            
            // Cache login data for persistence
            await AuthCacheService.saveLoginData(
              accessToken: accessToken,
              refreshToken: refreshToken,
              userType: userType,
            );
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

/// Provider to fetch and cache user profile
@riverpod
class UserProfileProvider extends _$UserProfileProvider {
  @override
  Future<UserProfile?> build() async {
    // Try to load from cache first
    final cachedProfile = await ProfileCacheService.getProfile();
    if (cachedProfile != null) {
      return cachedProfile;
    }
    
    // If no cache, fetch from API
    return await fetchProfile();
  }

  Future<UserProfile?> fetchProfile() async {
    state = const AsyncValue.loading();

    try {
      final dioClient = await ref.read(dioClientProvider.future);
      
      final response = await dioClient.get(
        ApiEndpoints.mobileProfile,
        requiresAuth: true, // Profile requires authentication
      );

      if (response.statusCode == 200) {
        final profileResponse = ProfileResponse.fromJson(
          response.data is Map<String, dynamic>
              ? response.data
              : {'data': response.data},
        );
        
        // Cache the profile
        if (profileResponse.data != null && profileResponse.data!.user != null) {
          await ProfileCacheService.saveProfile(profileResponse);
          state = AsyncValue.data(profileResponse.data!.user);
          return profileResponse.data!.user;
        }
        
        state = const AsyncValue.data(null);
        return null;
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          message: 'Profile fetch failed with status: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      final errorMessage = e.response?.data?['message'] ?? 
                           e.message ?? 
                           'Failed to fetch profile';
      
      state = AsyncValue.error(errorMessage, StackTrace.current);
      rethrow;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }

  /// Refresh profile from API
  Future<void> refreshProfile() async {
    await fetchProfile();
  }
}

/// Provider to get profile data (includes balance, roleType)
@riverpod
Future<ProfileData?> profileData(ProfileDataRef ref) async {
  // Try to load from cache first
  final cachedData = await ProfileCacheService.getProfileData();
  if (cachedData != null) {
    return cachedData;
  }
  
  // If no cache, fetch profile which will cache the data
  final profileNotifier = ref.read(userProfileProviderProvider.notifier);
  await profileNotifier.fetchProfile();
  
  // Return cached data after fetch
  return await ProfileCacheService.getProfileData();
}

/// Provider to get user balance
@riverpod
Future<double> userBalance(UserBalanceRef ref) async {
  return await ProfileCacheService.getBalance();
}
