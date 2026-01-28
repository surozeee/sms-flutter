// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'contents_list_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ContentItem _$ContentItemFromJson(Map<String, dynamic> json) {
  return _ContentItem.fromJson(json);
}

/// @nodoc
mixin _$ContentItem {
  @JsonKey(name: 'aiPrompt')
  String? get aiPrompt => throw _privateConstructorUsedError;
  @JsonKey(name: 'contentType')
  String? get contentType => throw _privateConstructorUsedError;
  @JsonKey(name: 'createdAt')
  String? get createdAt => throw _privateConstructorUsedError;
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'imageUrl')
  String? get imageUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'isPublished')
  bool? get isPublished => throw _privateConstructorUsedError;
  @JsonKey(name: 'lastModifiedAt')
  String? get lastModifiedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'partyId')
  String? get partyId => throw _privateConstructorUsedError;
  @JsonKey(name: 'partyName')
  String? get partyName => throw _privateConstructorUsedError;
  @JsonKey(name: 'textContent')
  String? get textContent => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;

  /// Serializes this ContentItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ContentItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ContentItemCopyWith<ContentItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContentItemCopyWith<$Res> {
  factory $ContentItemCopyWith(
          ContentItem value, $Res Function(ContentItem) then) =
      _$ContentItemCopyWithImpl<$Res, ContentItem>;
  @useResult
  $Res call(
      {@JsonKey(name: 'aiPrompt') String? aiPrompt,
      @JsonKey(name: 'contentType') String? contentType,
      @JsonKey(name: 'createdAt') String? createdAt,
      String? id,
      @JsonKey(name: 'imageUrl') String? imageUrl,
      @JsonKey(name: 'isPublished') bool? isPublished,
      @JsonKey(name: 'lastModifiedAt') String? lastModifiedAt,
      @JsonKey(name: 'partyId') String? partyId,
      @JsonKey(name: 'partyName') String? partyName,
      @JsonKey(name: 'textContent') String? textContent,
      String? title});
}

/// @nodoc
class _$ContentItemCopyWithImpl<$Res, $Val extends ContentItem>
    implements $ContentItemCopyWith<$Res> {
  _$ContentItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ContentItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? aiPrompt = freezed,
    Object? contentType = freezed,
    Object? createdAt = freezed,
    Object? id = freezed,
    Object? imageUrl = freezed,
    Object? isPublished = freezed,
    Object? lastModifiedAt = freezed,
    Object? partyId = freezed,
    Object? partyName = freezed,
    Object? textContent = freezed,
    Object? title = freezed,
  }) {
    return _then(_value.copyWith(
      aiPrompt: freezed == aiPrompt
          ? _value.aiPrompt
          : aiPrompt // ignore: cast_nullable_to_non_nullable
              as String?,
      contentType: freezed == contentType
          ? _value.contentType
          : contentType // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      isPublished: freezed == isPublished
          ? _value.isPublished
          : isPublished // ignore: cast_nullable_to_non_nullable
              as bool?,
      lastModifiedAt: freezed == lastModifiedAt
          ? _value.lastModifiedAt
          : lastModifiedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      partyId: freezed == partyId
          ? _value.partyId
          : partyId // ignore: cast_nullable_to_non_nullable
              as String?,
      partyName: freezed == partyName
          ? _value.partyName
          : partyName // ignore: cast_nullable_to_non_nullable
              as String?,
      textContent: freezed == textContent
          ? _value.textContent
          : textContent // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ContentItemImplCopyWith<$Res>
    implements $ContentItemCopyWith<$Res> {
  factory _$$ContentItemImplCopyWith(
          _$ContentItemImpl value, $Res Function(_$ContentItemImpl) then) =
      __$$ContentItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'aiPrompt') String? aiPrompt,
      @JsonKey(name: 'contentType') String? contentType,
      @JsonKey(name: 'createdAt') String? createdAt,
      String? id,
      @JsonKey(name: 'imageUrl') String? imageUrl,
      @JsonKey(name: 'isPublished') bool? isPublished,
      @JsonKey(name: 'lastModifiedAt') String? lastModifiedAt,
      @JsonKey(name: 'partyId') String? partyId,
      @JsonKey(name: 'partyName') String? partyName,
      @JsonKey(name: 'textContent') String? textContent,
      String? title});
}

