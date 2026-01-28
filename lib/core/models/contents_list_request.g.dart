// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contents_list_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ContentsListRequestImpl _$$ContentsListRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$ContentsListRequestImpl(
      page: (json['page'] as num).toInt(),
      size: (json['size'] as num).toInt(),
    );

Map<String, dynamic> _$$ContentsListRequestImplToJson(
        _$ContentsListRequestImpl instance) =>
    <String, dynamic>{
      'page': instance.page,
      'size': instance.size,
    };
