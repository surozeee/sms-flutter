// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'content_create_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ContentCreateRequest _$ContentCreateRequestFromJson(Map<String, dynamic> json) {
  return _ContentCreateRequest.fromJson(json);
}

/// @nodoc
mixin _$ContentCreateRequest {
  String get contentType => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get textContent => throw _privateConstructorUsedError;
  String? get imageBase64 => throw _privateConstructorUsedError;
  String? get imageFilename => throw _privateConstructorUsedError;
  String? get aiPrompt => throw _privateConstructorUsedError;

  /// Serializes this ContentCreateRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ContentCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ContentCreateRequestCopyWith<ContentCreateRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContentCreateRequestCopyWith<$Res> {
  factory $ContentCreateRequestCopyWith(ContentCreateRequest value,
          $Res Function(ContentCreateRequest) then) =
      _$ContentCreateRequestCopyWithImpl<$Res, ContentCreateRequest>;
  @useResult
  $Res call(
      {String contentType,
      String title,
      String textContent,
      String? imageBase64,
      String? imageFilename,
      String? aiPrompt});
}

/// @nodoc
class _$ContentCreateRequestCopyWithImpl<$Res,
        $Val extends ContentCreateRequest>
    implements $ContentCreateRequestCopyWith<$Res> {
  _$ContentCreateRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ContentCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? contentType = null,
    Object? title = null,
    Object? textContent = null,
    Object? imageBase64 = freezed,
    Object? imageFilename = freezed,
    Object? aiPrompt = freezed,
  }) {
    return _then(_value.copyWith(
      contentType: null == contentType
          ? _value.contentType
          : contentType // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      textContent: null == textContent
          ? _value.textContent
          : textContent // ignore: cast_nullable_to_non_nullable
              as String,
      imageBase64: freezed == imageBase64
          ? _value.imageBase64
          : imageBase64 // ignore: cast_nullable_to_non_nullable
              as String?,
      imageFilename: freezed == imageFilename
          ? _value.imageFilename
          : imageFilename // ignore: cast_nullable_to_non_nullable
              as String?,
      aiPrompt: freezed == aiPrompt
          ? _value.aiPrompt
          : aiPrompt // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ContentCreateRequestImplCopyWith<$Res>
    implements $ContentCreateRequestCopyWith<$Res> {
  factory _$$ContentCreateRequestImplCopyWith(_$ContentCreateRequestImpl value,
          $Res Function(_$ContentCreateRequestImpl) then) =
      __$$ContentCreateRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String contentType,
      String title,
      String textContent,
      String? imageBase64,
      String? imageFilename,
      String? aiPrompt});
}

/// @nodoc
class __$$ContentCreateRequestImplCopyWithImpl<$Res>
    extends _$ContentCreateRequestCopyWithImpl<$Res, _$ContentCreateRequestImpl>
    implements _$$ContentCreateRequestImplCopyWith<$Res> {
  __$$ContentCreateRequestImplCopyWithImpl(_$ContentCreateRequestImpl _value,
      $Res Function(_$ContentCreateRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of ContentCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? contentType = null,
    Object? title = null,
    Object? textContent = null,
    Object? imageBase64 = freezed,
    Object? imageFilename = freezed,
    Object? aiPrompt = freezed,
  }) {
    return _then(_$ContentCreateRequestImpl(
      contentType: null == contentType
          ? _value.contentType
          : contentType // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      textContent: null == textContent
          ? _value.textContent
          : textContent // ignore: cast_nullable_to_non_nullable
              as String,
      imageBase64: freezed == imageBase64
          ? _value.imageBase64
          : imageBase64 // ignore: cast_nullable_to_non_nullable
              as String?,
      imageFilename: freezed == imageFilename
          ? _value.imageFilename
          : imageFilename // ignore: cast_nullable_to_non_nullable
              as String?,
      aiPrompt: freezed == aiPrompt
          ? _value.aiPrompt
          : aiPrompt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ContentCreateRequestImpl implements _ContentCreateRequest {
  const _$ContentCreateRequestImpl(
      {required this.contentType,
      required this.title,
      required this.textContent,
      this.imageBase64,
      this.imageFilename,
      this.aiPrompt});

  factory _$ContentCreateRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$ContentCreateRequestImplFromJson(json);

  @override
  final String contentType;
  @override
  final String title;
  @override
  final String textContent;
  @override
  final String? imageBase64;
  @override
  final String? imageFilename;
  @override
  final String? aiPrompt;

  @override
  String toString() {
    return 'ContentCreateRequest(contentType: $contentType, title: $title, textContent: $textContent, imageBase64: $imageBase64, imageFilename: $imageFilename, aiPrompt: $aiPrompt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContentCreateRequestImpl &&
            (identical(other.contentType, contentType) ||
                other.contentType == contentType) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.textContent, textContent) ||
                other.textContent == textContent) &&
            (identical(other.imageBase64, imageBase64) ||
                other.imageBase64 == imageBase64) &&
            (identical(other.imageFilename, imageFilename) ||
                other.imageFilename == imageFilename) &&
            (identical(other.aiPrompt, aiPrompt) ||
                other.aiPrompt == aiPrompt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, contentType, title, textContent,
      imageBase64, imageFilename, aiPrompt);

  /// Create a copy of ContentCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ContentCreateRequestImplCopyWith<_$ContentCreateRequestImpl>
      get copyWith =>
          __$$ContentCreateRequestImplCopyWithImpl<_$ContentCreateRequestImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ContentCreateRequestImplToJson(
      this,
    );
  }
}

abstract class _ContentCreateRequest implements ContentCreateRequest {
  const factory _ContentCreateRequest(
      {required final String contentType,
      required final String title,
      required final String textContent,
      final String? imageBase64,
      final String? imageFilename,
      final String? aiPrompt}) = _$ContentCreateRequestImpl;

  factory _ContentCreateRequest.fromJson(Map<String, dynamic> json) =
      _$ContentCreateRequestImpl.fromJson;

  @override
  String get contentType;
  @override
  String get title;
  @override
  String get textContent;
  @override
  String? get imageBase64;
  @override
  String? get imageFilename;
  @override
  String? get aiPrompt;

  /// Create a copy of ContentCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ContentCreateRequestImplCopyWith<_$ContentCreateRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}