/// @nodoc
class __$$ContentItemImplCopyWithImpl<$Res>
    extends _$ContentItemCopyWithImpl<$Res, _$ContentItemImpl>
    implements _$$ContentItemImplCopyWith<$Res> {
  __$$ContentItemImplCopyWithImpl(
      _$ContentItemImpl _value, $Res Function(_$ContentItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of ContentItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? aiPrompt = freezed,
    Object? contentType = freezed,
    Object? createdAt = freezed,
    Object? id = freezed,
    Object? imageUrl = freezed,
    Object? isPublished = freezed,
    Object? lastModifiedAt = freezed,
    Object? partyId = freezed,
    Object? partyName = freezed,
    Object? textContent = freezed,
    Object? title = freezed,
  }) {
    return _then(_$ContentItemImpl(
      aiPrompt: freezed == aiPrompt
          ? _value.aiPrompt
          : aiPrompt // ignore: cast_nullable_to_non_nullable
              as String?,
      contentType: freezed == contentType
          ? _value.contentType
          : contentType // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      isPublished: freezed == isPublished
          ? _value.isPublished
          : isPublished // ignore: cast_nullable_to_non_nullable
              as bool?,
      lastModifiedAt: freezed == lastModifiedAt
          ? _value.lastModifiedAt
          : lastModifiedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      partyId: freezed == partyId
          ? _value.partyId
          : partyId // ignore: cast_nullable_to_non_nullable
              as String?,
      partyName: freezed == partyName
          ? _value.partyName
          : partyName // ignore: cast_nullable_to_non_nullable
              as String?,
      textContent: freezed == textContent
          ? _value.textContent
          : textContent // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ContentItemImpl implements _ContentItem {
  const _$ContentItemImpl(
      {@JsonKey(name: 'aiPrompt') this.aiPrompt,
      @JsonKey(name: 'contentType') this.contentType,
      @JsonKey(name: 'createdAt') this.createdAt,
      this.id,
      @JsonKey(name: 'imageUrl') this.imageUrl,
      @JsonKey(name: 'isPublished') this.isPublished,
      @JsonKey(name: 'lastModifiedAt') this.lastModifiedAt,
      @JsonKey(name: 'partyId') this.partyId,
      @JsonKey(name: 'partyName') this.partyName,
      @JsonKey(name: 'textContent') this.textContent,
      this.title});

  factory _$ContentItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$ContentItemImplFromJson(json);

  @override
  @JsonKey(name: 'aiPrompt')
  final String? aiPrompt;
  @override
  @JsonKey(name: 'contentType')
  final String? contentType;
  @override
  @JsonKey(name: 'createdAt')
  final String? createdAt;
  @override
  final String? id;
  @override
  @JsonKey(name: 'imageUrl')
  final String? imageUrl;
  @override
  @JsonKey(name: 'isPublished')
  final bool? isPublished;
  @override
  @JsonKey(name: 'lastModifiedAt')
  final String? lastModifiedAt;
  @override
  @JsonKey(name: 'partyId')
  final String? partyId;
  @override
  @JsonKey(name: 'partyName')
  final String? partyName;
  @override
  @JsonKey(name: 'textContent')
  final String? textContent;
  @override
  final String? title;

  @override
  String toString() {
    return 'ContentItem(aiPrompt: $aiPrompt, contentType: $contentType, createdAt: $createdAt, id: $id, imageUrl: $imageUrl, isPublished: $isPublished, lastModifiedAt: $lastModifiedAt, partyId: $partyId, partyName: $partyName, textContent: $textContent, title: $title)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContentItemImpl &&
            (identical(other.aiPrompt, aiPrompt) ||
                other.aiPrompt == aiPrompt) &&
            (identical(other.contentType, contentType) ||
                other.contentType == contentType) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.isPublished, isPublished) ||
                other.isPublished == isPublished) &&
            (identical(other.lastModifiedAt, lastModifiedAt) ||
                other.lastModifiedAt == lastModifiedAt) &&
            (identical(other.partyId, partyId) || other.partyId == partyId) &&
            (identical(other.partyName, partyName) ||
                other.partyName == partyName) &&
            (identical(other.textContent, textContent) ||
                other.textContent == textContent) &&
            (identical(other.title, title) || other.title == title));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      aiPrompt,
      contentType,
      createdAt,
      id,
      imageUrl,
      isPublished,
      lastModifiedAt,
      partyId,
      partyName,
      textContent,
      title);

  /// Create a copy of ContentItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ContentItemImplCopyWith<_$ContentItemImpl> get copyWith =>
      __$$ContentItemImplCopyWithImpl<_$ContentItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ContentItemImplToJson(
      this,
    );
  }
}

