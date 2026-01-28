// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contents_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ContentItemImpl _$$ContentItemImplFromJson(Map<String, dynamic> json) =>
    _$ContentItemImpl(
      aiPrompt: json['aiPrompt'] as String?,
      contentType: json['contentType'] as String?,
      createdAt: json['createdAt'] as String?,
      id: json['id'] as String?,
      imageUrl: json['imageUrl'] as String?,
      isPublished: json['isPublished'] as bool?,
      lastModifiedAt: json['lastModifiedAt'] as String?,
      partyId: json['partyId'] as String?,
      partyName: json['partyName'] as String?,
      textContent: json['textContent'] as String?,
      title: json['title'] as String?,
    );

Map<String, dynamic> _$$ContentItemImplToJson(_$ContentItemImpl instance) =>
    <String, dynamic>{
      'aiPrompt': instance.aiPrompt,
      'contentType': instance.contentType,
      'createdAt': instance.createdAt,
      'id': instance.id,
      'imageUrl': instance.imageUrl,
      'isPublished': instance.isPublished,
      'lastModifiedAt': instance.lastModifiedAt,
      'partyId': instance.partyId,
      'partyName': instance.partyName,
      'textContent': instance.textContent,
      'title': instance.title,
    };

_$ContentsListDataImpl _$$ContentsListDataImplFromJson(
        Map<String, dynamic> json) =>
    _$ContentsListDataImpl(
      content: (json['content'] as List<dynamic>?)
          ?.map((e) => ContentItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalElements: (json['totalElements'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$ContentsListDataImplToJson(
        _$ContentsListDataImpl instance) =>
    <String, dynamic>{
      'content': instance.content,
      'totalElements': instance.totalElements,
    };

_$ContentsListResponseImpl _$$ContentsListResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$ContentsListResponseImpl(
      status: json['status'] as String?,
      code: json['code'] as String?,
      data: json['data'] == null
          ? null
          : ContentsListData.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$$ContentsListResponseImplToJson(
        _$ContentsListResponseImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'data': instance.data,
      'message': instance.message,
    };
