// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'balance_load_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BalanceLoadRequestImpl _$$BalanceLoadRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$BalanceLoadRequestImpl(
      amount: (json['amount'] as num).toDouble(),
      description: json['description'] as String,
      document: json['document'] as String,
      packageId: json['packageId'] as String,
    );

Map<String, dynamic> _$$BalanceLoadRequestImplToJson(
        _$BalanceLoadRequestImpl instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'description': instance.description,
      'document': instance.document,
      'packageId': instance.packageId,
    };
