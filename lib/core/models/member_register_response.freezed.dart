// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'member_register_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MemberRegisterResponse _$MemberRegisterResponseFromJson(
    Map<String, dynamic> json) {
  return _MemberRegisterResponse.fromJson(json);
}

/// @nodoc
mixin _$MemberRegisterResponse {
  String? get status => throw _privateConstructorUsedError;
  String? get code => throw _privateConstructorUsedError;
  Member? get data => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  /// Serializes this MemberRegisterResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MemberRegisterResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MemberRegisterResponseCopyWith<MemberRegisterResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MemberRegisterResponseCopyWith<$Res> {
  factory $MemberRegisterResponseCopyWith(MemberRegisterResponse value,
          $Res Function(MemberRegisterResponse) then) =
      _$MemberRegisterResponseCopyWithImpl<$Res, MemberRegisterResponse>;
  @useResult
  $Res call({String? status, String? code, Member? data, String? message});

  $MemberCopyWith<$Res>? get data;
}

/// @nodoc
class _$MemberRegisterResponseCopyWithImpl<$Res,
        $Val extends MemberRegisterResponse>
    implements $MemberRegisterResponseCopyWith<$Res> {
  _$MemberRegisterResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MemberRegisterResponse
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
              as Member?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of MemberRegisterResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MemberCopyWith<$Res>? get data {
    if (_value.data == null) {
      return null;
    }

    return $MemberCopyWith<$Res>(_value.data!, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MemberRegisterResponseImplCopyWith<$Res>
    implements $MemberRegisterResponseCopyWith<$Res> {
  factory _$$MemberRegisterResponseImplCopyWith(
          _$MemberRegisterResponseImpl value,
          $Res Function(_$MemberRegisterResponseImpl) then) =
      __$$MemberRegisterResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? status, String? code, Member? data, String? message});

  @override
  $MemberCopyWith<$Res>? get data;
}

/// @nodoc
class __$$MemberRegisterResponseImplCopyWithImpl<$Res>
    extends _$MemberRegisterResponseCopyWithImpl<$Res,
        _$MemberRegisterResponseImpl>
    implements _$$MemberRegisterResponseImplCopyWith<$Res> {
  __$$MemberRegisterResponseImplCopyWithImpl(
      _$MemberRegisterResponseImpl _value,
      $Res Function(_$MemberRegisterResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of MemberRegisterResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
    Object? code = freezed,
    Object? data = freezed,
    Object? message = freezed,
  }) {
    return _then(_$MemberRegisterResponseImpl(
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
              as Member?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MemberRegisterResponseImpl implements _MemberRegisterResponse {
  const _$MemberRegisterResponseImpl(
      {this.status, this.code, this.data, this.message});

  factory _$MemberRegisterResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$MemberRegisterResponseImplFromJson(json);

  @override
  final String? status;
  @override
  final String? code;
  @override
  final Member? data;
  @override
  final String? message;

  @override
  String toString() {
    return 'MemberRegisterResponse(status: $status, code: $code, data: $data, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MemberRegisterResponseImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, code, data, message);

  /// Create a copy of MemberRegisterResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MemberRegisterResponseImplCopyWith<_$MemberRegisterResponseImpl>
      get copyWith => __$$MemberRegisterResponseImplCopyWithImpl<
          _$MemberRegisterResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MemberRegisterResponseImplToJson(
      this,
    );
  }
}

abstract class _MemberRegisterResponse implements MemberRegisterResponse {
  const factory _MemberRegisterResponse(
      {final String? status,
      final String? code,
      final Member? data,
      final String? message}) = _$MemberRegisterResponseImpl;

  factory _MemberRegisterResponse.fromJson(Map<String, dynamic> json) =
      _$MemberRegisterResponseImpl.fromJson;

  @override
  String? get status;
  @override
  String? get code;
  @override
  Member? get data;
  @override
  String? get message;

  /// Create a copy of MemberRegisterResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MemberRegisterResponseImplCopyWith<_$MemberRegisterResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
