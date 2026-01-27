// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'push_notifications_list_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PushNotificationsListRequest _$PushNotificationsListRequestFromJson(
    Map<String, dynamic> json) {
  return _PushNotificationsListRequest.fromJson(json);
}

/// @nodoc
mixin _$PushNotificationsListRequest {
  int get page => throw _privateConstructorUsedError;
  int get size => throw _privateConstructorUsedError;

  /// Serializes this PushNotificationsListRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PushNotificationsListRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PushNotificationsListRequestCopyWith<PushNotificationsListRequest>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PushNotificationsListRequestCopyWith<$Res> {
  factory $PushNotificationsListRequestCopyWith(
          PushNotificationsListRequest value,
          $Res Function(PushNotificationsListRequest) then) =
      _$PushNotificationsListRequestCopyWithImpl<$Res,
          PushNotificationsListRequest>;
  @useResult
  $Res call({int page, int size});
}

/// @nodoc
class _$PushNotificationsListRequestCopyWithImpl<$Res,
        $Val extends PushNotificationsListRequest>
    implements $PushNotificationsListRequestCopyWith<$Res> {
  _$PushNotificationsListRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PushNotificationsListRequest
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
abstract class _$$PushNotificationsListRequestImplCopyWith<$Res>
    implements $PushNotificationsListRequestCopyWith<$Res> {
  factory _$$PushNotificationsListRequestImplCopyWith(
          _$PushNotificationsListRequestImpl value,
          $Res Function(_$PushNotificationsListRequestImpl) then) =
      __$$PushNotificationsListRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int page, int size});
}

/// @nodoc
class __$$PushNotificationsListRequestImplCopyWithImpl<$Res>
    extends _$PushNotificationsListRequestCopyWithImpl<$Res,
        _$PushNotificationsListRequestImpl>
    implements _$$PushNotificationsListRequestImplCopyWith<$Res> {
  __$$PushNotificationsListRequestImplCopyWithImpl(
      _$PushNotificationsListRequestImpl _value,
      $Res Function(_$PushNotificationsListRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of PushNotificationsListRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = null,
    Object? size = null,
  }) {
    return _then(_$PushNotificationsListRequestImpl(
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
class _$PushNotificationsListRequestImpl
    implements _PushNotificationsListRequest {
  const _$PushNotificationsListRequestImpl(
      {required this.page, required this.size});

  factory _$PushNotificationsListRequestImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$PushNotificationsListRequestImplFromJson(json);

  @override
  final int page;
  @override
  final int size;

  @override
  String toString() {
    return 'PushNotificationsListRequest(page: $page, size: $size)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PushNotificationsListRequestImpl &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.size, size) || other.size == size));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, page, size);

  /// Create a copy of PushNotificationsListRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PushNotificationsListRequestImplCopyWith<
          _$PushNotificationsListRequestImpl>
      get copyWith => __$$PushNotificationsListRequestImplCopyWithImpl<
          _$PushNotificationsListRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PushNotificationsListRequestImplToJson(
      this,
    );
  }
}

abstract class _PushNotificationsListRequest
    implements PushNotificationsListRequest {
  const factory _PushNotificationsListRequest(
      {required final int page,
      required final int size}) = _$PushNotificationsListRequestImpl;

  factory _PushNotificationsListRequest.fromJson(Map<String, dynamic> json) =
      _$PushNotificationsListRequestImpl.fromJson;

  @override
  int get page;
  @override
  int get size;

  /// Create a copy of PushNotificationsListRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PushNotificationsListRequestImplCopyWith<
          _$PushNotificationsListRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}
