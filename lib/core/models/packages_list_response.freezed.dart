// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'packages_list_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Package _$PackageFromJson(Map<String, dynamic> json) {
  return _Package.fromJson(json);
}

/// @nodoc
mixin _$Package {
  @JsonKey(name: 'createdAt')
  String? get createdAt => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  double? get discount => throw _privateConstructorUsedError;
  @JsonKey(name: 'discountType')
  String? get discountType => throw _privateConstructorUsedError;
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'isActive')
  bool? get isActive => throw _privateConstructorUsedError;
  @JsonKey(name: 'lastModifiedAt')
  String? get lastModifiedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'packageName')
  String? get packageName => throw _privateConstructorUsedError;
  double? get price => throw _privateConstructorUsedError;
  @JsonKey(name: 'smsAmount')
  int? get smsAmount => throw _privateConstructorUsedError;

  /// Serializes this Package to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Package
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PackageCopyWith<Package> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PackageCopyWith<$Res> {
  factory $PackageCopyWith(Package value, $Res Function(Package) then) =
      _$PackageCopyWithImpl<$Res, Package>;
  @useResult
  $Res call(
      {@JsonKey(name: 'createdAt') String? createdAt,
      String? description,
      double? discount,
      @JsonKey(name: 'discountType') String? discountType,
      String? id,
      @JsonKey(name: 'isActive') bool? isActive,
      @JsonKey(name: 'lastModifiedAt') String? lastModifiedAt,
      @JsonKey(name: 'packageName') String? packageName,
      double? price,
      @JsonKey(name: 'smsAmount') int? smsAmount});
}

/// @nodoc
class _$PackageCopyWithImpl<$Res, $Val extends Package>
    implements $PackageCopyWith<$Res> {
  _$PackageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Package
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? createdAt = freezed,
    Object? description = freezed,
    Object? discount = freezed,
    Object? discountType = freezed,
    Object? id = freezed,
    Object? isActive = freezed,
    Object? lastModifiedAt = freezed,
    Object? packageName = freezed,
    Object? price = freezed,
    Object? smsAmount = freezed,
  }) {
    return _then(_value.copyWith(
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      discount: freezed == discount
          ? _value.discount
          : discount // ignore: cast_nullable_to_non_nullable
              as double?,
      discountType: freezed == discountType
          ? _value.discountType
          : discountType // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: freezed == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool?,
      lastModifiedAt: freezed == lastModifiedAt
          ? _value.lastModifiedAt
          : lastModifiedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      packageName: freezed == packageName
          ? _value.packageName
          : packageName // ignore: cast_nullable_to_non_nullable
              as String?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double?,
      smsAmount: freezed == smsAmount
          ? _value.smsAmount
          : smsAmount // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PackageImplCopyWith<$Res> implements $PackageCopyWith<$Res> {
  factory _$$PackageImplCopyWith(
          _$PackageImpl value, $Res Function(_$PackageImpl) then) =
      __$$PackageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'createdAt') String? createdAt,
      String? description,
      double? discount,
      @JsonKey(name: 'discountType') String? discountType,
      String? id,
      @JsonKey(name: 'isActive') bool? isActive,
      @JsonKey(name: 'lastModifiedAt') String? lastModifiedAt,
      @JsonKey(name: 'packageName') String? packageName,
      double? price,
      @JsonKey(name: 'smsAmount') int? smsAmount});
}

