// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booth_list_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Booth _$BoothFromJson(Map<String, dynamic> json) {
  return _Booth.fromJson(json);
}

/// @nodoc
mixin _$Booth {
  @JsonKey(name: 'createdAt')
  String? get createdAt => throw _privateConstructorUsedError;
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'lastModifiedAt')
  String? get lastModifiedAt => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;

  /// Serializes this Booth to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Booth
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BoothCopyWith<Booth> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BoothCopyWith<$Res> {
  factory $BoothCopyWith(Booth value, $Res Function(Booth) then) =
      _$BoothCopyWithImpl<$Res, Booth>;
  @useResult
  $Res call(
      {@JsonKey(name: 'createdAt') String? createdAt,
      String? id,
      @JsonKey(name: 'lastModifiedAt') String? lastModifiedAt,
      String? name,
      String? status});
}

/// @nodoc
class _$BoothCopyWithImpl<$Res, $Val extends Booth>
    implements $BoothCopyWith<$Res> {
  _$BoothCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Booth
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? createdAt = freezed,
    Object? id = freezed,
    Object? lastModifiedAt = freezed,
    Object? name = freezed,
    Object? status = freezed,
  }) {
    return _then(_value.copyWith(
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
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BoothImplCopyWith<$Res> implements $BoothCopyWith<$Res> {
  factory _$$BoothImplCopyWith(
          _$BoothImpl value, $Res Function(_$BoothImpl) then) =
      __$$BoothImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'createdAt') String? createdAt,
      String? id,
      @JsonKey(name: 'lastModifiedAt') String? lastModifiedAt,
      String? name,
      String? status});
}

