// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booth_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BoothImpl _$$BoothImplFromJson(Map<String, dynamic> json) => _$BoothImpl(
      createdAt: json['createdAt'] as String?,
      id: json['id'] as String?,
      lastModifiedAt: json['lastModifiedAt'] as String?,
      name: json['name'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$$BoothImplToJson(_$BoothImpl instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt,
      'id': instance.id,
      'lastModifiedAt': instance.lastModifiedAt,
      'name': instance.name,
      'status': instance.status,
    };

_$BoothListDataImpl _$$BoothListDataImplFromJson(Map<String, dynamic> json) =>
    _$BoothListDataImpl(
      content: (json['content'] as List<dynamic>?)
          ?.map((e) => Booth.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalElements: (json['totalElements'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$BoothListDataImplToJson(_$BoothListDataImpl instance) =>
    <String, dynamic>{
      'content': instance.content,
      'totalElements': instance.totalElements,
    };

_$BoothListResponseImpl _$$BoothListResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$BoothListResponseImpl(
      status: json['status'] as String?,
      code: json['code'] as String?,
      data: json['data'] == null
          ? null
          : BoothListData.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$$BoothListResponseImplToJson(
        _$BoothListResponseImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'data': instance.data,
      'message': instance.message,
    };
