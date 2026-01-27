import 'package:freezed_annotation/freezed_annotation.dart';

part 'balance_load_request.freezed.dart';
part 'balance_load_request.g.dart';

@freezed
class BalanceLoadRequest with _$BalanceLoadRequest {
  const factory BalanceLoadRequest({
    required double amount,
    required String description,
    required String document,
    @JsonKey(name: 'packageId') required String packageId,
  }) = _BalanceLoadRequest;

  factory BalanceLoadRequest.fromJson(Map<String, dynamic> json) =>
      _$BalanceLoadRequestFromJson(json);
}
