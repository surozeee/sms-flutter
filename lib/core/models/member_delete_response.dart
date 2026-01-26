import 'package:freezed_annotation/freezed_annotation.dart';

part 'member_delete_response.freezed.dart';
part 'member_delete_response.g.dart';

@freezed
class MemberDeleteResponse with _$MemberDeleteResponse {
  const factory MemberDeleteResponse({
    required String status,
    required String code,
    @JsonKey(name: 'data') String? data,
    String? message,
  }) = _MemberDeleteResponse;

  factory MemberDeleteResponse.fromJson(Map<String, dynamic> json) =>
      _$MemberDeleteResponseFromJson(json);
}