/// @nodoc
class __$$PackageImplCopyWithImpl<$Res>
    extends _$PackageCopyWithImpl<$Res, _$PackageImpl>
    implements _$$PackageImplCopyWith<$Res> {
  __$$PackageImplCopyWithImpl(
      _$PackageImpl _value, $Res Function(_$PackageImpl) _then)
      : super(_value, _then);

  /// Create a copy of Package
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? createdAt = freezed,
    Object? description = freezed,
    Object? discount = freezed,
    Object? discountType = freezed,
    Object? id = freezed,
    Object? isActive = freezed,
    Object? lastModifiedAt = freezed,
    Object? packageName = freezed,
    Object? price = freezed,
    Object? smsAmount = freezed,
  }) {
    return _then(_$PackageImpl(
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      discount: freezed == discount
          ? _value.discount
          : discount // ignore: cast_nullable_to_non_nullable
              as double?,
      discountType: freezed == discountType
          ? _value.discountType
          : discountType // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: freezed == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool?,
      lastModifiedAt: freezed == lastModifiedAt
          ? _value.lastModifiedAt
          : lastModifiedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      packageName: freezed == packageName
          ? _value.packageName
          : packageName // ignore: cast_nullable_to_non_nullable
              as String?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double?,
      smsAmount: freezed == smsAmount
          ? _value.smsAmount
          : smsAmount // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PackageImpl implements _Package {
  const _$PackageImpl(
      {@JsonKey(name: 'createdAt') this.createdAt,
      this.description,
      this.discount,
      @JsonKey(name: 'discountType') this.discountType,
      this.id,
      @JsonKey(name: 'isActive') this.isActive,
      @JsonKey(name: 'lastModifiedAt') this.lastModifiedAt,
      @JsonKey(name: 'packageName') this.packageName,
      this.price,
      @JsonKey(name: 'smsAmount') this.smsAmount});

  factory _$PackageImpl.fromJson(Map<String, dynamic> json) =>
      _$$PackageImplFromJson(json);

  @override
  @JsonKey(name: 'createdAt')
  final String? createdAt;
  @override
  final String? description;
  @override
  final double? discount;
  @override
  @JsonKey(name: 'discountType')
  final String? discountType;
  @override
  final String? id;
  @override
  @JsonKey(name: 'isActive')
  final bool? isActive;
  @override
  @JsonKey(name: 'lastModifiedAt')
  final String? lastModifiedAt;
  @override
  @JsonKey(name: 'packageName')
  final String? packageName;
  @override
  final double? price;
  @override
  @JsonKey(name: 'smsAmount')
  final int? smsAmount;

  @override
  String toString() {
    return 'Package(createdAt: $createdAt, description: $description, discount: $discount, discountType: $discountType, id: $id, isActive: $isActive, lastModifiedAt: $lastModifiedAt, packageName: $packageName, price: $price, smsAmount: $smsAmount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PackageImpl &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.discount, discount) ||
                other.discount == discount) &&
            (identical(other.discountType, discountType) ||
                other.discountType == discountType) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.lastModifiedAt, lastModifiedAt) ||
                other.lastModifiedAt == lastModifiedAt) &&
            (identical(other.packageName, packageName) ||
                other.packageName == packageName) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.smsAmount, smsAmount) ||
                other.smsAmount == smsAmount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      createdAt,
      description,
      discount,
      discountType,
      id,
      isActive,
      lastModifiedAt,
      packageName,
      price,
      smsAmount);

  /// Create a copy of Package
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PackageImplCopyWith<_$PackageImpl> get copyWith =>
      __$$PackageImplCopyWithImpl<_$PackageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PackageImplToJson(
      this,
    );
  }
}

abstract class _Package implements Package {
  const factory _Package(
      {@JsonKey(name: 'createdAt') final String? createdAt,
      final String? description,
      final double? discount,
      @JsonKey(name: 'discountType') final String? discountType,
      final String? id,
      @JsonKey(name: 'isActive') final bool? isActive,
      @JsonKey(name: 'lastModifiedAt') final String? lastModifiedAt,
      @JsonKey(name: 'packageName') final String? packageName,
      final double? price,
      @JsonKey(name: 'smsAmount') final int? smsAmount}) = _$PackageImpl;

  factory _Package.fromJson(Map<String, dynamic> json) = _$PackageImpl.fromJson;

  @override
  @JsonKey(name: 'createdAt')
  String? get createdAt;
  @override
  String? get description;
  @override
  double? get discount;
  @override
  @JsonKey(name: 'discountType')
  String? get discountType;
  @override
  String? get id;
  @override
  @JsonKey(name: 'isActive')
  bool? get isActive;
  @override
  @JsonKey(name: 'lastModifiedAt')
  String? get lastModifiedAt;
  @override
  @JsonKey(name: 'packageName')
  String? get packageName;
  @override
  double? get price;
  @override
  @JsonKey(name: 'smsAmount')
  int? get smsAmount;

