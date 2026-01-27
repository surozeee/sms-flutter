// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'balance_load_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BalanceLoadResponse _$BalanceLoadResponseFromJson(Map<String, dynamic> json) {
  return _BalanceLoadResponse.fromJson(json);
}

/// @nodoc
mixin _$BalanceLoadResponse {
  String? get status => throw _privateConstructorUsedError;
  String? get code => throw _privateConstructorUsedError;
  dynamic get data => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  /// Serializes this BalanceLoadResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BalanceLoadResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BalanceLoadResponseCopyWith<BalanceLoadResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BalanceLoadResponseCopyWith<$Res> {
  factory $BalanceLoadResponseCopyWith(
          BalanceLoadResponse value, $Res Function(BalanceLoadResponse) then) =
      _$BalanceLoadResponseCopyWithImpl<$Res, BalanceLoadResponse>;
  @useResult
  $Res call({String? status, String? code, dynamic data, String? message});
}

/// @nodoc
class _$BalanceLoadResponseCopyWithImpl<$Res, $Val extends BalanceLoadResponse>
    implements $BalanceLoadResponseCopyWith<$Res> {
  _$BalanceLoadResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BalanceLoadResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
    Object? code = freezed,
    Object? data = freezed,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as dynamic,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BalanceLoadResponseImplCopyWith<$Res>
    implements $BalanceLoadResponseCopyWith<$Res> {
  factory _$$BalanceLoadResponseImplCopyWith(_$BalanceLoadResponseImpl value,
          $Res Function(_$BalanceLoadResponseImpl) then) =
      __$$BalanceLoadResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? status, String? code, dynamic data, String? message});
}

/// @nodoc
class __$$BalanceLoadResponseImplCopyWithImpl<$Res>
    extends _$BalanceLoadResponseCopyWithImpl<$Res, _$BalanceLoadResponseImpl>
    implements _$$BalanceLoadResponseImplCopyWith<$Res> {
  __$$BalanceLoadResponseImplCopyWithImpl(_$BalanceLoadResponseImpl _value,
      $Res Function(_$BalanceLoadResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of BalanceLoadResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
    Object? code = freezed,
    Object? data = freezed,
    Object? message = freezed,
  }) {
    return _then(_$BalanceLoadResponseImpl(
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as dynamic,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BalanceLoadResponseImpl implements _BalanceLoadResponse {
  const _$BalanceLoadResponseImpl(
      {this.status, this.code, this.data, this.message});

  factory _$BalanceLoadResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$BalanceLoadResponseImplFromJson(json);

  @override
  final String? status;
  @override
  final String? code;
  @override
  final dynamic data;
  @override
  final String? message;

  @override
  String toString() {
    return 'BalanceLoadResponse(status: $status, code: $code, data: $data, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BalanceLoadResponseImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.code, code) || other.code == code) &&
            const DeepCollectionEquality().equals(other.data, data) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, code,
      const DeepCollectionEquality().hash(data), message);

  /// Create a copy of BalanceLoadResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BalanceLoadResponseImplCopyWith<_$BalanceLoadResponseImpl> get copyWith =>
      __$$BalanceLoadResponseImplCopyWithImpl<_$BalanceLoadResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BalanceLoadResponseImplToJson(
      this,
    );
  }
}

abstract class _BalanceLoadResponse implements BalanceLoadResponse {
  const factory _BalanceLoadResponse(
      {final String? status,
      final String? code,
      final dynamic data,
      final String? message}) = _$BalanceLoadResponseImpl;

  factory _BalanceLoadResponse.fromJson(Map<String, dynamic> json) =
      _$BalanceLoadResponseImpl.fromJson;

  @override
  String? get status;
  @override
  String? get code;
  @override
  dynamic get data;
  @override
  String? get message;

  /// Create a copy of BalanceLoadResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BalanceLoadResponseImplCopyWith<_$BalanceLoadResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
