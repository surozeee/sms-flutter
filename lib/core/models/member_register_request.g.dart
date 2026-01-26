// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_register_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MemberRegisterRequestImpl _$$MemberRegisterRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$MemberRegisterRequestImpl(
      fullName: json['fullName'] as String,
      mobileNumber: json['mobileNumber'] as String,
      boothName: json['boothName'] as String,
    );

Map<String, dynamic> _$$MemberRegisterRequestImplToJson(
        _$MemberRegisterRequestImpl instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'mobileNumber': instance.mobileNumber,
      'boothName': instance.boothName,
    };
