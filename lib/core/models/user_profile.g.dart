// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserProfileImpl _$$UserProfileImplFromJson(Map<String, dynamic> json) =>
    _$UserProfileImpl(
      id: json['id'] as String,
      emailAddress: json['emailAddress'] as String?,
      mobileNumber: json['mobileNumber'] as String?,
      fullName: json['fullName'] as String?,
      roleName: json['roleName'] as String?,
      roleType: json['roleType'] as String?,
      profilePictureUrl: json['profilePictureUrl'] as String?,
      dateOfBirth: json['dateOfBirth'] as String?,
      gender: json['gender'] as String?,
      addressLine1: json['addressLine1'] as String?,
      addressLine2: json['addressLine2'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      country: json['country'] as String?,
      userStatus: json['userStatus'] as String?,
      createdAt: json['createdAt'] as String?,
      lastModifiedAt: json['lastModifiedAt'] as String?,
      lastLoginDate: json['lastLoginDate'] as String?,
      accountNonExpired: json['accountNonExpired'] as bool?,
      accountNonLocked: json['accountNonLocked'] as bool?,
      credentialsNonExpired: json['credentialsNonExpired'] as bool?,
      enabled: json['enabled'] as bool?,
    );

Map<String, dynamic> _$$UserProfileImplToJson(_$UserProfileImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'emailAddress': instance.emailAddress,
      'mobileNumber': instance.mobileNumber,
      'fullName': instance.fullName,
      'roleName': instance.roleName,
      'roleType': instance.roleType,
      'profilePictureUrl': instance.profilePictureUrl,
      'dateOfBirth': instance.dateOfBirth,
      'gender': instance.gender,
      'addressLine1': instance.addressLine1,
      'addressLine2': instance.addressLine2,
      'city': instance.city,
      'state': instance.state,
      'country': instance.country,
      'userStatus': instance.userStatus,
      'createdAt': instance.createdAt,
      'lastModifiedAt': instance.lastModifiedAt,
      'lastLoginDate': instance.lastLoginDate,
      'accountNonExpired': instance.accountNonExpired,
      'accountNonLocked': instance.accountNonLocked,
      'credentialsNonExpired': instance.credentialsNonExpired,
      'enabled': instance.enabled,
    };

_$ProfileDataImpl _$$ProfileDataImplFromJson(Map<String, dynamic> json) =>
    _$ProfileDataImpl(
      balance: (json['balance'] as num?)?.toDouble(),
      roleType: json['roleType'] as String?,
      user: json['user'] == null
          ? null
          : UserProfile.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ProfileDataImplToJson(_$ProfileDataImpl instance) =>
    <String, dynamic>{
      'balance': instance.balance,
      'roleType': instance.roleType,
      'user': instance.user,
    };

_$ProfileResponseImpl _$$ProfileResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$ProfileResponseImpl(
      status: json['status'] as String?,
      code: json['code'] as String?,
      data: json['data'] == null
          ? null
          : ProfileData.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$$ProfileResponseImplToJson(
        _$ProfileResponseImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'data': instance.data,
      'message': instance.message,
    };