abstract class _ContentItem implements ContentItem {
  const factory _ContentItem(
      {@JsonKey(name: 'aiPrompt') final String? aiPrompt,
      @JsonKey(name: 'contentType') final String? contentType,
      @JsonKey(name: 'createdAt') final String? createdAt,
      final String? id,
      @JsonKey(name: 'imageUrl') final String? imageUrl,
      @JsonKey(name: 'isPublished') final bool? isPublished,
      @JsonKey(name: 'lastModifiedAt') final String? lastModifiedAt,
      @JsonKey(name: 'partyId') final String? partyId,
      @JsonKey(name: 'partyName') final String? partyName,
      @JsonKey(name: 'textContent') final String? textContent,
      final String? title}) = _$ContentItemImpl;

  factory _ContentItem.fromJson(Map<String, dynamic> json) =
      _$ContentItemImpl.fromJson;

  @override
  @JsonKey(name: 'aiPrompt')
  String? get aiPrompt;
  @override
  @JsonKey(name: 'contentType')
  String? get contentType;
  @override
  @JsonKey(name: 'createdAt')
  String? get createdAt;
  @override
  String? get id;
  @override
  @JsonKey(name: 'imageUrl')
  String? get imageUrl;
  @override
  @JsonKey(name: 'isPublished')
  bool? get isPublished;
  @override
  @JsonKey(name: 'lastModifiedAt')
  String? get lastModifiedAt;
  @override
  @JsonKey(name: 'partyId')
  String? get partyId;
  @override
  @JsonKey(name: 'partyName')
  String? get partyName;
  @override
  @JsonKey(name: 'textContent')
  String? get textContent;
  @override
  String? get title;

  /// Create a copy of ContentItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ContentItemImplCopyWith<_$ContentItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ContentsListData _$ContentsListDataFromJson(Map<String, dynamic> json) {
  return _ContentsListData.fromJson(json);
}

/// @nodoc
mixin _$ContentsListData {
  List<ContentItem>? get content => throw _privateConstructorUsedError;
  @JsonKey(name: 'totalElements')
  int? get totalElements => throw _privateConstructorUsedError;

  /// Serializes this ContentsListData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ContentsListData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ContentsListDataCopyWith<ContentsListData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContentsListDataCopyWith<$Res> {
  factory $ContentsListDataCopyWith(
          ContentsListData value, $Res Function(ContentsListData) then) =
      _$ContentsListDataCopyWithImpl<$Res, ContentsListData>;
  @useResult
  $Res call(
      {List<ContentItem>? content,
      @JsonKey(name: 'totalElements') int? totalElements});
}

/// @nodoc
class _$ContentsListDataCopyWithImpl<$Res, $Val extends ContentsListData>
    implements $ContentsListDataCopyWith<$Res> {
  _$ContentsListDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ContentsListData
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
              as List<ContentItem>?,
      totalElements: freezed == totalElements
          ? _value.totalElements
          : totalElements // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ContentsListDataImplCopyWith<$Res>
    implements $ContentsListDataCopyWith<$Res> {
  factory _$$ContentsListDataImplCopyWith(_$ContentsListDataImpl value,
          $Res Function(_$ContentsListDataImpl) then) =
      __$$ContentsListDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<ContentItem>? content,
      @JsonKey(name: 'totalElements') int? totalElements});
}

/// @nodoc
class __$$ContentsListDataImplCopyWithImpl<$Res>
    extends _$ContentsListDataCopyWithImpl<$Res, _$ContentsListDataImpl>
    implements _$$ContentsListDataImplCopyWith<$Res> {
  __$$ContentsListDataImplCopyWithImpl(_$ContentsListDataImpl _value,
      $Res Function(_$ContentsListDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of ContentsListData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? content = freezed,
    Object? totalElements = freezed,
  }) {
    return _then(_$ContentsListDataImpl(
      content: freezed == content
          ? _value._content
          : content // ignore: cast_nullable_to_non_nullable
              as List<ContentItem>?,
      totalElements: freezed == totalElements
          ? _value.totalElements
          : totalElements // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ContentsListDataImpl implements _ContentsListData {
  const _$ContentsListDataImpl(
      {final List<ContentItem>? content,
      @JsonKey(name: 'totalElements') this.totalElements})
      : _content = content;

  factory _$ContentsListDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$ContentsListDataImplFromJson(json);

  final List<ContentItem>? _content;
  @override
  List<ContentItem>? get content {
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
    return 'ContentsListData(content: $content, totalElements: $totalElements)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContentsListDataImpl &&
            const DeepCollectionEquality().equals(other._content, _content) &&
            (identical(other.totalElements, totalElements) ||
                other.totalElements == totalElements));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_content), totalElements);

  /// Create a copy of ContentsListData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ContentsListDataImplCopyWith<_$ContentsListDataImpl> get copyWith =>
      __$$ContentsListDataImplCopyWithImpl<_$ContentsListDataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ContentsListDataImplToJson(
      this,
    );
  }
}

