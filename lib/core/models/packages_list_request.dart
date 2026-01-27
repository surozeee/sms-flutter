import 'package:freezed_annotation/freezed_annotation.dart';

part 'packages_list_request.freezed.dart';
part 'packages_list_request.g.dart';

@freezed
class PackagesListRequest with _$PackagesListRequest {
  const factory PackagesListRequest({
    required int page,
    required int size,
  }) = _PackagesListRequest;

  factory PackagesListRequest.fromJson(Map<String, dynamic> json) =>
      _$PackagesListRequestFromJson(json);
}
