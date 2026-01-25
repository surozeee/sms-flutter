// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RegisterRequestImpl _$$RegisterRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$RegisterRequestImpl(
      emailAddress: json['emailAddress'] as String,
      mobileNumber: json['mobileNumber'] as String,
      password: json['password'] as String,
      role: json['role'] as String,
      fullName: json['fullName'] as String,
    );

Map<String, dynamic> _$$RegisterRequestImplToJson(
        _$RegisterRequestImpl instance) =>
    <String, dynamic>{
      'emailAddress': instance.emailAddress,
      'mobileNumber': instance.mobileNumber,
      'password': instance.password,
      'role': instance.role,
      'fullName': instance.fullName,
    };
