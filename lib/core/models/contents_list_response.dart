import 'package:freezed_annotation/freezed_annotation.dart';

part 'contents_list_response.freezed.dart';
part 'contents_list_response.g.dart';

@freezed
class ContentItem with _$ContentItem {
  const factory ContentItem({
    @JsonKey(name: 'aiPrompt') String? aiPrompt,
    @JsonKey(name: 'contentType') String? contentType,
    @JsonKey(name: 'createdAt') String? createdAt,
    String? id,
    @JsonKey(name: 'imageUrl') String? imageUrl,
    @JsonKey(name: 'isPublished') bool? isPublished,
    @JsonKey(name: 'lastModifiedAt') String? lastModifiedAt,
    @JsonKey(name: 'partyId') String? partyId,
    @JsonKey(name: 'partyName') String? partyName,
    @JsonKey(name: 'textContent') String? textContent,
    String? title,
  }) = _ContentItem;

  factory ContentItem.fromJson(Map<String, dynamic> json) =>
      _$ContentItemFromJson(json);
}

@freezed
class ContentsListData with _$ContentsListData {
  const factory ContentsListData({
    List<ContentItem>? content,
    @JsonKey(name: 'totalElements') int? totalElements,
  }) = _ContentsListData;

  factory ContentsListData.fromJson(Map<String, dynamic> json) =>
      _$ContentsListDataFromJson(json);
}

@freezed
class ContentsListResponse with _$ContentsListResponse {
  const factory ContentsListResponse({
    String? status,
    String? code,
    ContentsListData? data,
    String? message,
  }) = _ContentsListResponse;

  factory ContentsListResponse.fromJson(Map<String, dynamic> json) =>
      _$ContentsListResponseFromJson(json);
}
