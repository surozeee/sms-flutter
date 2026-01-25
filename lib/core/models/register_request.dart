import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_request.freezed.dart';
part 'register_request.g.dart';

@freezed
class RegisterRequest with _$RegisterRequest {
  const factory RegisterRequest({
    @JsonKey(name: 'emailAddress') required String emailAddress,
    @JsonKey(name: 'mobileNumber') required String mobileNumber,
    @JsonKey(name: 'password') required String password,
    @JsonKey(name: 'role') required String role,
    @JsonKey(name: 'fullName') required String fullName,
  }) = _RegisterRequest;

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestFromJson(json);
}
