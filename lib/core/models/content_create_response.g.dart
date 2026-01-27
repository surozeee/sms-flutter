// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_create_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ContentCreateResponseImpl _$$ContentCreateResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$ContentCreateResponseImpl(
      status: json['status'] as String?,
      code: json['code'] as String?,
      data: json['data'],
      message: json['message'] as String?,
    );

Map<String, dynamic> _$$ContentCreateResponseImplToJson(
        _$ContentCreateResponseImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'data': instance.data,
      'message': instance.message,
    };
