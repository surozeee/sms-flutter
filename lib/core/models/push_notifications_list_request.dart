import 'package:freezed_annotation/freezed_annotation.dart';

part 'push_notifications_list_request.freezed.dart';
part 'push_notifications_list_request.g.dart';

@freezed
class PushNotificationsListRequest with _$PushNotificationsListRequest {
  const factory PushNotificationsListRequest({
    required int page,
    required int size,
    // @JsonKey(name: 'search') String? search,
    // @JsonKey(name: 'sortBy') String? sortBy,
    // @JsonKey(name: 'sortDirection') String? sortDirection,
  }) = _PushNotificationsListRequest;

  factory PushNotificationsListRequest.fromJson(Map<String, dynamic> json) =>
      _$PushNotificationsListRequestFromJson(json);
}
