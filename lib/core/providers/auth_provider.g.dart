// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dioClientHash() => r'1ef6e4a0d8a8ff82eed1e9e3a1acc42158ff345c';

/// See also [dioClient].
@ProviderFor(dioClient)
final dioClientProvider = AutoDisposeFutureProvider<DioClient>.internal(
  dioClient,
  name: r'dioClientProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$dioClientHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DioClientRef = AutoDisposeFutureProviderRef<DioClient>;
String _$isLoggedInHash() => r'2183b76ff72dd653c8de9a65d48942d69ac27a4d';

/// Provider to check if user is logged in
///
/// Copied from [isLoggedIn].
@ProviderFor(isLoggedIn)
final isLoggedInProvider = AutoDisposeFutureProvider<bool>.internal(
  isLoggedIn,
  name: r'isLoggedInProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$isLoggedInHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IsLoggedInRef = AutoDisposeFutureProviderRef<bool>;
String _$userTypeHash() => r'457d3579494e0a9801e0bbf771e61de42166abc0';

/// Provider to get cached user type
///
/// Copied from [userType].
@ProviderFor(userType)
final userTypeProvider = AutoDisposeFutureProvider<String?>.internal(
  userType,
  name: r'userTypeProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userTypeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UserTypeRef = AutoDisposeFutureProviderRef<String?>;
String _$accessTokenHash() => r'25a45cb8676bc79cef13b6bc9d5ff3721f66ee35';

/// Provider to get cached access token
///
/// Copied from [accessToken].
@ProviderFor(accessToken)
final accessTokenProvider = AutoDisposeFutureProvider<String?>.internal(
  accessToken,
  name: r'accessTokenProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$accessTokenHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AccessTokenRef = AutoDisposeFutureProviderRef<String?>;
String _$refreshTokenHash() => r'52de12f25fe342077aa45ef4d8cb12a307352001';

/// Provider to get cached refresh token
///
/// Copied from [refreshToken].
@ProviderFor(refreshToken)
final refreshTokenProvider = AutoDisposeFutureProvider<String?>.internal(
  refreshToken,
  name: r'refreshTokenProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$refreshTokenHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RefreshTokenRef = AutoDisposeFutureProviderRef<String?>;
String _$loginDataHash() => r'1b2fd519b047ac1c328c92410b29be7b98ee1294';

/// Provider to get all cached login data
///
/// Copied from [loginData].
@ProviderFor(loginData)
final loginDataProvider =
    AutoDisposeFutureProvider<Map<String, String?>>.internal(
  loginData,
  name: r'loginDataProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$loginDataHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LoginDataRef = AutoDisposeFutureProviderRef<Map<String, String?>>;
String _$profileDataHash() => r'34a317c3fb9caa472a5d813f35e9aece9a0c4c27';

/// Provider to get profile data (includes balance, roleType)
///
/// Copied from [profileData].
@ProviderFor(profileData)
final profileDataProvider = AutoDisposeFutureProvider<ProfileData?>.internal(
  profileData,
  name: r'profileDataProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$profileDataHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ProfileDataRef = AutoDisposeFutureProviderRef<ProfileData?>;
String _$userBalanceHash() => r'5f0af99377843bcdc4a9247c3e5278ea58803eb5';

/// Provider to get user balance
///
/// Copied from [userBalance].
@ProviderFor(userBalance)
final userBalanceProvider = AutoDisposeFutureProvider<double>.internal(
  userBalance,
  name: r'userBalanceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userBalanceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UserBalanceRef = AutoDisposeFutureProviderRef<double>;
String _$logoutHash() => r'5294a30df50bfaf73d9bbd9468a923fd9821325c';

/// Provider for logout functionality
///
/// Copied from [Logout].
@ProviderFor(Logout)
final logoutProvider = AutoDisposeAsyncNotifierProvider<Logout, void>.internal(
  Logout.new,
  name: r'logoutProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$logoutHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Logout = AutoDisposeAsyncNotifier<void>;
String _$registerHash() => r'1c1d9d40d79dc89ed39f57c0e9f7a461ce27268b';

/// See also [Register].
@ProviderFor(Register)
final registerProvider =
    AutoDisposeAsyncNotifierProvider<Register, RegisterResponse?>.internal(
  Register.new,
  name: r'registerProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$registerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Register = AutoDisposeAsyncNotifier<RegisterResponse?>;
String _$loginHash() => r'e9e1d0f00fdb65f3f3c689f46e864bec3adfa243';

/// See also [Login].
@ProviderFor(Login)
final loginProvider =
    AutoDisposeAsyncNotifierProvider<Login, LoginResponse?>.internal(
  Login.new,
  name: r'loginProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$loginHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Login = AutoDisposeAsyncNotifier<LoginResponse?>;
String _$userProfileProviderHash() =>
    r'5877af140718d5bb087e605a99ab418fcea52567';

/// Provider to fetch and cache user profile
///
/// Copied from [UserProfileProvider].
@ProviderFor(UserProfileProvider)
final userProfileProviderProvider = AutoDisposeAsyncNotifierProvider<
    UserProfileProvider, UserProfile?>.internal(
  UserProfileProvider.new,
  name: r'userProfileProviderProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$userProfileProviderHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$UserProfileProvider = AutoDisposeAsyncNotifier<UserProfile?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
