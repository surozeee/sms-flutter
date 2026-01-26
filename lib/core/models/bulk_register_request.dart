import 'package:freezed_annotation/freezed_annotation.dart';

part 'bulk_register_request.freezed.dart';
part 'bulk_register_request.g.dart';

@freezed
class BulkRegisterRequest with _$BulkRegisterRequest {
  const factory BulkRegisterRequest({
    required String file,
  }) = _BulkRegisterRequest;

  factory BulkRegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$BulkRegisterRequestFromJson(json);
}
