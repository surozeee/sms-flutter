import 'package:freezed_annotation/freezed_annotation.dart';

part 'content_create_response.freezed.dart';
part 'content_create_response.g.dart';

@freezed
class ContentCreateResponse with _$ContentCreateResponse {
  const factory ContentCreateResponse({
    String? status,
    String? code,
    dynamic data,
    String? message,
  }) = _ContentCreateResponse;

  factory ContentCreateResponse.fromJson(Map<String, dynamic> json) =>
      _$ContentCreateResponseFromJson(json);
}
