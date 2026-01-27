// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_info_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BankInfoImpl _$$BankInfoImplFromJson(Map<String, dynamic> json) =>
    _$BankInfoImpl(
      accountNumber: json['accountNumber'] as String?,
      branch: json['branch'] as String?,
      createdAt: json['createdAt'] as String?,
      id: json['id'] as String?,
      lastModifiedAt: json['lastModifiedAt'] as String?,
      name: json['name'] as String?,
      qrCode: json['qrCode'] as String?,
    );

Map<String, dynamic> _$$BankInfoImplToJson(_$BankInfoImpl instance) =>
    <String, dynamic>{
      'accountNumber': instance.accountNumber,
      'branch': instance.branch,
      'createdAt': instance.createdAt,
      'id': instance.id,
      'lastModifiedAt': instance.lastModifiedAt,
      'name': instance.name,
      'qrCode': instance.qrCode,
    };

_$BankInfoResponseImpl _$$BankInfoResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$BankInfoResponseImpl(
      status: json['status'] as String?,
      code: json['code'] as String?,
      data: json['data'] == null
          ? null
          : BankInfo.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$$BankInfoResponseImplToJson(
        _$BankInfoResponseImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'data': instance.data,
      'message': instance.message,
    };
