// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'push_notifications_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PushNotificationImpl _$$PushNotificationImplFromJson(
        Map<String, dynamic> json) =>
    _$PushNotificationImpl(
      id: json['id'] as String?,
      title: json['title'] as String?,
      message: json['message'] as String?,
      imageUrl: json['imageUrl'] as String?,
      notificationType: json['notificationType'] as String?,
      partyId: json['partyId'] as String?,
      partyName: json['partyName'] as String?,
      boothId: json['boothId'] as String?,
      boothName: json['boothName'] as String?,
      recipientCount: (json['recipientCount'] as num?)?.toInt(),
      successCount: (json['successCount'] as num?)?.toInt(),
      failureCount: (json['failureCount'] as num?)?.toInt(),
      status: json['status'] as String?,
      errorMessage: json['errorMessage'] as String?,
      createdAt: json['createdAt'] as String?,
      lastModifiedAt: json['lastModifiedAt'] as String?,
    );

Map<String, dynamic> _$$PushNotificationImplToJson(
        _$PushNotificationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'message': instance.message,
      'imageUrl': instance.imageUrl,
      'notificationType': instance.notificationType,
      'partyId': instance.partyId,
      'partyName': instance.partyName,
      'boothId': instance.boothId,
      'boothName': instance.boothName,
      'recipientCount': instance.recipientCount,
      'successCount': instance.successCount,
      'failureCount': instance.failureCount,
      'status': instance.status,
      'errorMessage': instance.errorMessage,
      'createdAt': instance.createdAt,
      'lastModifiedAt': instance.lastModifiedAt,
    };

_$PushNotificationsListDataImpl _$$PushNotificationsListDataImplFromJson(
        Map<String, dynamic> json) =>
    _$PushNotificationsListDataImpl(
      content: (json['content'] as List<dynamic>?)
          ?.map((e) => PushNotification.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalElements: (json['totalElements'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$PushNotificationsListDataImplToJson(
        _$PushNotificationsListDataImpl instance) =>
    <String, dynamic>{
      'content': instance.content,
      'totalElements': instance.totalElements,
    };

_$PushNotificationsListResponseImpl
    _$$PushNotificationsListResponseImplFromJson(Map<String, dynamic> json) =>
        _$PushNotificationsListResponseImpl(
          status: json['status'] as String?,
          code: json['code'] as String?,
          data: json['data'] == null
              ? null
              : PushNotificationsListData.fromJson(
                  json['data'] as Map<String, dynamic>),
          message: json['message'] as String?,
        );

Map<String, dynamic> _$$PushNotificationsListResponseImplToJson(
        _$PushNotificationsListResponseImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'data': instance.data,
      'message': instance.message,
    };
