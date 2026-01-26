// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'members_list_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MembersListRequest _$MembersListRequestFromJson(Map<String, dynamic> json) {
  return _MembersListRequest.fromJson(json);
}

/// @nodoc
mixin _$MembersListRequest {
  int get page => throw _privateConstructorUsedError;
  int get size => throw _privateConstructorUsedError;

  /// Serializes this MembersListRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MembersListRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MembersListRequestCopyWith<MembersListRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MembersListRequestCopyWith<$Res> {
  factory $MembersListRequestCopyWith(
          MembersListRequest value, $Res Function(MembersListRequest) then) =
      _$MembersListRequestCopyWithImpl<$Res, MembersListRequest>;
  @useResult
  $Res call({int page, int size});
}

/// @nodoc
class _$MembersListRequestCopyWithImpl<$Res, $Val extends MembersListRequest>
    implements $MembersListRequestCopyWith<$Res> {
  _$MembersListRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MembersListRequest
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
abstract class _$$MembersListRequestImplCopyWith<$Res>
    implements $MembersListRequestCopyWith<$Res> {
  factory _$$MembersListRequestImplCopyWith(_$MembersListRequestImpl value,
          $Res Function(_$MembersListRequestImpl) then) =
      __$$MembersListRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int page, int size});
}

/// @nodoc
class __$$MembersListRequestImplCopyWithImpl<$Res>
    extends _$MembersListRequestCopyWithImpl<$Res, _$MembersListRequestImpl>
    implements _$$MembersListRequestImplCopyWith<$Res> {
  __$$MembersListRequestImplCopyWithImpl(_$MembersListRequestImpl _value,
      $Res Function(_$MembersListRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of MembersListRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = null,
    Object? size = null,
  }) {
    return _then(_$MembersListRequestImpl(
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
class _$MembersListRequestImpl implements _MembersListRequest {
  const _$MembersListRequestImpl({required this.page, required this.size});

  factory _$MembersListRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$MembersListRequestImplFromJson(json);

  @override
  final int page;
  @override
  final int size;

  @override
  String toString() {
    return 'MembersListRequest(page: $page, size: $size)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MembersListRequestImpl &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.size, size) || other.size == size));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, page, size);

  /// Create a copy of MembersListRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MembersListRequestImplCopyWith<_$MembersListRequestImpl> get copyWith =>
      __$$MembersListRequestImplCopyWithImpl<_$MembersListRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MembersListRequestImplToJson(
      this,
    );
  }
}

abstract class _MembersListRequest implements MembersListRequest {
  const factory _MembersListRequest(
      {required final int page,
      required final int size}) = _$MembersListRequestImpl;

  factory _MembersListRequest.fromJson(Map<String, dynamic> json) =
      _$MembersListRequestImpl.fromJson;

  @override
  int get page;
  @override
  int get size;

  /// Create a copy of MembersListRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MembersListRequestImplCopyWith<_$MembersListRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
