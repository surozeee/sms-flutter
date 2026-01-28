import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../api/api_endpoints.dart';
import '../api/dio_client.dart';
import '../models/bank_info_response.dart';
import '../models/booth_list_request.dart';
import '../models/booth_list_response.dart';
import '../models/bulk_register_response.dart';
import '../models/content_create_request.dart';
import '../models/content_create_response.dart';
import '../models/contents_list_request.dart';
import '../models/contents_list_response.dart';
import '../models/login_request.dart';
import '../models/login_response.dart';
import '../models/member_delete_response.dart';
import '../models/member_register_request.dart';
import '../models/member_register_response.dart';
import '../models/members_list_request.dart';
import '../models/members_list_response.dart';
import '../models/packages_list_request.dart';
import '../models/packages_list_response.dart';
import '../models/push_notifications_list_request.dart';
import '../models/push_notifications_list_response.dart';
import '../models/register_request.dart';
import '../models/register_response.dart';
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
    // Clear tokens from DioClient FIRST to prevent any API calls
    final dioClient = await ref.read(dioClientProvider.future);
    dioClient.clearTokens();

    // Clear cached login data FIRST
    await AuthCacheService.clearLoginData();

    // Clear cached profile data
    await ProfileCacheService.clearProfile();

    // Immediately set profile provider state to null to prevent fetching
    try {
      // ref.read(userProfileProviderProvider.notifier).state = const AsyncValue.data(null);
    } catch (_) {
      // Provider might not be initialized, ignore
    }

    // Invalidate related providers to update UI
    // Invalidate isLoggedIn first so other providers can check it
    ref.invalidate(isLoggedInProvider);

    // Wait a bit to ensure isLoggedIn is updated before invalidating other providers
    await Future.delayed(const Duration(milliseconds: 50));

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
      // Use the message from DioException (which comes from interceptor with API message)
      // or extract from response data as fallback
      final errorMessage = e.message ??
          _extractErrorMessage(e.response?.data) ??
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
            message:
                e.response?.data?['message'] ?? e.message ?? 'Login failed',
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
    // Check if user is logged in first
    final isLoggedIn = await ref.read(isLoggedInProvider.future);
    if (!isLoggedIn) {
      // User is not logged in, return null without fetching
      return null;
    }

    // Also check if we have an access token - if not, don't fetch
    final accessToken = await ref.read(accessTokenProvider.future);
    if (accessToken == null || accessToken.isEmpty) {
      // No access token, return null without fetching
      return null;
    }

    // Try to load from cache first
    final cachedProfile = await ProfileCacheService.getProfile();
    if (cachedProfile != null) {
      return cachedProfile;
    }

    // If no cache and user is logged in with valid token, fetch from API
    return await fetchProfile();
  }

  Future<UserProfile?> fetchProfile() async {
    // Check if user is logged in before fetching
    final isLoggedIn = await ref.read(isLoggedInProvider.future);
    if (!isLoggedIn) {
      // User is not logged in, return null without making API call
      state = const AsyncValue.data(null);
      return null;
    }

    // Also check if we have an access token - if not, don't fetch
    final accessToken = await ref.read(accessTokenProvider.future);
    if (accessToken == null || accessToken.isEmpty) {
      // No access token, return null without making API call
      state = const AsyncValue.data(null);
      return null;
    }

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
        if (profileResponse.data != null &&
            profileResponse.data!.user != null) {
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
      // Use the message from DioException (which comes from interceptor with API message)
      // or extract from response data as fallback
      final errorMessage = e.message ??
          _extractErrorMessage(e.response?.data) ??
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
    // Check if user is logged in before refreshing
    final isLoggedIn = await ref.read(isLoggedInProvider.future);
    if (!isLoggedIn) {
      // User is not logged in, don't refresh
      return;
    }

    // Also check if we have an access token
    final accessToken = await ref.read(accessTokenProvider.future);
    if (accessToken == null || accessToken.isEmpty) {
      // No access token, don't refresh
      return;
    }

    await fetchProfile();
  }
}

