import 'package:freezed_annotation/freezed_annotation.dart';

part 'packages_list_response.freezed.dart';
part 'packages_list_response.g.dart';

@freezed
class Package with _$Package {
  const factory Package({
    @JsonKey(name: 'createdAt') String? createdAt,
    String? description,
    double? discount,
    @JsonKey(name: 'discountType') String? discountType,
    String? id,
    @JsonKey(name: 'isActive') bool? isActive,
    @JsonKey(name: 'lastModifiedAt') String? lastModifiedAt,
    @JsonKey(name: 'packageName') String? packageName,
    double? price,
    @JsonKey(name: 'smsAmount') int? smsAmount,
  }) = _Package;

  factory Package.fromJson(Map<String, dynamic> json) =>
      _$PackageFromJson(json);
}

@freezed
class PackagesListData with _$PackagesListData {
  const factory PackagesListData({
    List<Package>? content,
    @JsonKey(name: 'totalElements') int? totalElements,
  }) = _PackagesListData;

  factory PackagesListData.fromJson(Map<String, dynamic> json) =>
      _$PackagesListDataFromJson(json);
}

@freezed
class PackagesListResponse with _$PackagesListResponse {
  const factory PackagesListResponse({
    String? status,
    String? code,
    PackagesListData? data,
    String? message,
  }) = _PackagesListResponse;

  factory PackagesListResponse.fromJson(Map<String, dynamic> json) =>
      _$PackagesListResponseFromJson(json);
}
