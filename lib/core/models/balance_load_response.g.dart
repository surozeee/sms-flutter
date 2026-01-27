// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'balance_load_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BalanceLoadResponseImpl _$$BalanceLoadResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$BalanceLoadResponseImpl(
      status: json['status'] as String?,
      code: json['code'] as String?,
      data: json['data'],
      message: json['message'] as String?,
    );

Map<String, dynamic> _$$BalanceLoadResponseImplToJson(
        _$BalanceLoadResponseImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'data': instance.data,
      'message': instance.message,
    };
