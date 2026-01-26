import 'package:freezed_annotation/freezed_annotation.dart';

part 'bulk_register_response.freezed.dart';
part 'bulk_register_response.g.dart';

@freezed
class BulkRegisterResponse with _$BulkRegisterResponse {
  const factory BulkRegisterResponse({
    String? status,
    String? code,
    dynamic data,
    String? message,
  }) = _BulkRegisterResponse;

  factory BulkRegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$BulkRegisterResponseFromJson(json);
}
