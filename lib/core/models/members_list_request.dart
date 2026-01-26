import 'package:freezed_annotation/freezed_annotation.dart';

part 'members_list_request.freezed.dart';
part 'members_list_request.g.dart';

@freezed
class MembersListRequest with _$MembersListRequest {
  const factory MembersListRequest({
    required int page,
    required int size,
    // @JsonKey(name: 'search') String? search,
    // @JsonKey(name: 'sortBy') String? sortBy,
    // @JsonKey(name: 'sortDirection') String? sortDirection,
  }) = _MembersListRequest;

  factory MembersListRequest.fromJson(Map<String, dynamic> json) =>
      _$MembersListRequestFromJson(json);
}
