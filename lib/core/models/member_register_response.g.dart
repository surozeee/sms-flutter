// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_register_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MemberRegisterResponseImpl _$$MemberRegisterResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$MemberRegisterResponseImpl(
      status: json['status'] as String?,
      code: json['code'] as String?,
      data: json['data'] == null
          ? null
          : Member.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$$MemberRegisterResponseImplToJson(
        _$MemberRegisterResponseImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'data': instance.data,
      'message': instance.message,
    };
