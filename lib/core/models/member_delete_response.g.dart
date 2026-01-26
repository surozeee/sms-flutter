// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_delete_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MemberDeleteResponseImpl _$$MemberDeleteResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$MemberDeleteResponseImpl(
      status: json['status'] as String,
      code: json['code'] as String,
      data: json['data'] as String?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$$MemberDeleteResponseImplToJson(
        _$MemberDeleteResponseImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'data': instance.data,
      'message': instance.message,
    };
