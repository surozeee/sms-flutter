// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'content_create_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ContentCreateResponse _$ContentCreateResponseFromJson(
    Map<String, dynamic> json) {
  return _ContentCreateResponse.fromJson(json);
}

/// @nodoc
mixin _$ContentCreateResponse {
  String? get status => throw _privateConstructorUsedError;
  String? get code => throw _privateConstructorUsedError;
  dynamic get data => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  /// Serializes this ContentCreateResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ContentCreateResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ContentCreateResponseCopyWith<ContentCreateResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContentCreateResponseCopyWith<$Res> {
  factory $ContentCreateResponseCopyWith(ContentCreateResponse value,
          $Res Function(ContentCreateResponse) then) =
      _$ContentCreateResponseCopyWithImpl<$Res, ContentCreateResponse>;
  @useResult
  $Res call({String? status, String? code, dynamic data, String? message});
}

/// @nodoc
class _$ContentCreateResponseCopyWithImpl<$Res,
        $Val extends ContentCreateResponse>
    implements $ContentCreateResponseCopyWith<$Res> {
  _$ContentCreateResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ContentCreateResponse
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
abstract class _$$ContentCreateResponseImplCopyWith<$Res>
    implements $ContentCreateResponseCopyWith<$Res> {
  factory _$$ContentCreateResponseImplCopyWith(
          _$ContentCreateResponseImpl value,
          $Res Function(_$ContentCreateResponseImpl) then) =
      __$$ContentCreateResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? status, String? code, dynamic data, String? message});
}

/// @nodoc
class __$$ContentCreateResponseImplCopyWithImpl<$Res>
    extends _$ContentCreateResponseCopyWithImpl<$Res,
        _$ContentCreateResponseImpl>
    implements _$$ContentCreateResponseImplCopyWith<$Res> {
  __$$ContentCreateResponseImplCopyWithImpl(_$ContentCreateResponseImpl _value,
      $Res Function(_$ContentCreateResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of ContentCreateResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
    Object? code = freezed,
    Object? data = freezed,
    Object? message = freezed,
  }) {
    return _then(_$ContentCreateResponseImpl(
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
class _$ContentCreateResponseImpl implements _ContentCreateResponse {
  const _$ContentCreateResponseImpl(
      {this.status, this.code, this.data, this.message});

  factory _$ContentCreateResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ContentCreateResponseImplFromJson(json);

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
    return 'ContentCreateResponse(status: $status, code: $code, data: $data, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContentCreateResponseImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.code, code) || other.code == code) &&
            const DeepCollectionEquality().equals(other.data, data) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, code,
      const DeepCollectionEquality().hash(data), message);

  /// Create a copy of ContentCreateResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ContentCreateResponseImplCopyWith<_$ContentCreateResponseImpl>
      get copyWith => __$$ContentCreateResponseImplCopyWithImpl<
          _$ContentCreateResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ContentCreateResponseImplToJson(
      this,
    );
  }
}

abstract class _ContentCreateResponse implements ContentCreateResponse {
  const factory _ContentCreateResponse(
      {final String? status,
      final String? code,
      final dynamic data,
      final String? message}) = _$ContentCreateResponseImpl;

  factory _ContentCreateResponse.fromJson(Map<String, dynamic> json) =
      _$ContentCreateResponseImpl.fromJson;

  @override
  String? get status;
  @override
  String? get code;
  @override
  dynamic get data;
  @override
  String? get message;

  /// Create a copy of ContentCreateResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ContentCreateResponseImplCopyWith<_$ContentCreateResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
