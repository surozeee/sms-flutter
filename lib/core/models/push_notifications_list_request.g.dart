// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'push_notifications_list_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PushNotificationsListRequestImpl _$$PushNotificationsListRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$PushNotificationsListRequestImpl(
      page: (json['page'] as num).toInt(),
      size: (json['size'] as num).toInt(),
    );

Map<String, dynamic> _$$PushNotificationsListRequestImplToJson(
        _$PushNotificationsListRequestImpl instance) =>
    <String, dynamic>{
      'page': instance.page,
      'size': instance.size,
    };
