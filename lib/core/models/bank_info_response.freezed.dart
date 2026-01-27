// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bank_info_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BankInfo _$BankInfoFromJson(Map<String, dynamic> json) {
  return _BankInfo.fromJson(json);
}

/// @nodoc
mixin _$BankInfo {
  @JsonKey(name: 'accountNumber')
  String? get accountNumber => throw _privateConstructorUsedError;
  String? get branch => throw _privateConstructorUsedError;
  @JsonKey(name: 'createdAt')
  String? get createdAt => throw _privateConstructorUsedError;
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'lastModifiedAt')
  String? get lastModifiedAt => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'qrCode')
  String? get qrCode => throw _privateConstructorUsedError;

  /// Serializes this BankInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BankInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BankInfoCopyWith<BankInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BankInfoCopyWith<$Res> {
  factory $BankInfoCopyWith(BankInfo value, $Res Function(BankInfo) then) =
      _$BankInfoCopyWithImpl<$Res, BankInfo>;
  @useResult
  $Res call(
      {@JsonKey(name: 'accountNumber') String? accountNumber,
      String? branch,
      @JsonKey(name: 'createdAt') String? createdAt,
      String? id,
      @JsonKey(name: 'lastModifiedAt') String? lastModifiedAt,
      String? name,
      @JsonKey(name: 'qrCode') String? qrCode});
}

/// @nodoc
class _$BankInfoCopyWithImpl<$Res, $Val extends BankInfo>
    implements $BankInfoCopyWith<$Res> {
  _$BankInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BankInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accountNumber = freezed,
    Object? branch = freezed,
    Object? createdAt = freezed,
    Object? id = freezed,
    Object? lastModifiedAt = freezed,
    Object? name = freezed,
    Object? qrCode = freezed,
  }) {
    return _then(_value.copyWith(
      accountNumber: freezed == accountNumber
          ? _value.accountNumber
          : accountNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      branch: freezed == branch
          ? _value.branch
          : branch // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      lastModifiedAt: freezed == lastModifiedAt
          ? _value.lastModifiedAt
          : lastModifiedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      qrCode: freezed == qrCode
          ? _value.qrCode
          : qrCode // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BankInfoImplCopyWith<$Res>
    implements $BankInfoCopyWith<$Res> {
  factory _$$BankInfoImplCopyWith(
          _$BankInfoImpl value, $Res Function(_$BankInfoImpl) then) =
      __$$BankInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'accountNumber') String? accountNumber,
      String? branch,
      @JsonKey(name: 'createdAt') String? createdAt,
      String? id,
      @JsonKey(name: 'lastModifiedAt') String? lastModifiedAt,
      String? name,
      @JsonKey(name: 'qrCode') String? qrCode});
}

/// @nodoc
class __$$BankInfoImplCopyWithImpl<$Res>
    extends _$BankInfoCopyWithImpl<$Res, _$BankInfoImpl>
    implements _$$BankInfoImplCopyWith<$Res> {
  __$$BankInfoImplCopyWithImpl(
      _$BankInfoImpl _value, $Res Function(_$BankInfoImpl) _then)
      : super(_value, _then);

  /// Create a copy of BankInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accountNumber = freezed,
    Object? branch = freezed,
    Object? createdAt = freezed,
    Object? id = freezed,
    Object? lastModifiedAt = freezed,
    Object? name = freezed,
    Object? qrCode = freezed,
  }) {
    return _then(_$BankInfoImpl(
      accountNumber: freezed == accountNumber
          ? _value.accountNumber
          : accountNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      branch: freezed == branch
          ? _value.branch
          : branch // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      lastModifiedAt: freezed == lastModifiedAt
          ? _value.lastModifiedAt
          : lastModifiedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      qrCode: freezed == qrCode
          ? _value.qrCode
          : qrCode // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BankInfoImpl implements _BankInfo {
  const _$BankInfoImpl(
      {@JsonKey(name: 'accountNumber') this.accountNumber,
      this.branch,
      @JsonKey(name: 'createdAt') this.createdAt,
      this.id,
      @JsonKey(name: 'lastModifiedAt') this.lastModifiedAt,
      this.name,
      @JsonKey(name: 'qrCode') this.qrCode});

  factory _$BankInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$BankInfoImplFromJson(json);

  @override
  @JsonKey(name: 'accountNumber')
  final String? accountNumber;
  @override
  final String? branch;
  @override
  @JsonKey(name: 'createdAt')
  final String? createdAt;
  @override
  final String? id;
  @override
  @JsonKey(name: 'lastModifiedAt')
  final String? lastModifiedAt;
  @override
  final String? name;
  @override
  @JsonKey(name: 'qrCode')
  final String? qrCode;

  @override
  String toString() {
    return 'BankInfo(accountNumber: $accountNumber, branch: $branch, createdAt: $createdAt, id: $id, lastModifiedAt: $lastModifiedAt, name: $name, qrCode: $qrCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BankInfoImpl &&
            (identical(other.accountNumber, accountNumber) ||
                other.accountNumber == accountNumber) &&
            (identical(other.branch, branch) || other.branch == branch) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.lastModifiedAt, lastModifiedAt) ||
                other.lastModifiedAt == lastModifiedAt) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.qrCode, qrCode) || other.qrCode == qrCode));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, accountNumber, branch, createdAt,
      id, lastModifiedAt, name, qrCode);

  /// Create a copy of BankInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BankInfoImplCopyWith<_$BankInfoImpl> get copyWith =>
      __$$BankInfoImplCopyWithImpl<_$BankInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BankInfoImplToJson(
      this,
    );
  }
}

