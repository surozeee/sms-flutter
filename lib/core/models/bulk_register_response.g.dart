// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bulk_register_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BulkRegisterResponseImpl _$$BulkRegisterResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$BulkRegisterResponseImpl(
      status: json['status'] as String?,
      code: json['code'] as String?,
      data: json['data'],
      message: json['message'] as String?,
    );

Map<String, dynamic> _$$BulkRegisterResponseImplToJson(
        _$BulkRegisterResponseImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'data': instance.data,
      'message': instance.message,
    };
