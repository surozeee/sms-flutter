import 'package:freezed_annotation/freezed_annotation.dart';

part 'booth_list_response.freezed.dart';
part 'booth_list_response.g.dart';

@freezed
class Booth with _$Booth {
  const factory Booth({
    @JsonKey(name: 'createdAt') String? createdAt,
    String? id,
    @JsonKey(name: 'lastModifiedAt') String? lastModifiedAt,
    String? name,
    String? status,
  }) = _Booth;

  factory Booth.fromJson(Map<String, dynamic> json) =>
      _$BoothFromJson(json);
}

@freezed
class BoothListData with _$BoothListData {
  const factory BoothListData({
    List<Booth>? content,
    @JsonKey(name: 'totalElements') int? totalElements,
  }) = _BoothListData;

  factory BoothListData.fromJson(Map<String, dynamic> json) =>
      _$BoothListDataFromJson(json);
}

@freezed
class BoothListResponse with _$BoothListResponse {
  const factory BoothListResponse({
    String? status,
    String? code,
    BoothListData? data,
    String? message,
  }) = _BoothListResponse;

  factory BoothListResponse.fromJson(Map<String, dynamic> json) =>
      _$BoothListResponseFromJson(json);
}
