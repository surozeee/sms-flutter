// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'contents_list_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ContentsListRequest _$ContentsListRequestFromJson(Map<String, dynamic> json) {
  return _ContentsListRequest.fromJson(json);
}

/// @nodoc
mixin _$ContentsListRequest {
  int get page => throw _privateConstructorUsedError;
  int get size => throw _privateConstructorUsedError;

  /// Serializes this ContentsListRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ContentsListRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ContentsListRequestCopyWith<ContentsListRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContentsListRequestCopyWith<$Res> {
  factory $ContentsListRequestCopyWith(
          ContentsListRequest value, $Res Function(ContentsListRequest) then) =
      _$ContentsListRequestCopyWithImpl<$Res, ContentsListRequest>;
  @useResult
  $Res call({int page, int size});
}

/// @nodoc
class _$ContentsListRequestCopyWithImpl<$Res, $Val extends ContentsListRequest>
    implements $ContentsListRequestCopyWith<$Res> {
  _$ContentsListRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ContentsListRequest
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
abstract class _$$ContentsListRequestImplCopyWith<$Res>
    implements $ContentsListRequestCopyWith<$Res> {
  factory _$$ContentsListRequestImplCopyWith(_$ContentsListRequestImpl value,
          $Res Function(_$ContentsListRequestImpl) then) =
      __$$ContentsListRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int page, int size});
}

/// @nodoc
class __$$ContentsListRequestImplCopyWithImpl<$Res>
    extends _$ContentsListRequestCopyWithImpl<$Res, _$ContentsListRequestImpl>
    implements _$$ContentsListRequestImplCopyWith<$Res> {
  __$$ContentsListRequestImplCopyWithImpl(_$ContentsListRequestImpl _value,
      $Res Function(_$ContentsListRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of ContentsListRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = null,
    Object? size = null,
  }) {
    return _then(_$ContentsListRequestImpl(
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
class _$ContentsListRequestImpl implements _ContentsListRequest {
  const _$ContentsListRequestImpl({required this.page, required this.size});

  factory _$ContentsListRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$ContentsListRequestImplFromJson(json);

  @override
  final int page;
  @override
  final int size;

  @override
  String toString() {
    return 'ContentsListRequest(page: $page, size: $size)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContentsListRequestImpl &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.size, size) || other.size == size));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, page, size);

  /// Create a copy of ContentsListRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ContentsListRequestImplCopyWith<_$ContentsListRequestImpl> get copyWith =>
      __$$ContentsListRequestImplCopyWithImpl<_$ContentsListRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ContentsListRequestImplToJson(
      this,
    );
  }
}

abstract class _ContentsListRequest implements ContentsListRequest {
  const factory _ContentsListRequest(
      {required final int page,
      required final int size}) = _$ContentsListRequestImpl;

  factory _ContentsListRequest.fromJson(Map<String, dynamic> json) =
      _$ContentsListRequestImpl.fromJson;

  @override
  int get page;
  @override
  int get size;

  /// Create a copy of ContentsListRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ContentsListRequestImplCopyWith<_$ContentsListRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
