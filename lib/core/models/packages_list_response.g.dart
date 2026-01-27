// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'packages_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PackageImpl _$$PackageImplFromJson(Map<String, dynamic> json) =>
    _$PackageImpl(
      createdAt: json['createdAt'] as String?,
      description: json['description'] as String?,
      discount: (json['discount'] as num?)?.toDouble(),
      discountType: json['discountType'] as String?,
      id: json['id'] as String?,
      isActive: json['isActive'] as bool?,
      lastModifiedAt: json['lastModifiedAt'] as String?,
      packageName: json['packageName'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      smsAmount: (json['smsAmount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$PackageImplToJson(_$PackageImpl instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt,
      'description': instance.description,
      'discount': instance.discount,
      'discountType': instance.discountType,
      'id': instance.id,
      'isActive': instance.isActive,
      'lastModifiedAt': instance.lastModifiedAt,
      'packageName': instance.packageName,
      'price': instance.price,
      'smsAmount': instance.smsAmount,
    };

_$PackagesListDataImpl _$$PackagesListDataImplFromJson(
        Map<String, dynamic> json) =>
    _$PackagesListDataImpl(
      content: (json['content'] as List<dynamic>?)
          ?.map((e) => Package.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalElements: (json['totalElements'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$PackagesListDataImplToJson(
        _$PackagesListDataImpl instance) =>
    <String, dynamic>{
      'content': instance.content,
      'totalElements': instance.totalElements,
    };

_$PackagesListResponseImpl _$$PackagesListResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$PackagesListResponseImpl(
      status: json['status'] as String?,
      code: json['code'] as String?,
      data: json['data'] == null
          ? null
          : PackagesListData.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$$PackagesListResponseImplToJson(
        _$PackagesListResponseImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'data': instance.data,
      'message': instance.message,
    };
