// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_create_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ContentCreateRequestImpl _$$ContentCreateRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$ContentCreateRequestImpl(
      contentType: json['contentType'] as String,
      title: json['title'] as String,
      textContent: json['textContent'] as String,
      imageBase64: json['imageBase64'] as String?,
      imageFilename: json['imageFilename'] as String?,
      aiPrompt: json['aiPrompt'] as String?,
    );

Map<String, dynamic> _$$ContentCreateRequestImplToJson(
        _$ContentCreateRequestImpl instance) =>
    <String, dynamic>{
      'contentType': instance.contentType,
      'title': instance.title,
      'textContent': instance.textContent,
      'imageBase64': instance.imageBase64,
      'imageFilename': instance.imageFilename,
      'aiPrompt': instance.aiPrompt,
    };
