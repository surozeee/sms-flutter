// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'member_delete_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MemberDeleteResponse _$MemberDeleteResponseFromJson(Map<String, dynamic> json) {
  return _MemberDeleteResponse.fromJson(json);
}

/// @nodoc
mixin _$MemberDeleteResponse {
  String get status => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;
  @JsonKey(name: 'data')
  String? get data => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  /// Serializes this MemberDeleteResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MemberDeleteResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MemberDeleteResponseCopyWith<MemberDeleteResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MemberDeleteResponseCopyWith<$Res> {
  factory $MemberDeleteResponseCopyWith(MemberDeleteResponse value,
          $Res Function(MemberDeleteResponse) then) =
      _$MemberDeleteResponseCopyWithImpl<$Res, MemberDeleteResponse>;
  @useResult
  $Res call(
      {String status,
      String code,
      @JsonKey(name: 'data') String? data,
      String? message});
}

/// @nodoc
class _$MemberDeleteResponseCopyWithImpl<$Res,
        $Val extends MemberDeleteResponse>
    implements $MemberDeleteResponseCopyWith<$Res> {
  _$MemberDeleteResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MemberDeleteResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? code = null,
    Object? data = freezed,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MemberDeleteResponseImplCopyWith<$Res>
    implements $MemberDeleteResponseCopyWith<$Res> {
  factory _$$MemberDeleteResponseImplCopyWith(_$MemberDeleteResponseImpl value,
          $Res Function(_$MemberDeleteResponseImpl) then) =
      __$$MemberDeleteResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String status,
      String code,
      @JsonKey(name: 'data') String? data,
      String? message});
}

/// @nodoc
class __$$MemberDeleteResponseImplCopyWithImpl<$Res>
    extends _$MemberDeleteResponseCopyWithImpl<$Res, _$MemberDeleteResponseImpl>
    implements _$$MemberDeleteResponseImplCopyWith<$Res> {
  __$$MemberDeleteResponseImplCopyWithImpl(_$MemberDeleteResponseImpl _value,
      $Res Function(_$MemberDeleteResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of MemberDeleteResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? code = null,
    Object? data = freezed,
    Object? message = freezed,
  }) {
    return _then(_$MemberDeleteResponseImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MemberDeleteResponseImpl implements _MemberDeleteResponse {
  const _$MemberDeleteResponseImpl(
      {required this.status,
      required this.code,
      @JsonKey(name: 'data') this.data,
      this.message});

  factory _$MemberDeleteResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$MemberDeleteResponseImplFromJson(json);

  @override
  final String status;
  @override
  final String code;
  @override
  @JsonKey(name: 'data')
  final String? data;
  @override
  final String? message;

  @override
  String toString() {
    return 'MemberDeleteResponse(status: $status, code: $code, data: $data, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MemberDeleteResponseImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, code, data, message);

  /// Create a copy of MemberDeleteResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MemberDeleteResponseImplCopyWith<_$MemberDeleteResponseImpl>
      get copyWith =>
          __$$MemberDeleteResponseImplCopyWithImpl<_$MemberDeleteResponseImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MemberDeleteResponseImplToJson(
      this,
    );
  }
}

abstract class _MemberDeleteResponse implements MemberDeleteResponse {
  const factory _MemberDeleteResponse(
      {required final String status,
      required final String code,
      @JsonKey(name: 'data') final String? data,
      final String? message}) = _$MemberDeleteResponseImpl;

  factory _MemberDeleteResponse.fromJson(Map<String, dynamic> json) =
      _$MemberDeleteResponseImpl.fromJson;

  @override
  String get status;
  @override
  String get code;
  @override
  @JsonKey(name: 'data')
  String? get data;
  @override
  String? get message;

  /// Create a copy of MemberDeleteResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MemberDeleteResponseImplCopyWith<_$MemberDeleteResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