  /// Create a copy of Package
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PackageImplCopyWith<_$PackageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PackagesListData _$PackagesListDataFromJson(Map<String, dynamic> json) {
  return _PackagesListData.fromJson(json);
}

/// @nodoc
mixin _$PackagesListData {
  List<Package>? get content => throw _privateConstructorUsedError;
  @JsonKey(name: 'totalElements')
  int? get totalElements => throw _privateConstructorUsedError;

  /// Serializes this PackagesListData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PackagesListData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PackagesListDataCopyWith<PackagesListData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PackagesListDataCopyWith<$Res> {
  factory $PackagesListDataCopyWith(
          PackagesListData value, $Res Function(PackagesListData) then) =
      _$PackagesListDataCopyWithImpl<$Res, PackagesListData>;
  @useResult
  $Res call(
      {List<Package>? content,
      @JsonKey(name: 'totalElements') int? totalElements});
}

/// @nodoc
class _$PackagesListDataCopyWithImpl<$Res, $Val extends PackagesListData>
    implements $PackagesListDataCopyWith<$Res> {
  _$PackagesListDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PackagesListData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? content = freezed,
    Object? totalElements = freezed,
  }) {
    return _then(_value.copyWith(
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as List<Package>?,
      totalElements: freezed == totalElements
          ? _value.totalElements
          : totalElements // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PackagesListDataImplCopyWith<$Res>
    implements $PackagesListDataCopyWith<$Res> {
  factory _$$PackagesListDataImplCopyWith(_$PackagesListDataImpl value,
          $Res Function(_$PackagesListDataImpl) then) =
      __$$PackagesListDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Package>? content,
      @JsonKey(name: 'totalElements') int? totalElements});
}

/// @nodoc
class __$$PackagesListDataImplCopyWithImpl<$Res>
    extends _$PackagesListDataCopyWithImpl<$Res, _$PackagesListDataImpl>
    implements _$$PackagesListDataImplCopyWith<$Res> {
  __$$PackagesListDataImplCopyWithImpl(_$PackagesListDataImpl _value,
      $Res Function(_$PackagesListDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of PackagesListData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? content = freezed,
    Object? totalElements = freezed,
  }) {
    return _then(_$PackagesListDataImpl(
      content: freezed == content
          ? _value._content
          : content // ignore: cast_nullable_to_non_nullable
              as List<Package>?,
      totalElements: freezed == totalElements
          ? _value.totalElements
          : totalElements // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PackagesListDataImpl implements _PackagesListData {
  const _$PackagesListDataImpl(
      {final List<Package>? content,
      @JsonKey(name: 'totalElements') this.totalElements})
      : _content = content;

  factory _$PackagesListDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$PackagesListDataImplFromJson(json);

  final List<Package>? _content;
  @override
  List<Package>? get content {
    final value = _content;
    if (value == null) return null;
    if (_content is EqualUnmodifiableListView) return _content;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'totalElements')
  final int? totalElements;

  @override
  String toString() {
    return 'PackagesListData(content: $content, totalElements: $totalElements)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PackagesListDataImpl &&
            const DeepCollectionEquality().equals(other._content, _content) &&
            (identical(other.totalElements, totalElements) ||
                other.totalElements == totalElements));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_content), totalElements);

  /// Create a copy of PackagesListData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PackagesListDataImplCopyWith<_$PackagesListDataImpl> get copyWith =>
      __$$PackagesListDataImplCopyWithImpl<_$PackagesListDataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PackagesListDataImplToJson(
      this,
    );
  }
}

abstract class _PackagesListData implements PackagesListData {
  const factory _PackagesListData(
          {final List<Package>? content,
          @JsonKey(name: 'totalElements') final int? totalElements}) =
      _$PackagesListDataImpl;

  factory _PackagesListData.fromJson(Map<String, dynamic> json) =
      _$PackagesListDataImpl.fromJson;

  @override
  List<Package>? get content;
  @override
  @JsonKey(name: 'totalElements')
  int? get totalElements;

  /// Create a copy of PackagesListData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PackagesListDataImplCopyWith<_$PackagesListDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PackagesListResponse _$PackagesListResponseFromJson(Map<String, dynamic> json) {
  return _PackagesListResponse.fromJson(json);
}

/// @nodoc
mixin _$PackagesListResponse {
  String? get status => throw _privateConstructorUsedError;
  String? get code => throw _privateConstructorUsedError;
  PackagesListData? get data => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  /// Serializes this PackagesListResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PackagesListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PackagesListResponseCopyWith<PackagesListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PackagesListResponseCopyWith<$Res> {
  factory $PackagesListResponseCopyWith(PackagesListResponse value,
          $Res Function(PackagesListResponse) then) =
      _$PackagesListResponseCopyWithImpl<$Res, PackagesListResponse>;
  @useResult
  $Res call(
      {String? status, String? code, PackagesListData? data, String? message});

  $PackagesListDataCopyWith<$Res>? get data;
}

/// @nodoc
class _$PackagesListResponseCopyWithImpl<$Res,
        $Val extends PackagesListResponse>
    implements $PackagesListResponseCopyWith<$Res> {
  _$PackagesListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PackagesListResponse
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
              as PackagesListData?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of PackagesListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PackagesListDataCopyWith<$Res>? get data {
    if (_value.data == null) {
      return null;
    }

    return $PackagesListDataCopyWith<$Res>(_value.data!, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PackagesListResponseImplCopyWith<$Res>
    implements $PackagesListResponseCopyWith<$Res> {
  factory _$$PackagesListResponseImplCopyWith(_$PackagesListResponseImpl value,
          $Res Function(_$PackagesListResponseImpl) then) =
      __$$PackagesListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? status, String? code, PackagesListData? data, String? message});

  @override
  $PackagesListDataCopyWith<$Res>? get data;
}

/// @nodoc
class __$$PackagesListResponseImplCopyWithImpl<$Res>
    extends _$PackagesListResponseCopyWithImpl<$Res, _$PackagesListResponseImpl>
    implements _$$PackagesListResponseImplCopyWith<$Res> {
  __$$PackagesListResponseImplCopyWithImpl(_$PackagesListResponseImpl _value,
      $Res Function(_$PackagesListResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of PackagesListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
    Object? code = freezed,
    Object? data = freezed,
    Object? message = freezed,
  }) {
    return _then(_$PackagesListResponseImpl(
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
              as PackagesListData?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PackagesListResponseImpl implements _PackagesListResponse {
  const _$PackagesListResponseImpl(
      {this.status, this.code, this.data, this.message});

  factory _$PackagesListResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$PackagesListResponseImplFromJson(json);

  @override
  final String? status;
  @override
  final String? code;
  @override
  final PackagesListData? data;
  @override
  final String? message;

  @override
  String toString() {
    return 'PackagesListResponse(status: $status, code: $code, data: $data, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PackagesListResponseImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, code, data, message);

  /// Create a copy of PackagesListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PackagesListResponseImplCopyWith<_$PackagesListResponseImpl>
      get copyWith =>
          __$$PackagesListResponseImplCopyWithImpl<_$PackagesListResponseImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PackagesListResponseImplToJson(
      this,
    );
  }
}

abstract class _PackagesListResponse implements PackagesListResponse {
  const factory _PackagesListResponse(
      {final String? status,
      final String? code,
      final PackagesListData? data,
      final String? message}) = _$PackagesListResponseImpl;

  factory _PackagesListResponse.fromJson(Map<String, dynamic> json) =
      _$PackagesListResponseImpl.fromJson;

  @override
  String? get status;
  @override
  String? get code;
  @override
  PackagesListData? get data;
  @override
  String? get message;

  /// Create a copy of PackagesListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PackagesListResponseImplCopyWith<_$PackagesListResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
