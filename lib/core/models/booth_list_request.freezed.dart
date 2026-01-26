// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booth_list_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BoothListRequest _$BoothListRequestFromJson(Map<String, dynamic> json) {
  return _BoothListRequest.fromJson(json);
}

/// @nodoc
mixin _$BoothListRequest {
  int get page => throw _privateConstructorUsedError;
  int get size => throw _privateConstructorUsedError;

  /// Serializes this BoothListRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BoothListRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BoothListRequestCopyWith<BoothListRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BoothListRequestCopyWith<$Res> {
  factory $BoothListRequestCopyWith(
          BoothListRequest value, $Res Function(BoothListRequest) then) =
      _$BoothListRequestCopyWithImpl<$Res, BoothListRequest>;
  @useResult
  $Res call({int page, int size});
}

/// @nodoc
class _$BoothListRequestCopyWithImpl<$Res, $Val extends BoothListRequest>
    implements $BoothListRequestCopyWith<$Res> {
  _$BoothListRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BoothListRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = null,
    Object? size = null,
  }) {
    return _then(_value.copyWith(
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BoothListRequestImplCopyWith<$Res>
    implements $BoothListRequestCopyWith<$Res> {
  factory _$$BoothListRequestImplCopyWith(_$BoothListRequestImpl value,
          $Res Function(_$BoothListRequestImpl) then) =
      __$$BoothListRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int page, int size});
}

/// @nodoc
class __$$BoothListRequestImplCopyWithImpl<$Res>
    extends _$BoothListRequestCopyWithImpl<$Res, _$BoothListRequestImpl>
    implements _$$BoothListRequestImplCopyWith<$Res> {
  __$$BoothListRequestImplCopyWithImpl(_$BoothListRequestImpl _value,
      $Res Function(_$BoothListRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of BoothListRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = null,
    Object? size = null,
  }) {
    return _then(_$BoothListRequestImpl(
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BoothListRequestImpl implements _BoothListRequest {
  const _$BoothListRequestImpl({required this.page, required this.size});

  factory _$BoothListRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$BoothListRequestImplFromJson(json);

  @override
  final int page;
  @override
  final int size;

  @override
  String toString() {
    return 'BoothListRequest(page: $page, size: $size)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BoothListRequestImpl &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.size, size) || other.size == size));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, page, size);

  /// Create a copy of BoothListRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BoothListRequestImplCopyWith<_$BoothListRequestImpl> get copyWith =>
      __$$BoothListRequestImplCopyWithImpl<_$BoothListRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BoothListRequestImplToJson(
      this,
    );
  }
}

abstract class _BoothListRequest implements BoothListRequest {
  const factory _BoothListRequest(
      {required final int page,
      required final int size}) = _$BoothListRequestImpl;

  factory _BoothListRequest.fromJson(Map<String, dynamic> json) =
      _$BoothListRequestImpl.fromJson;

  @override
  int get page;
  @override
  int get size;

  /// Create a copy of BoothListRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BoothListRequestImplCopyWith<_$BoothListRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
