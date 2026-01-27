// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'balance_load_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BalanceLoadRequest _$BalanceLoadRequestFromJson(Map<String, dynamic> json) {
  return _BalanceLoadRequest.fromJson(json);
}

/// @nodoc
mixin _$BalanceLoadRequest {
  double get amount => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get document => throw _privateConstructorUsedError;
  @JsonKey(name: 'packageId')
  String get packageId => throw _privateConstructorUsedError;

  /// Serializes this BalanceLoadRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BalanceLoadRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BalanceLoadRequestCopyWith<BalanceLoadRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BalanceLoadRequestCopyWith<$Res> {
  factory $BalanceLoadRequestCopyWith(
          BalanceLoadRequest value, $Res Function(BalanceLoadRequest) then) =
      _$BalanceLoadRequestCopyWithImpl<$Res, BalanceLoadRequest>;
  @useResult
  $Res call(
      {double amount,
      String description,
      String document,
      @JsonKey(name: 'packageId') String packageId});
}

/// @nodoc
class _$BalanceLoadRequestCopyWithImpl<$Res, $Val extends BalanceLoadRequest>
    implements $BalanceLoadRequestCopyWith<$Res> {
  _$BalanceLoadRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BalanceLoadRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? description = null,
    Object? document = null,
    Object? packageId = null,
  }) {
    return _then(_value.copyWith(
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      document: null == document
          ? _value.document
          : document // ignore: cast_nullable_to_non_nullable
              as String,
      packageId: null == packageId
          ? _value.packageId
          : packageId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BalanceLoadRequestImplCopyWith<$Res>
    implements $BalanceLoadRequestCopyWith<$Res> {
  factory _$$BalanceLoadRequestImplCopyWith(_$BalanceLoadRequestImpl value,
          $Res Function(_$BalanceLoadRequestImpl) then) =
      __$$BalanceLoadRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double amount,
      String description,
      String document,
      @JsonKey(name: 'packageId') String packageId});
}

/// @nodoc
class __$$BalanceLoadRequestImplCopyWithImpl<$Res>
    extends _$BalanceLoadRequestCopyWithImpl<$Res, _$BalanceLoadRequestImpl>
    implements _$$BalanceLoadRequestImplCopyWith<$Res> {
  __$$BalanceLoadRequestImplCopyWithImpl(_$BalanceLoadRequestImpl _value,
      $Res Function(_$BalanceLoadRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of BalanceLoadRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? description = null,
    Object? document = null,
    Object? packageId = null,
  }) {
    return _then(_$BalanceLoadRequestImpl(
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      document: null == document
          ? _value.document
          : document // ignore: cast_nullable_to_non_nullable
              as String,
      packageId: null == packageId
          ? _value.packageId
          : packageId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BalanceLoadRequestImpl implements _BalanceLoadRequest {
  const _$BalanceLoadRequestImpl(
      {required this.amount,
      required this.description,
      required this.document,
      @JsonKey(name: 'packageId') required this.packageId});

  factory _$BalanceLoadRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$BalanceLoadRequestImplFromJson(json);

  @override
  final double amount;
  @override
  final String description;
  @override
  final String document;
  @override
  @JsonKey(name: 'packageId')
  final String packageId;

  @override
  String toString() {
    return 'BalanceLoadRequest(amount: $amount, description: $description, document: $document, packageId: $packageId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BalanceLoadRequestImpl &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.document, document) ||
                other.document == document) &&
            (identical(other.packageId, packageId) ||
                other.packageId == packageId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, amount, description, document, packageId);

  /// Create a copy of BalanceLoadRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BalanceLoadRequestImplCopyWith<_$BalanceLoadRequestImpl> get copyWith =>
      __$$BalanceLoadRequestImplCopyWithImpl<_$BalanceLoadRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BalanceLoadRequestImplToJson(
      this,
    );
  }
}

abstract class _BalanceLoadRequest implements BalanceLoadRequest {
  const factory _BalanceLoadRequest(
          {required final double amount,
          required final String description,
          required final String document,
          @JsonKey(name: 'packageId') required final String packageId}) =
      _$BalanceLoadRequestImpl;

  factory _BalanceLoadRequest.fromJson(Map<String, dynamic> json) =
      _$BalanceLoadRequestImpl.fromJson;

  @override
  double get amount;
  @override
  String get description;
  @override
  String get document;
  @override
  @JsonKey(name: 'packageId')
  String get packageId;

  /// Create a copy of BalanceLoadRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BalanceLoadRequestImplCopyWith<_$BalanceLoadRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