abstract class _ContentsListData implements ContentsListData {
  const factory _ContentsListData(
          {final List<ContentItem>? content,
          @JsonKey(name: 'totalElements') final int? totalElements}) =
      _$ContentsListDataImpl;

  factory _ContentsListData.fromJson(Map<String, dynamic> json) =
      _$ContentsListDataImpl.fromJson;

  @override
  List<ContentItem>? get content;
  @override
  @JsonKey(name: 'totalElements')
  int? get totalElements;

  /// Create a copy of ContentsListData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ContentsListDataImplCopyWith<_$ContentsListDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ContentsListResponse _$ContentsListResponseFromJson(Map<String, dynamic> json) {
  return _ContentsListResponse.fromJson(json);
}

/// @nodoc
mixin _$ContentsListResponse {
  String? get status => throw _privateConstructorUsedError;
  String? get code => throw _privateConstructorUsedError;
  ContentsListData? get data => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  /// Serializes this ContentsListResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ContentsListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ContentsListResponseCopyWith<ContentsListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContentsListResponseCopyWith<$Res> {
  factory $ContentsListResponseCopyWith(ContentsListResponse value,
          $Res Function(ContentsListResponse) then) =
      _$ContentsListResponseCopyWithImpl<$Res, ContentsListResponse>;
  @useResult
  $Res call(
      {String? status, String? code, ContentsListData? data, String? message});

  $ContentsListDataCopyWith<$Res>? get data;
}

/// @nodoc
class _$ContentsListResponseCopyWithImpl<$Res,
        $Val extends ContentsListResponse>
    implements $ContentsListResponseCopyWith<$Res> {
  _$ContentsListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ContentsListResponse
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
              as ContentsListData?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of ContentsListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ContentsListDataCopyWith<$Res>? get data {
    if (_value.data == null) {
      return null;
    }

    return $ContentsListDataCopyWith<$Res>(_value.data!, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ContentsListResponseImplCopyWith<$Res>
    implements $ContentsListResponseCopyWith<$Res> {
  factory _$$ContentsListResponseImplCopyWith(_$ContentsListResponseImpl value,
          $Res Function(_$ContentsListResponseImpl) then) =
      __$$ContentsListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? status, String? code, ContentsListData? data, String? message});

  @override
  $ContentsListDataCopyWith<$Res>? get data;
}

/// @nodoc
class __$$ContentsListResponseImplCopyWithImpl<$Res>
    extends _$ContentsListResponseCopyWithImpl<$Res, _$ContentsListResponseImpl>
    implements _$$ContentsListResponseImplCopyWith<$Res> {
  __$$ContentsListResponseImplCopyWithImpl(_$ContentsListResponseImpl _value,
      $Res Function(_$ContentsListResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of ContentsListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
    Object? code = freezed,
    Object? data = freezed,
    Object? message = freezed,
  }) {
    return _then(_$ContentsListResponseImpl(
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
              as ContentsListData?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ContentsListResponseImpl implements _ContentsListResponse {
  const _$ContentsListResponseImpl(
      {this.status, this.code, this.data, this.message});

  factory _$ContentsListResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ContentsListResponseImplFromJson(json);

  @override
  final String? status;
  @override
  final String? code;
  @override
  final ContentsListData? data;
  @override
  final String? message;

  @override
  String toString() {
    return 'ContentsListResponse(status: $status, code: $code, data: $data, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContentsListResponseImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, code, data, message);

  /// Create a copy of ContentsListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ContentsListResponseImplCopyWith<_$ContentsListResponseImpl>
      get copyWith =>
          __$$ContentsListResponseImplCopyWithImpl<_$ContentsListResponseImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ContentsListResponseImplToJson(
      this,
    );
  }
}

abstract class _ContentsListResponse implements ContentsListResponse {
  const factory _ContentsListResponse(
      {final String? status,
      final String? code,
      final ContentsListData? data,
      final String? message}) = _$ContentsListResponseImpl;

  factory _ContentsListResponse.fromJson(Map<String, dynamic> json) =
      _$ContentsListResponseImpl.fromJson;

  @override
  String? get status;
  @override
  String? get code;
  @override
  ContentsListData? get data;
  @override
  String? get message;

  /// Create a copy of ContentsListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ContentsListResponseImplCopyWith<_$ContentsListResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
