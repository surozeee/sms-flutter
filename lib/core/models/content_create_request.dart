import 'package:freezed_annotation/freezed_annotation.dart';

part 'content_create_request.freezed.dart';
part 'content_create_request.g.dart';

@freezed
class ContentCreateRequest with _$ContentCreateRequest {
  const factory ContentCreateRequest({
    required String contentType,
    required String title,
    required String textContent,
    String? imageBase64,
    String? imageFilename,
  }) = _ContentCreateRequest;

  factory ContentCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$ContentCreateRequestFromJson(json);
}
