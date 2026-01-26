// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bulk_register_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BulkRegisterRequest _$BulkRegisterRequestFromJson(Map<String, dynamic> json) {
  return _BulkRegisterRequest.fromJson(json);
}

/// @nodoc
mixin _$BulkRegisterRequest {
  String get file => throw _privateConstructorUsedError;

  /// Serializes this BulkRegisterRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BulkRegisterRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BulkRegisterRequestCopyWith<BulkRegisterRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BulkRegisterRequestCopyWith<$Res> {
  factory $BulkRegisterRequestCopyWith(
          BulkRegisterRequest value, $Res Function(BulkRegisterRequest) then) =
      _$BulkRegisterRequestCopyWithImpl<$Res, BulkRegisterRequest>;
  @useResult
  $Res call({String file});
}

/// @nodoc
class _$BulkRegisterRequestCopyWithImpl<$Res, $Val extends BulkRegisterRequest>
    implements $BulkRegisterRequestCopyWith<$Res> {
  _$BulkRegisterRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BulkRegisterRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? file = null,
  }) {
    return _then(_value.copyWith(
      file: null == file
          ? _value.file
          : file // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BulkRegisterRequestImplCopyWith<$Res>
    implements $BulkRegisterRequestCopyWith<$Res> {
  factory _$$BulkRegisterRequestImplCopyWith(_$BulkRegisterRequestImpl value,
          $Res Function(_$BulkRegisterRequestImpl) then) =
      __$$BulkRegisterRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String file});
}

/// @nodoc
class __$$BulkRegisterRequestImplCopyWithImpl<$Res>
    extends _$BulkRegisterRequestCopyWithImpl<$Res, _$BulkRegisterRequestImpl>
    implements _$$BulkRegisterRequestImplCopyWith<$Res> {
  __$$BulkRegisterRequestImplCopyWithImpl(_$BulkRegisterRequestImpl _value,
      $Res Function(_$BulkRegisterRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of BulkRegisterRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? file = null,
  }) {
    return _then(_$BulkRegisterRequestImpl(
      file: null == file
          ? _value.file
          : file // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BulkRegisterRequestImpl implements _BulkRegisterRequest {
  const _$BulkRegisterRequestImpl({required this.file});

  factory _$BulkRegisterRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$BulkRegisterRequestImplFromJson(json);

  @override
  final String file;

  @override
  String toString() {
    return 'BulkRegisterRequest(file: $file)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BulkRegisterRequestImpl &&
            (identical(other.file, file) || other.file == file));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, file);

  /// Create a copy of BulkRegisterRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BulkRegisterRequestImplCopyWith<_$BulkRegisterRequestImpl> get copyWith =>
      __$$BulkRegisterRequestImplCopyWithImpl<_$BulkRegisterRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BulkRegisterRequestImplToJson(
      this,
    );
  }
}

abstract class _BulkRegisterRequest implements BulkRegisterRequest {
  const factory _BulkRegisterRequest({required final String file}) =
      _$BulkRegisterRequestImpl;

  factory _BulkRegisterRequest.fromJson(Map<String, dynamic> json) =
      _$BulkRegisterRequestImpl.fromJson;

  @override
  String get file;

  /// Create a copy of BulkRegisterRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BulkRegisterRequestImplCopyWith<_$BulkRegisterRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
