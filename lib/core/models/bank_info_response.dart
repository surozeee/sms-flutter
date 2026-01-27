import 'package:freezed_annotation/freezed_annotation.dart';

part 'bank_info_response.freezed.dart';
part 'bank_info_response.g.dart';

@freezed
class BankInfo with _$BankInfo {
  const factory BankInfo({
    @JsonKey(name: 'accountNumber') String? accountNumber,
    String? branch,
    @JsonKey(name: 'createdAt') String? createdAt,
    String? id,
    @JsonKey(name: 'lastModifiedAt') String? lastModifiedAt,
    String? name,
    @JsonKey(name: 'qrCode') String? qrCode,
  }) = _BankInfo;

  factory BankInfo.fromJson(Map<String, dynamic> json) =>
      _$BankInfoFromJson(json);
}

@freezed
class BankInfoResponse with _$BankInfoResponse {
  const factory BankInfoResponse({
    String? status,
    String? code,
    BankInfo? data,
    String? message,
  }) = _BankInfoResponse;

  factory BankInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$BankInfoResponseFromJson(json);
}