/// @nodoc
class __$$BoothImplCopyWithImpl<$Res>
    extends _$BoothCopyWithImpl<$Res, _$BoothImpl>
    implements _$$BoothImplCopyWith<$Res> {
  __$$BoothImplCopyWithImpl(
      _$BoothImpl _value, $Res Function(_$BoothImpl) _then)
      : super(_value, _then);

  /// Create a copy of Booth
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? createdAt = freezed,
    Object? id = freezed,
    Object? lastModifiedAt = freezed,
    Object? name = freezed,
    Object? status = freezed,
  }) {
    return _then(_$BoothImpl(
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
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BoothImpl implements _Booth {
  const _$BoothImpl(
      {@JsonKey(name: 'createdAt') this.createdAt,
      this.id,
      @JsonKey(name: 'lastModifiedAt') this.lastModifiedAt,
      this.name,
      this.status});

  factory _$BoothImpl.fromJson(Map<String, dynamic> json) =>
      _$$BoothImplFromJson(json);

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
  final String? status;

  @override
  String toString() {
    return 'Booth(createdAt: $createdAt, id: $id, lastModifiedAt: $lastModifiedAt, name: $name, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BoothImpl &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.lastModifiedAt, lastModifiedAt) ||
                other.lastModifiedAt == lastModifiedAt) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, createdAt, id, lastModifiedAt, name, status);

  /// Create a copy of Booth
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BoothImplCopyWith<_$BoothImpl> get copyWith =>
      __$$BoothImplCopyWithImpl<_$BoothImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BoothImplToJson(
      this,
    );
  }
}

abstract class _Booth implements Booth {
  const factory _Booth(
      {@JsonKey(name: 'createdAt') final String? createdAt,
      final String? id,
      @JsonKey(name: 'lastModifiedAt') final String? lastModifiedAt,
      final String? name,
      final String? status}) = _$BoothImpl;

  factory _Booth.fromJson(Map<String, dynamic> json) = _$BoothImpl.fromJson;

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
  String? get status;

  /// Create a copy of Booth
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BoothImplCopyWith<_$BoothImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BoothListData _$BoothListDataFromJson(Map<String, dynamic> json) {
  return _BoothListData.fromJson(json);
}

/// @nodoc
mixin _$BoothListData {
  List<Booth>? get content => throw _privateConstructorUsedError;
  @JsonKey(name: 'totalElements')
  int? get totalElements => throw _privateConstructorUsedError;

  /// Serializes this BoothListData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BoothListData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BoothListDataCopyWith<BoothListData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BoothListDataCopyWith<$Res> {
  factory $BoothListDataCopyWith(
          BoothListData value, $Res Function(BoothListData) then) =
      _$BoothListDataCopyWithImpl<$Res, BoothListData>;
  @useResult
  $Res call(
      {List<Booth>? content,
      @JsonKey(name: 'totalElements') int? totalElements});
}

/// @nodoc
class _$BoothListDataCopyWithImpl<$Res, $Val extends BoothListData>
    implements $BoothListDataCopyWith<$Res> {
  _$BoothListDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BoothListData
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
              as List<Booth>?,
      totalElements: freezed == totalElements
          ? _value.totalElements
          : totalElements // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BoothListDataImplCopyWith<$Res>
    implements $BoothListDataCopyWith<$Res> {
  factory _$$BoothListDataImplCopyWith(
          _$BoothListDataImpl value, $Res Function(_$BoothListDataImpl) then) =
      __$$BoothListDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Booth>? content,
      @JsonKey(name: 'totalElements') int? totalElements});
}

/// @nodoc
class __$$BoothListDataImplCopyWithImpl<$Res>
    extends _$BoothListDataCopyWithImpl<$Res, _$BoothListDataImpl>
    implements _$$BoothListDataImplCopyWith<$Res> {
  __$$BoothListDataImplCopyWithImpl(
      _$BoothListDataImpl _value, $Res Function(_$BoothListDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of BoothListData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? content = freezed,
    Object? totalElements = freezed,
  }) {
    return _then(_$BoothListDataImpl(
      content: freezed == content
          ? _value._content
          : content // ignore: cast_nullable_to_non_nullable
              as List<Booth>?,
      totalElements: freezed == totalElements
          ? _value.totalElements
          : totalElements // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BoothListDataImpl implements _BoothListData {
  const _$BoothListDataImpl(
      {final List<Booth>? content,
      @JsonKey(name: 'totalElements') this.totalElements})
      : _content = content;

  factory _$BoothListDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$BoothListDataImplFromJson(json);

  final List<Booth>? _content;
  @override
  List<Booth>? get content {
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
    return 'BoothListData(content: $content, totalElements: $totalElements)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BoothListDataImpl &&
            const DeepCollectionEquality().equals(other._content, _content) &&
            (identical(other.totalElements, totalElements) ||
                other.totalElements == totalElements));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_content), totalElements);

  /// Create a copy of BoothListData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BoothListDataImplCopyWith<_$BoothListDataImpl> get copyWith =>
      __$$BoothListDataImplCopyWithImpl<_$BoothListDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BoothListDataImplToJson(
      this,
    );
  }
}

abstract class _BoothListData implements BoothListData {
  const factory _BoothListData(
          {final List<Booth>? content,
          @JsonKey(name: 'totalElements') final int? totalElements}) =
      _$BoothListDataImpl;

  factory _BoothListData.fromJson(Map<String, dynamic> json) =
      _$BoothListDataImpl.fromJson;

  @override
  List<Booth>? get content;
  @override
  @JsonKey(name: 'totalElements')
  int? get totalElements;

  /// Create a copy of BoothListData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BoothListDataImplCopyWith<_$BoothListDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BoothListResponse _$BoothListResponseFromJson(Map<String, dynamic> json) {
  return _BoothListResponse.fromJson(json);
}

/// @nodoc
mixin _$BoothListResponse {
  String? get status => throw _privateConstructorUsedError;
  String? get code => throw _privateConstructorUsedError;
  BoothListData? get data => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  /// Serializes this BoothListResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BoothListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BoothListResponseCopyWith<BoothListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BoothListResponseCopyWith<$Res> {
  factory $BoothListResponseCopyWith(
          BoothListResponse value, $Res Function(BoothListResponse) then) =
      _$BoothListResponseCopyWithImpl<$Res, BoothListResponse>;
  @useResult
  $Res call(
      {String? status, String? code, BoothListData? data, String? message});

  $BoothListDataCopyWith<$Res>? get data;
}

/// @nodoc
class _$BoothListResponseCopyWithImpl<$Res, $Val extends BoothListResponse>
    implements $BoothListResponseCopyWith<$Res> {
  _$BoothListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BoothListResponse
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
              as BoothListData?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of BoothListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BoothListDataCopyWith<$Res>? get data {
    if (_value.data == null) {
      return null;
    }

    return $BoothListDataCopyWith<$Res>(_value.data!, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BoothListResponseImplCopyWith<$Res>
    implements $BoothListResponseCopyWith<$Res> {
  factory _$$BoothListResponseImplCopyWith(_$BoothListResponseImpl value,
          $Res Function(_$BoothListResponseImpl) then) =
      __$$BoothListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? status, String? code, BoothListData? data, String? message});

  @override
  $BoothListDataCopyWith<$Res>? get data;
}

/// @nodoc
class __$$BoothListResponseImplCopyWithImpl<$Res>
    extends _$BoothListResponseCopyWithImpl<$Res, _$BoothListResponseImpl>
    implements _$$BoothListResponseImplCopyWith<$Res> {
  __$$BoothListResponseImplCopyWithImpl(_$BoothListResponseImpl _value,
      $Res Function(_$BoothListResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of BoothListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
    Object? code = freezed,
    Object? data = freezed,
    Object? message = freezed,
  }) {
    return _then(_$BoothListResponseImpl(
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
              as BoothListData?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BoothListResponseImpl implements _BoothListResponse {
  const _$BoothListResponseImpl(
      {this.status, this.code, this.data, this.message});

  factory _$BoothListResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$BoothListResponseImplFromJson(json);

  @override
  final String? status;
  @override
  final String? code;
  @override
  final BoothListData? data;
  @override
  final String? message;

  @override
  String toString() {
    return 'BoothListResponse(status: $status, code: $code, data: $data, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BoothListResponseImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, code, data, message);

  /// Create a copy of BoothListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BoothListResponseImplCopyWith<_$BoothListResponseImpl> get copyWith =>
      __$$BoothListResponseImplCopyWithImpl<_$BoothListResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BoothListResponseImplToJson(
      this,
    );
  }
}

abstract class _BoothListResponse implements BoothListResponse {
  const factory _BoothListResponse(
      {final String? status,
      final String? code,
      final BoothListData? data,
      final String? message}) = _$BoothListResponseImpl;

  factory _BoothListResponse.fromJson(Map<String, dynamic> json) =
      _$BoothListResponseImpl.fromJson;

  @override
  String? get status;
  @override
  String? get code;
  @override
  BoothListData? get data;
  @override
  String? get message;

  /// Create a copy of BoothListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BoothListResponseImplCopyWith<_$BoothListResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
