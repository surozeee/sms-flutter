import 'package:freezed_annotation/freezed_annotation.dart';
import 'members_list_response.dart';

part 'member_register_response.freezed.dart';
part 'member_register_response.g.dart';

@freezed
class MemberRegisterResponse with _$MemberRegisterResponse {
  const factory MemberRegisterResponse({
    String? status,
    String? code,
    Member? data,
    String? message,
  }) = _MemberRegisterResponse;

  factory MemberRegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$MemberRegisterResponseFromJson(json);
}
