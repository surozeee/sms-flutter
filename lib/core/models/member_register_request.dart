import 'package:freezed_annotation/freezed_annotation.dart';

part 'member_register_request.freezed.dart';
part 'member_register_request.g.dart';

@freezed
class MemberRegisterRequest with _$MemberRegisterRequest {
  const factory MemberRegisterRequest({
    @JsonKey(name: 'fullName') required String fullName,
    @JsonKey(name: 'mobileNumber') required String mobileNumber,
    @JsonKey(name: 'boothName') required String boothName,
  }) = _MemberRegisterRequest;

  factory MemberRegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$MemberRegisterRequestFromJson(json);
}
