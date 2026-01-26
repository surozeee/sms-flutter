// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bulk_register_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BulkRegisterResponse _$BulkRegisterResponseFromJson(Map<String, dynamic> json) {
  return _BulkRegisterResponse.fromJson(json);
}

/// @nodoc
mixin _$BulkRegisterResponse {
  String? get status => throw _privateConstructorUsedError;
  String? get code => throw _privateConstructorUsedError;
  dynamic get data => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  /// Serializes this BulkRegisterResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BulkRegisterResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BulkRegisterResponseCopyWith<BulkRegisterResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BulkRegisterResponseCopyWith<$Res> {
  factory $BulkRegisterResponseCopyWith(BulkRegisterResponse value,
          $Res Function(BulkRegisterResponse) then) =
      _$BulkRegisterResponseCopyWithImpl<$Res, BulkRegisterResponse>;
  @useResult
  $Res call({String? status, String? code, dynamic data, String? message});
}

/// @nodoc
class _$BulkRegisterResponseCopyWithImpl<$Res,
        $Val extends BulkRegisterResponse>
    implements $BulkRegisterResponseCopyWith<$Res> {
  _$BulkRegisterResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BulkRegisterResponse
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
abstract class _$$BulkRegisterResponseImplCopyWith<$Res>
    implements $BulkRegisterResponseCopyWith<$Res> {
  factory _$$BulkRegisterResponseImplCopyWith(_$BulkRegisterResponseImpl value,
          $Res Function(_$BulkRegisterResponseImpl) then) =
      __$$BulkRegisterResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? status, String? code, dynamic data, String? message});
}

/// @nodoc
class __$$BulkRegisterResponseImplCopyWithImpl<$Res>
    extends _$BulkRegisterResponseCopyWithImpl<$Res, _$BulkRegisterResponseImpl>
    implements _$$BulkRegisterResponseImplCopyWith<$Res> {
  __$$BulkRegisterResponseImplCopyWithImpl(_$BulkRegisterResponseImpl _value,
      $Res Function(_$BulkRegisterResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of BulkRegisterResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
    Object? code = freezed,
    Object? data = freezed,
    Object? message = freezed,
  }) {
    return _then(_$BulkRegisterResponseImpl(
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
class _$BulkRegisterResponseImpl implements _BulkRegisterResponse {
  const _$BulkRegisterResponseImpl(
      {this.status, this.code, this.data, this.message});

  factory _$BulkRegisterResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$BulkRegisterResponseImplFromJson(json);

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
    return 'BulkRegisterResponse(status: $status, code: $code, data: $data, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BulkRegisterResponseImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.code, code) || other.code == code) &&
            const DeepCollectionEquality().equals(other.data, data) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, code,
      const DeepCollectionEquality().hash(data), message);

  /// Create a copy of BulkRegisterResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BulkRegisterResponseImplCopyWith<_$BulkRegisterResponseImpl>
      get copyWith =>
          __$$BulkRegisterResponseImplCopyWithImpl<_$BulkRegisterResponseImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BulkRegisterResponseImplToJson(
      this,
    );
  }
}

abstract class _BulkRegisterResponse implements BulkRegisterResponse {
  const factory _BulkRegisterResponse(
      {final String? status,
      final String? code,
      final dynamic data,
      final String? message}) = _$BulkRegisterResponseImpl;

  factory _BulkRegisterResponse.fromJson(Map<String, dynamic> json) =
      _$BulkRegisterResponseImpl.fromJson;

  @override
  String? get status;
  @override
  String? get code;
  @override
  dynamic get data;
  @override
  String? get message;

  /// Create a copy of BulkRegisterResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BulkRegisterResponseImplCopyWith<_$BulkRegisterResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
