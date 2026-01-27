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
String _$logoutHash() => r'0bbcc3a48a6f21a56fa1f43516b3a72a1154d678';

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
String _$registerHash() => r'e65211df080eee9922013f4a352ef8f16054f680';

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
    r'8658917e53bf3c84bb4b700cd17b67b4936a6929';

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
String _$boothListHash() => r'ee81bf26ee8f15f9673b123bc7e1f25c7083495b';

/// Provider to fetch booth list
///
/// Copied from [BoothList].
@ProviderFor(BoothList)
final boothListProvider =
    AutoDisposeAsyncNotifierProvider<BoothList, BoothListResponse?>.internal(
  BoothList.new,
  name: r'boothListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$boothListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$BoothList = AutoDisposeAsyncNotifier<BoothListResponse?>;
String _$memberRegisterHash() => r'd6ff29d465e2a366ae118db7c33c0b17f75e0991';

/// Provider to register a new member
///
/// Copied from [MemberRegister].
@ProviderFor(MemberRegister)
final memberRegisterProvider = AutoDisposeAsyncNotifierProvider<MemberRegister,
    MemberRegisterResponse?>.internal(
  MemberRegister.new,
  name: r'memberRegisterProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$memberRegisterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$MemberRegister = AutoDisposeAsyncNotifier<MemberRegisterResponse?>;
String _$memberDeleteHash() => r'a84407dec4cfcac154c1a50b555e2083f77932d7';

/// Provider to delete a member
///
/// Copied from [MemberDelete].
@ProviderFor(MemberDelete)
final memberDeleteProvider = AutoDisposeAsyncNotifierProvider<MemberDelete,
    MemberDeleteResponse?>.internal(
  MemberDelete.new,
  name: r'memberDeleteProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$memberDeleteHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$MemberDelete = AutoDisposeAsyncNotifier<MemberDeleteResponse?>;
String _$bulkRegisterHash() => r'8dcdcfc9a73fb69ef639c718138a4108813177f0';

/// Provider to bulk register members from Excel file
///
/// Copied from [BulkRegister].
@ProviderFor(BulkRegister)
final bulkRegisterProvider = AutoDisposeAsyncNotifierProvider<BulkRegister,
    BulkRegisterResponse?>.internal(
  BulkRegister.new,
  name: r'bulkRegisterProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$bulkRegisterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$BulkRegister = AutoDisposeAsyncNotifier<BulkRegisterResponse?>;
String _$contentCreateHash() => r'413001219d1de422dcb581711abfb6b6c49b07a9';

/// Provider to create content
///
/// Copied from [ContentCreate].
@ProviderFor(ContentCreate)
final contentCreateProvider = AutoDisposeAsyncNotifierProvider<ContentCreate,
    ContentCreateResponse?>.internal(
  ContentCreate.new,
  name: r'contentCreateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$contentCreateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ContentCreate = AutoDisposeAsyncNotifier<ContentCreateResponse?>;
String _$membersListHash() => r'5ae06cd2bfb5f962e0f0bd9f02b83445cce54349';

/// Provider to fetch members list
///
/// Copied from [MembersList].
@ProviderFor(MembersList)
final membersListProvider = AutoDisposeAsyncNotifierProvider<MembersList,
    MembersListResponse?>.internal(
  MembersList.new,
  name: r'membersListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$membersListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$MembersList = AutoDisposeAsyncNotifier<MembersListResponse?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
