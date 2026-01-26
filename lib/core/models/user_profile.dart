import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile.freezed.dart';
part 'user_profile.g.dart';

@freezed
class UserProfile with _$UserProfile {
  const factory UserProfile({
    required String id,
    @JsonKey(name: 'emailAddress') String? emailAddress,
    @JsonKey(name: 'mobileNumber') String? mobileNumber,
    @JsonKey(name: 'fullName') String? fullName,
    @JsonKey(name: 'roleName') String? roleName,
    @JsonKey(name: 'roleType') String? roleType,
    @JsonKey(name: 'profilePictureUrl') String? profilePictureUrl,
    @JsonKey(name: 'dateOfBirth') String? dateOfBirth,
    @JsonKey(name: 'gender') String? gender,
    @JsonKey(name: 'addressLine1') String? addressLine1,
    @JsonKey(name: 'addressLine2') String? addressLine2,
    @JsonKey(name: 'city') String? city,
    @JsonKey(name: 'state') String? state,
    @JsonKey(name: 'country') String? country,
    @JsonKey(name: 'userStatus') String? userStatus,
    @JsonKey(name: 'createdAt') String? createdAt,
    @JsonKey(name: 'lastModifiedAt') String? lastModifiedAt,
    @JsonKey(name: 'lastLoginDate') String? lastLoginDate,
    @JsonKey(name: 'accountNonExpired') bool? accountNonExpired,
    @JsonKey(name: 'accountNonLocked') bool? accountNonLocked,
    @JsonKey(name: 'credentialsNonExpired') bool? credentialsNonExpired,
    @JsonKey(name: 'enabled') bool? enabled,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);
}

@freezed
class ProfileData with _$ProfileData {
  const factory ProfileData({
    double? balance,
    @JsonKey(name: 'roleType') String? roleType,
    UserProfile? user,
  }) = _ProfileData;

  factory ProfileData.fromJson(Map<String, dynamic> json) =>
      _$ProfileDataFromJson(json);
}

@freezed
class ProfileResponse with _$ProfileResponse {
  const factory ProfileResponse({
    String? status,
    String? code,
    ProfileData? data,
    String? message,
  }) = _ProfileResponse;

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfileResponseFromJson(json);
}
