import 'package:freezed_annotation/freezed_annotation.dart';

part 'booth_list_request.freezed.dart';
part 'booth_list_request.g.dart';

@freezed
class BoothListRequest with _$BoothListRequest {
  const factory BoothListRequest({
    required int page,
    required int size,
    // @JsonKey(name: 'search') String? search,
    // @JsonKey(name: 'sortBy') String? sortBy,
    // @JsonKey(name: 'sortDirection') String? sortDirection,
  }) = _BoothListRequest;

  factory BoothListRequest.fromJson(Map<String, dynamic> json) =>
      _$BoothListRequestFromJson(json);
}
