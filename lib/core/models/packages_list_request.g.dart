// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'packages_list_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PackagesListRequestImpl _$$PackagesListRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$PackagesListRequestImpl(
      page: (json['page'] as num).toInt(),
      size: (json['size'] as num).toInt(),
    );

Map<String, dynamic> _$$PackagesListRequestImplToJson(
        _$PackagesListRequestImpl instance) =>
    <String, dynamic>{
      'page': instance.page,
      'size': instance.size,
    };
