// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'member_register_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MemberRegisterRequest _$MemberRegisterRequestFromJson(
    Map<String, dynamic> json) {
  return _MemberRegisterRequest.fromJson(json);
}

/// @nodoc
mixin _$MemberRegisterRequest {
  @JsonKey(name: 'fullName')
  String get fullName => throw _privateConstructorUsedError;
  @JsonKey(name: 'mobileNumber')
  String get mobileNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'boothName')
  String get boothName => throw _privateConstructorUsedError;

  /// Serializes this MemberRegisterRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MemberRegisterRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MemberRegisterRequestCopyWith<MemberRegisterRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MemberRegisterRequestCopyWith<$Res> {
  factory $MemberRegisterRequestCopyWith(MemberRegisterRequest value,
          $Res Function(MemberRegisterRequest) then) =
      _$MemberRegisterRequestCopyWithImpl<$Res, MemberRegisterRequest>;
  @useResult
  $Res call(
      {@JsonKey(name: 'fullName') String fullName,
      @JsonKey(name: 'mobileNumber') String mobileNumber,
      @JsonKey(name: 'boothName') String boothName});
}

/// @nodoc
class _$MemberRegisterRequestCopyWithImpl<$Res,
        $Val extends MemberRegisterRequest>
    implements $MemberRegisterRequestCopyWith<$Res> {
  _$MemberRegisterRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MemberRegisterRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fullName = null,
    Object? mobileNumber = null,
    Object? boothName = null,
  }) {
    return _then(_value.copyWith(
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      mobileNumber: null == mobileNumber
          ? _value.mobileNumber
          : mobileNumber // ignore: cast_nullable_to_non_nullable
              as String,
      boothName: null == boothName
          ? _value.boothName
          : boothName // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MemberRegisterRequestImplCopyWith<$Res>
    implements $MemberRegisterRequestCopyWith<$Res> {
  factory _$$MemberRegisterRequestImplCopyWith(
          _$MemberRegisterRequestImpl value,
          $Res Function(_$MemberRegisterRequestImpl) then) =
      __$$MemberRegisterRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'fullName') String fullName,
      @JsonKey(name: 'mobileNumber') String mobileNumber,
      @JsonKey(name: 'boothName') String boothName});
}

/// @nodoc
class __$$MemberRegisterRequestImplCopyWithImpl<$Res>
    extends _$MemberRegisterRequestCopyWithImpl<$Res,
        _$MemberRegisterRequestImpl>
    implements _$$MemberRegisterRequestImplCopyWith<$Res> {
  __$$MemberRegisterRequestImplCopyWithImpl(_$MemberRegisterRequestImpl _value,
      $Res Function(_$MemberRegisterRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of MemberRegisterRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fullName = null,
    Object? mobileNumber = null,
    Object? boothName = null,
  }) {
    return _then(_$MemberRegisterRequestImpl(
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      mobileNumber: null == mobileNumber
          ? _value.mobileNumber
          : mobileNumber // ignore: cast_nullable_to_non_nullable
              as String,
      boothName: null == boothName
          ? _value.boothName
          : boothName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MemberRegisterRequestImpl implements _MemberRegisterRequest {
  const _$MemberRegisterRequestImpl(
      {@JsonKey(name: 'fullName') required this.fullName,
      @JsonKey(name: 'mobileNumber') required this.mobileNumber,
      @JsonKey(name: 'boothName') required this.boothName});

  factory _$MemberRegisterRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$MemberRegisterRequestImplFromJson(json);

  @override
  @JsonKey(name: 'fullName')
  final String fullName;
  @override
  @JsonKey(name: 'mobileNumber')
  final String mobileNumber;
  @override
  @JsonKey(name: 'boothName')
  final String boothName;

  @override
  String toString() {
    return 'MemberRegisterRequest(fullName: $fullName, mobileNumber: $mobileNumber, boothName: $boothName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MemberRegisterRequestImpl &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.mobileNumber, mobileNumber) ||
                other.mobileNumber == mobileNumber) &&
            (identical(other.boothName, boothName) ||
                other.boothName == boothName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, fullName, mobileNumber, boothName);

  /// Create a copy of MemberRegisterRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MemberRegisterRequestImplCopyWith<_$MemberRegisterRequestImpl>
      get copyWith => __$$MemberRegisterRequestImplCopyWithImpl<
          _$MemberRegisterRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MemberRegisterRequestImplToJson(
      this,
    );
  }
}

abstract class _MemberRegisterRequest implements MemberRegisterRequest {
  const factory _MemberRegisterRequest(
          {@JsonKey(name: 'fullName') required final String fullName,
          @JsonKey(name: 'mobileNumber') required final String mobileNumber,
          @JsonKey(name: 'boothName') required final String boothName}) =
      _$MemberRegisterRequestImpl;

  factory _MemberRegisterRequest.fromJson(Map<String, dynamic> json) =
      _$MemberRegisterRequestImpl.fromJson;

  @override
  @JsonKey(name: 'fullName')
  String get fullName;
  @override
  @JsonKey(name: 'mobileNumber')
  String get mobileNumber;
  @override
  @JsonKey(name: 'boothName')
  String get boothName;

  /// Create a copy of MemberRegisterRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MemberRegisterRequestImplCopyWith<_$MemberRegisterRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}