/// Provider to get profile data (includes balance, roleType)
@riverpod
Future<ProfileData?> profileData(ProfileDataRef ref) async {
  // Check if user is logged in first
  final isLoggedIn = await ref.read(isLoggedInProvider.future);
  if (!isLoggedIn) {
    // User is not logged in, return null without fetching
    return null;
  }

  // Try to load from cache first
  final cachedData = await ProfileCacheService.getProfileData();
  if (cachedData != null) {
    return cachedData;
  }

  // If no cache and user is logged in, fetch profile which will cache the data
  final profileNotifier = ref.read(userProfileProviderProvider.notifier);
  await profileNotifier.fetchProfile();

  // Return cached data after fetch
  return await ProfileCacheService.getProfileData();
}

/// Provider to get user balance
@riverpod
Future<double> userBalance(UserBalanceRef ref) async {
  // Check if user is logged in first
  final isLoggedIn = await ref.read(isLoggedInProvider.future);
  if (!isLoggedIn) {
    // User is not logged in, return 0.0
    return 0.0;
  }

  return await ProfileCacheService.getBalance();
}

/// Provider to fetch booth list
@riverpod
class BoothList extends _$BoothList {
  @override
  Future<BoothListResponse?> build() async {
    return null;
  }

  Future<BoothListResponse> fetchBooths({
    int page = 0,
    int size = 100,
  }) async {
    state = const AsyncValue.loading();

    try {
      final dioClient = await ref.read(dioClientProvider.future);

      final request = BoothListRequest(
        page: page,
        size: size,
      );

      final response = await dioClient.postJson(
        ApiEndpoints.boothList,
        data: request.toJson(),
        requiresAuth: true, // Booth list requires authentication
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final boothResponse = BoothListResponse.fromJson(
          response.data is Map<String, dynamic>
              ? response.data
              : {'data': response.data},
        );

        // Check if status is SUCCESS
        if (boothResponse.status == 'SUCCESS') {
          state = AsyncValue.data(boothResponse);
          return boothResponse;
        } else {
          // Handle error response
          final errorMessage =
              boothResponse.message ?? 'Failed to fetch booths';
          throw DioException(
            requestOptions: response.requestOptions,
            response: response,
            type: DioExceptionType.badResponse,
            message: errorMessage,
          );
        }
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          message: 'Failed to fetch booths with status: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      // Use the message from DioException (which comes from interceptor with API message)
      // or extract from response data as fallback
      final errorMessage = e.message ??
          _extractErrorMessage(e.response?.data) ??
          'Failed to fetch booths';

      state = AsyncValue.error(errorMessage, StackTrace.current);
      rethrow;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }
}

/// Provider to register a new member
@riverpod
class MemberRegister extends _$MemberRegister {
  @override
  Future<MemberRegisterResponse?> build() async {
    return null;
  }

  Future<MemberRegisterResponse> registerMember(
      MemberRegisterRequest request) async {
    state = const AsyncValue.loading();

    try {
      final dioClient = await ref.read(dioClientProvider.future);

      final response = await dioClient.postJson(
        ApiEndpoints.memberRegister,
        data: request.toJson(),
        requiresAuth: true, // Member registration requires authentication
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final registerResponse = MemberRegisterResponse.fromJson(
          response.data is Map<String, dynamic>
              ? response.data
              : {'data': response.data},
        );

        // Check if status is SUCCESS
        if (registerResponse.status == 'SUCCESS') {
          state = AsyncValue.data(registerResponse);
          return registerResponse;
        } else {
          // Handle error response
          final errorMessage =
              registerResponse.message ?? 'Failed to register member';
          throw DioException(
            requestOptions: response.requestOptions,
            response: response,
            type: DioExceptionType.badResponse,
            message: errorMessage,
          );
        }
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          message:
              'Failed to register member with status: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      // Use the message from DioException (which comes from interceptor with API message)
      // or extract from response data as fallback
      final errorMessage = e.message ??
          _extractErrorMessage(e.response?.data) ??
          'Failed to register member';

      state = AsyncValue.error(errorMessage, StackTrace.current);
      rethrow;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }
}

/// Provider to delete a member
@riverpod
class MemberDelete extends _$MemberDelete {
  @override
  Future<MemberDeleteResponse?> build() async {
    return null;
  }

  Future<MemberDeleteResponse> deleteMember(String memberId) async {
    state = const AsyncValue.loading();

    try {
      final dioClient = await ref.read(dioClientProvider.future);

      final response = await dioClient.deleteJson(
        ApiEndpoints.deleteMember(memberId),
        requiresAuth: true, // Member deletion requires authentication
      );

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204) {
        final deleteResponse = MemberDeleteResponse.fromJson(
          response.data is Map<String, dynamic>
              ? response.data
              : {'data': response.data},
        );

        // Check if status is SUCCESS
        if (deleteResponse.status == 'SUCCESS') {
          state = AsyncValue.data(deleteResponse);
          return deleteResponse;
        } else {
          // Handle error response
          final errorMessage =
              deleteResponse.message ?? 'Failed to delete member';
          throw DioException(
            requestOptions: response.requestOptions,
            response: response,
            type: DioExceptionType.badResponse,
            message: errorMessage,
          );
        }
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          message:
              'Failed to delete member with status: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      // Use the message from DioException (which comes from interceptor with API message)
      // or extract from response data as fallback
      final errorMessage = e.message ??
          _extractErrorMessage(e.response?.data) ??
          'Failed to delete member';

      state = AsyncValue.error(errorMessage, StackTrace.current);
      rethrow;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }
}

/// Provider to bulk register members from Excel file
@riverpod
class BulkRegister extends _$BulkRegister {
  @override
  Future<BulkRegisterResponse?> build() async {
    return null;
  }

  Future<BulkRegisterResponse> bulkRegisterMembers(String filePath) async {
    state = const AsyncValue.loading();

    try {
      final dioClient = await ref.read(dioClientProvider.future);

      final response = await dioClient.uploadFile(
        ApiEndpoints.bulkRegister,
        filePath,
        fileKey: 'file',
        requiresAuth: true, // Bulk register requires authentication
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final bulkResponse = BulkRegisterResponse.fromJson(
          response.data is Map<String, dynamic>
              ? response.data
              : {'data': response.data},
        );

        // Check if status is SUCCESS
        if (bulkResponse.status == 'SUCCESS') {
          state = AsyncValue.data(bulkResponse);
          return bulkResponse;
        } else {
          // Handle error response
          final errorMessage =
              bulkResponse.message ?? 'Failed to bulk register members';
          throw DioException(
            requestOptions: response.requestOptions,
            response: response,
            type: DioExceptionType.badResponse,
            message: errorMessage,
          );
        }
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          message:
              'Failed to bulk register members with status: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      // Use the message from DioException (which comes from interceptor with API message)
      // or extract from response data as fallback
      final errorMessage = e.message ??
          _extractErrorMessage(e.response?.data) ??
          'Failed to bulk register members';

      state = AsyncValue.error(errorMessage, StackTrace.current);
      rethrow;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }
}

/// Provider to create content
@riverpod
class ContentCreate extends _$ContentCreate {
  @override
  Future<ContentCreateResponse?> build() async {
    return null;
  }

  Future<ContentCreateResponse> createContent(
      ContentCreateRequest request) async {
    state = const AsyncValue.loading();

    try {
      final dioClient = await ref.read(dioClientProvider.future);

      final response = await dioClient.postJson(
        ApiEndpoints.contentCreate,
        data: request.toJson(),
        requiresAuth: true, // Content creation requires authentication
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final contentResponse = ContentCreateResponse.fromJson(
          response.data is Map<String, dynamic>
              ? response.data
              : {'data': response.data},
        );

        // Check if status is SUCCESS
        if (contentResponse.status == 'SUCCESS') {
          state = AsyncValue.data(contentResponse);
          return contentResponse;
        } else {
          // Handle error response
          final errorMessage =
              contentResponse.message ?? 'Failed to create content';
          throw DioException(
            requestOptions: response.requestOptions,
            response: response,
            type: DioExceptionType.badResponse,
            message: errorMessage,
          );
        }
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          message:
              'Failed to create content with status: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      // Use the message from DioException (which comes from interceptor with API message)
      // or extract from response data as fallback
      final errorMessage = e.message ??
          _extractErrorMessage(e.response?.data) ??
          'Failed to create content';

      state = AsyncValue.error(errorMessage, StackTrace.current);
      rethrow;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }
}

/// Provider to fetch contents list
@riverpod
class ContentsList extends _$ContentsList {
  @override
  Future<ContentsListResponse?> build() async {
    return null;
  }

  Future<ContentsListResponse> fetchContents({
    int page = 0,
    int size = 10,
  }) async {
    state = const AsyncValue.loading();

    try {
      final dioClient = await ref.read(dioClientProvider.future);

      final request = ContentsListRequest(
        page: page,
        size: size,
        // search: search,
        // sortBy: sortBy,
        // sortDirection: sortDirection,
      );

      final response = await dioClient.postJson(
        ApiEndpoints.contentsList,
        data: request.toJson(),
        requiresAuth: true,
      );

      if (response.statusCode == 200) {
        final contentsResponse = ContentsListResponse.fromJson(
          response.data is Map<String, dynamic>
              ? response.data
              : {'data': response.data},
        );

        // Check if status is SUCCESS
        if (contentsResponse.status == 'SUCCESS') {
          state = AsyncValue.data(contentsResponse);
          return contentsResponse;
        } else {
          // Handle error response
          final errorMessage =
              contentsResponse.message ?? 'Failed to fetch contents';
          throw DioException(
            requestOptions: response.requestOptions,
            response: response,
            type: DioExceptionType.badResponse,
            message: errorMessage,
          );
        }
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          message:
              'Failed to fetch contents with status: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      // Use the message from DioException (which comes from interceptor with API message)
      // or extract from response data as fallback
      final errorMessage = e.message ??
          _extractErrorMessage(e.response?.data) ??
          'Failed to fetch contents';

      state = AsyncValue.error(errorMessage, StackTrace.current);
      rethrow;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }
}

/// Helper function to extract error message from API response data
String? _extractErrorMessage(dynamic responseData) {
  if (responseData == null) return null;

  if (responseData is Map<String, dynamic>) {
    // Try common error message fields
    final message = responseData['message'] as String? ??
        responseData['error'] as String? ??
        responseData['errorMessage'] as String? ??
        responseData['msg'] as String?;

    if (message != null && message.isNotEmpty) {
      return message;
    }

    // If message is a list, join it
    if (responseData['message'] is List) {
      final messages = responseData['message'] as List;
      if (messages.isNotEmpty) {
        return messages.map((e) => e.toString()).join(', ');
      }
    }

    // Check for nested error objects
    if (responseData['error'] is Map) {
      final errorObj = responseData['error'] as Map;
      return errorObj['message'] as String? ?? errorObj['error'] as String?;
    }
  } else if (responseData is String) {
    return responseData;
  }

  return null;
}

/// Provider to fetch members list
@riverpod
class MembersList extends _$MembersList {
  @override
  Future<MembersListResponse?> build() async {
    return null;
  }

  Future<MembersListResponse> fetchMembers({
    int page = 0,
    int size = 100,
  }) async {
    state = const AsyncValue.loading();

    try {
      final dioClient = await ref.read(dioClientProvider.future);

      final request = MembersListRequest(
        page: page,
        size: size,
      );

      final response = await dioClient.postJson(
        ApiEndpoints.membersList,
        data: request.toJson(),
        requiresAuth: true, // Members list requires authentication
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final membersResponse = MembersListResponse.fromJson(
          response.data is Map<String, dynamic>
              ? response.data
              : {'data': response.data},
        );

        // Check if status is SUCCESS
        if (membersResponse.status == 'SUCCESS') {
          state = AsyncValue.data(membersResponse);
          return membersResponse;
        } else {
          // Handle error response
          final errorMessage =
              membersResponse.message ?? 'Failed to fetch members';
          throw DioException(
            requestOptions: response.requestOptions,
            response: response,
            type: DioExceptionType.badResponse,
            message: errorMessage,
          );
        }
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          message:
              'Failed to fetch members with status: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      // Use the message from DioException (which comes from interceptor with API message)
      // or extract from response data as fallback
      final errorMessage = e.message ??
          _extractErrorMessage(e.response?.data) ??
          'Failed to fetch members';

      state = AsyncValue.error(errorMessage, StackTrace.current);
      rethrow;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }
}

/// Provider for fetching push notifications list
@riverpod
class PushNotificationsList extends _$PushNotificationsList {
  @override
  Future<PushNotificationsListResponse?> build() async {
    return null;
  }

  Future<PushNotificationsListResponse> fetchPushNotifications({
    int page = 0,
    int size = 10,
  }) async {
    state = const AsyncValue.loading();

    try {
      final dioClient = await ref.read(dioClientProvider.future);

      final request = PushNotificationsListRequest(
        page: page,
        size: size,
      );

      final response = await dioClient.postJson(
        ApiEndpoints.pushNotificationsList,
        data: request.toJson(),
        requiresAuth: true, // Push notifications list requires authentication
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final pushNotificationsResponse =
            PushNotificationsListResponse.fromJson(
          response.data is Map<String, dynamic>
              ? response.data
              : {'data': response.data},
        );

        // Check if status is SUCCESS
        if (pushNotificationsResponse.status == 'SUCCESS') {
          state = AsyncValue.data(pushNotificationsResponse);
          return pushNotificationsResponse;
        } else {
          // Handle error response
          final errorMessage = pushNotificationsResponse.message ??
              'Failed to fetch push notifications';
          throw DioException(
            requestOptions: response.requestOptions,
            response: response,
            type: DioExceptionType.badResponse,
            message: errorMessage,
          );
        }
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          message:
              'Failed to fetch push notifications with status: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      // Use the message from DioException (which comes from interceptor with API message)
      // or extract from response data as fallback
      final errorMessage = e.message ??
          _extractErrorMessage(e.response?.data) ??
          'Failed to fetch push notifications';

      state = AsyncValue.error(errorMessage, StackTrace.current);
      rethrow;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }
}

/// Provider for fetching packages list
@riverpod
class PackagesList extends _$PackagesList {
  @override
  Future<PackagesListResponse?> build() async {
    return null;
  }

  Future<PackagesListResponse> fetchPackages({
    int page = 0,
    int size = 10,
  }) async {
    state = const AsyncValue.loading();

    try {
      final dioClient = await ref.read(dioClientProvider.future);

      final request = PackagesListRequest(
        page: page,
        size: size,
      );

      final response = await dioClient.postJson(
        ApiEndpoints.packagesList,
        data: request.toJson(),
        requiresAuth: true, // Packages list requires authentication
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final packagesResponse = PackagesListResponse.fromJson(
          response.data is Map<String, dynamic>
              ? response.data
              : {'data': response.data},
        );

        // Check if status is SUCCESS
        if (packagesResponse.status == 'SUCCESS') {
          state = AsyncValue.data(packagesResponse);
          return packagesResponse;
        } else {
          // Handle error response
          final errorMessage =
              packagesResponse.message ?? 'Failed to fetch packages';
          throw DioException(
            requestOptions: response.requestOptions,
            response: response,
            type: DioExceptionType.badResponse,
            message: errorMessage,
          );
        }
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          message:
              'Failed to fetch packages with status: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      // Use the message from DioException (which comes from interceptor with API message)
      // or extract from response data as fallback
      final errorMessage = e.message ??
          _extractErrorMessage(e.response?.data) ??
          'Failed to fetch packages';

      state = AsyncValue.error(errorMessage, StackTrace.current);
      rethrow;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }
}

/// Provider for fetching bank information
@riverpod
class BankInfoProvider extends _$BankInfoProvider {
  @override
  Future<BankInfoResponse?> build() async {
    return null;
  }

  Future<BankInfoResponse> fetchBankInfo() async {
    state = const AsyncValue.loading();

    try {
      final dioClient = await ref.read(dioClientProvider.future);

      final response = await dioClient.get(
        ApiEndpoints.bankInfo,
        requiresAuth: true, // Bank info requires authentication
      );

      if (response.statusCode == 200) {
        final bankInfoResponse = BankInfoResponse.fromJson(
          response.data is Map<String, dynamic>
              ? response.data
              : {'data': response.data},
        );

        // Check if status is SUCCESS
        if (bankInfoResponse.status == 'SUCCESS') {
          state = AsyncValue.data(bankInfoResponse);
          return bankInfoResponse;
        } else {
          // Handle error response
          final errorMessage =
              bankInfoResponse.message ?? 'Failed to fetch bank information';
          throw DioException(
            requestOptions: response.requestOptions,
            response: response,
            type: DioExceptionType.badResponse,
            message: errorMessage,
          );
        }
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          message:
              'Failed to fetch bank information with status: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      // Use the message from DioException (which comes from interceptor with API message)
      // or extract from response data as fallback
      final errorMessage = e.message ??
          _extractErrorMessage(e.response?.data) ??
          'Failed to fetch bank information';

      state = AsyncValue.error(errorMessage, StackTrace.current);
      rethrow;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }
}
