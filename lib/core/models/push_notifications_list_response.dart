import 'package:freezed_annotation/freezed_annotation.dart';

part 'push_notifications_list_response.freezed.dart';
part 'push_notifications_list_response.g.dart';

@freezed
class PushNotification with _$PushNotification {
  const factory PushNotification({
    String? id,
    String? title,
    String? message,
    @JsonKey(name: 'imageUrl') String? imageUrl,
    @JsonKey(name: 'notificationType') String? notificationType,
    @JsonKey(name: 'partyId') String? partyId,
    @JsonKey(name: 'partyName') String? partyName,
    @JsonKey(name: 'boothId') String? boothId,
    @JsonKey(name: 'boothName') String? boothName,
    @JsonKey(name: 'recipientCount') int? recipientCount,
    @JsonKey(name: 'successCount') int? successCount,
    @JsonKey(name: 'failureCount') int? failureCount,
    String? status,
    @JsonKey(name: 'errorMessage') String? errorMessage,
    @JsonKey(name: 'createdAt') String? createdAt,
    @JsonKey(name: 'lastModifiedAt') String? lastModifiedAt,
  }) = _PushNotification;

  factory PushNotification.fromJson(Map<String, dynamic> json) =>
      _$PushNotificationFromJson(json);
}

@freezed
class PushNotificationsListData with _$PushNotificationsListData {
  const factory PushNotificationsListData({
    List<PushNotification>? content,
    @JsonKey(name: 'totalElements') int? totalElements,
  }) = _PushNotificationsListData;

  factory PushNotificationsListData.fromJson(Map<String, dynamic> json) =>
      _$PushNotificationsListDataFromJson(json);
}

@freezed
class PushNotificationsListResponse with _$PushNotificationsListResponse {
  const factory PushNotificationsListResponse({
    String? status,
    String? code,
    PushNotificationsListData? data,
    String? message,
  }) = _PushNotificationsListResponse;

  factory PushNotificationsListResponse.fromJson(Map<String, dynamic> json) =>
      _$PushNotificationsListResponseFromJson(json);
}