abstract class _BankInfo implements BankInfo {
  const factory _BankInfo(
      {@JsonKey(name: 'accountNumber') final String? accountNumber,
      final String? branch,
      @JsonKey(name: 'createdAt') final String? createdAt,
      final String? id,
      @JsonKey(name: 'lastModifiedAt') final String? lastModifiedAt,
      final String? name,
      @JsonKey(name: 'qrCode') final String? qrCode}) = _$BankInfoImpl;

  factory _BankInfo.fromJson(Map<String, dynamic> json) =
      _$BankInfoImpl.fromJson;

  @override
  @JsonKey(name: 'accountNumber')
  String? get accountNumber;
  @override
  String? get branch;
  @override
  @JsonKey(name: 'createdAt')
  String? get createdAt;
  @override
  String? get id;
  @override
  @JsonKey(name: 'lastModifiedAt')
  String? get lastModifiedAt;
  @override
  String? get name;
  @override
  @JsonKey(name: 'qrCode')
  String? get qrCode;

  /// Create a copy of BankInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BankInfoImplCopyWith<_$BankInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BankInfoResponse _$BankInfoResponseFromJson(Map<String, dynamic> json) {
  return _BankInfoResponse.fromJson(json);
}

/// @nodoc
mixin _$BankInfoResponse {
  String? get status => throw _privateConstructorUsedError;
  String? get code => throw _privateConstructorUsedError;
  BankInfo? get data => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  /// Serializes this BankInfoResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BankInfoResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BankInfoResponseCopyWith<BankInfoResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BankInfoResponseCopyWith<$Res> {
  factory $BankInfoResponseCopyWith(
          BankInfoResponse value, $Res Function(BankInfoResponse) then) =
      _$BankInfoResponseCopyWithImpl<$Res, BankInfoResponse>;
  @useResult
  $Res call({String? status, String? code, BankInfo? data, String? message});

  $BankInfoCopyWith<$Res>? get data;
}

/// @nodoc
class _$BankInfoResponseCopyWithImpl<$Res, $Val extends BankInfoResponse>
    implements $BankInfoResponseCopyWith<$Res> {
  _$BankInfoResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BankInfoResponse
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
              as BankInfo?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of BankInfoResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BankInfoCopyWith<$Res>? get data {
    if (_value.data == null) {
      return null;
    }

    return $BankInfoCopyWith<$Res>(_value.data!, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BankInfoResponseImplCopyWith<$Res>
    implements $BankInfoResponseCopyWith<$Res> {
  factory _$$BankInfoResponseImplCopyWith(_$BankInfoResponseImpl value,
          $Res Function(_$BankInfoResponseImpl) then) =
      __$$BankInfoResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? status, String? code, BankInfo? data, String? message});

  @override
  $BankInfoCopyWith<$Res>? get data;
}

/// @nodoc
class __$$BankInfoResponseImplCopyWithImpl<$Res>
    extends _$BankInfoResponseCopyWithImpl<$Res, _$BankInfoResponseImpl>
    implements _$$BankInfoResponseImplCopyWith<$Res> {
  __$$BankInfoResponseImplCopyWithImpl(_$BankInfoResponseImpl _value,
      $Res Function(_$BankInfoResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of BankInfoResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
    Object? code = freezed,
    Object? data = freezed,
    Object? message = freezed,
  }) {
    return _then(_$BankInfoResponseImpl(
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
              as BankInfo?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BankInfoResponseImpl implements _BankInfoResponse {
  const _$BankInfoResponseImpl(
      {this.status, this.code, this.data, this.message});

  factory _$BankInfoResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$BankInfoResponseImplFromJson(json);

  @override
  final String? status;
  @override
  final String? code;
  @override
  final BankInfo? data;
  @override
  final String? message;

  @override
  String toString() {
    return 'BankInfoResponse(status: $status, code: $code, data: $data, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BankInfoResponseImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, code, data, message);

  /// Create a copy of BankInfoResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BankInfoResponseImplCopyWith<_$BankInfoResponseImpl> get copyWith =>
      __$$BankInfoResponseImplCopyWithImpl<_$BankInfoResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BankInfoResponseImplToJson(
      this,
    );
  }
}

abstract class _BankInfoResponse implements BankInfoResponse {
  const factory _BankInfoResponse(
      {final String? status,
      final String? code,
      final BankInfo? data,
      final String? message}) = _$BankInfoResponseImpl;

  factory _BankInfoResponse.fromJson(Map<String, dynamic> json) =
      _$BankInfoResponseImpl.fromJson;

  @override
  String? get status;
  @override
  String? get code;
  @override
  BankInfo? get data;
  @override
  String? get message;

  /// Create a copy of BankInfoResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BankInfoResponseImplCopyWith<_$BankInfoResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
