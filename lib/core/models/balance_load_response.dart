import 'package:freezed_annotation/freezed_annotation.dart';

part 'balance_load_response.freezed.dart';
part 'balance_load_response.g.dart';

@freezed
class BalanceLoadResponse with _$BalanceLoadResponse {
  const factory BalanceLoadResponse({
    String? status,
    String? code,
    dynamic data,
    String? message,
  }) = _BalanceLoadResponse;

  factory BalanceLoadResponse.fromJson(Map<String, dynamic> json) =>
      _$BalanceLoadResponseFromJson(json);
}
