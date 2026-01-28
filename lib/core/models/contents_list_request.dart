import 'package:freezed_annotation/freezed_annotation.dart';

part 'contents_list_request.freezed.dart';
part 'contents_list_request.g.dart';

@freezed
class ContentsListRequest with _$ContentsListRequest {
  const factory ContentsListRequest({
    required int page,
    required int size,
    // @JsonKey(name: 'search') String? search,
    // @JsonKey(name: 'sortBy') String? sortBy,
    // @JsonKey(name: 'sortDirection') String? sortDirection,
  }) = _ContentsListRequest;

  factory ContentsListRequest.fromJson(Map<String, dynamic> json) =>
      _$ContentsListRequestFromJson(json);
}
