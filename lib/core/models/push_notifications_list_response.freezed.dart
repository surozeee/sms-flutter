// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'push_notifications_list_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PushNotification _$PushNotificationFromJson(Map<String, dynamic> json) {
  return _PushNotification.fromJson(json);
}

/// @nodoc
mixin _$PushNotification {
  String? get id => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  @JsonKey(name: 'imageUrl')
  String? get imageUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'notificationType')
  String? get notificationType => throw _privateConstructorUsedError;
  @JsonKey(name: 'partyId')
  String? get partyId => throw _privateConstructorUsedError;
  @JsonKey(name: 'partyName')
  String? get partyName => throw _privateConstructorUsedError;
  @JsonKey(name: 'boothId')
  String? get boothId => throw _privateConstructorUsedError;
  @JsonKey(name: 'boothName')
  String? get boothName => throw _privateConstructorUsedError;
  @JsonKey(name: 'recipientCount')
  int? get recipientCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'successCount')
  int? get successCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'failureCount')
  int? get failureCount => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'errorMessage')
  String? get errorMessage => throw _privateConstructorUsedError;
  @JsonKey(name: 'createdAt')
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'lastModifiedAt')
  String? get lastModifiedAt => throw _privateConstructorUsedError;

  /// Serializes this PushNotification to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PushNotification
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PushNotificationCopyWith<PushNotification> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PushNotificationCopyWith<$Res> {
  factory $PushNotificationCopyWith(
          PushNotification value, $Res Function(PushNotification) then) =
      _$PushNotificationCopyWithImpl<$Res, PushNotification>;
  @useResult
  $Res call(
      {String? id,
      String? title,
      String? message,
      @JsonKey(name: 'imageUrl') String? imageUrl,
      @JsonKey(name: 'notificationType') String? notificationType,
      @JsonKey(name: 'partyId') String? partyId,
      @JsonKey(name: 'partyName') String? partyName,
      @JsonKey(name: 'boothId') String? boothId,
      @JsonKey(name: 'boothName') String? boothName,
      @JsonKey(name: 'recipientCount') int? recipientCount,
      @JsonKey(name: 'successCount') int? successCount,
      @JsonKey(name: 'failureCount') int? failureCount,
      String? status,
      @JsonKey(name: 'errorMessage') String? errorMessage,
      @JsonKey(name: 'createdAt') String? createdAt,
      @JsonKey(name: 'lastModifiedAt') String? lastModifiedAt});
}

/// @nodoc
class _$PushNotificationCopyWithImpl<$Res, $Val extends PushNotification>
    implements $PushNotificationCopyWith<$Res> {
  _$PushNotificationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PushNotification
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? message = freezed,
    Object? imageUrl = freezed,
    Object? notificationType = freezed,
    Object? partyId = freezed,
    Object? partyName = freezed,
    Object? boothId = freezed,
    Object? boothName = freezed,
    Object? recipientCount = freezed,
    Object? successCount = freezed,
    Object? failureCount = freezed,
    Object? status = freezed,
    Object? errorMessage = freezed,
    Object? createdAt = freezed,
    Object? lastModifiedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      notificationType: freezed == notificationType
          ? _value.notificationType
          : notificationType // ignore: cast_nullable_to_non_nullable
              as String?,
      partyId: freezed == partyId
          ? _value.partyId
          : partyId // ignore: cast_nullable_to_non_nullable
              as String?,
      partyName: freezed == partyName
          ? _value.partyName
          : partyName // ignore: cast_nullable_to_non_nullable
              as String?,
      boothId: freezed == boothId
          ? _value.boothId
          : boothId // ignore: cast_nullable_to_non_nullable
              as String?,
      boothName: freezed == boothName
          ? _value.boothName
          : boothName // ignore: cast_nullable_to_non_nullable
              as String?,
      recipientCount: freezed == recipientCount
          ? _value.recipientCount
          : recipientCount // ignore: cast_nullable_to_non_nullable
              as int?,
      successCount: freezed == successCount
          ? _value.successCount
          : successCount // ignore: cast_nullable_to_non_nullable
              as int?,
      failureCount: freezed == failureCount
          ? _value.failureCount
          : failureCount // ignore: cast_nullable_to_non_nullable
              as int?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      lastModifiedAt: freezed == lastModifiedAt
          ? _value.lastModifiedAt
          : lastModifiedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PushNotificationImplCopyWith<$Res>
    implements $PushNotificationCopyWith<$Res> {
  factory _$$PushNotificationImplCopyWith(_$PushNotificationImpl value,
          $Res Function(_$PushNotificationImpl) then) =
      __$$PushNotificationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? title,
      String? message,
      @JsonKey(name: 'imageUrl') String? imageUrl,
      @JsonKey(name: 'notificationType') String? notificationType,
      @JsonKey(name: 'partyId') String? partyId,
      @JsonKey(name: 'partyName') String? partyName,
      @JsonKey(name: 'boothId') String? boothId,
      @JsonKey(name: 'boothName') String? boothName,
      @JsonKey(name: 'recipientCount') int? recipientCount,
      @JsonKey(name: 'successCount') int? successCount,
      @JsonKey(name: 'failureCount') int? failureCount,
      String? status,
      @JsonKey(name: 'errorMessage') String? errorMessage,
      @JsonKey(name: 'createdAt') String? createdAt,
      @JsonKey(name: 'lastModifiedAt') String? lastModifiedAt});
}

/// @nodoc
class __$$PushNotificationImplCopyWithImpl<$Res>
    extends _$PushNotificationCopyWithImpl<$Res, _$PushNotificationImpl>
    implements _$$PushNotificationImplCopyWith<$Res> {
  __$$PushNotificationImplCopyWithImpl(_$PushNotificationImpl _value,
      $Res Function(_$PushNotificationImpl) _then)
      : super(_value, _then);

  /// Create a copy of PushNotification
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? message = freezed,
    Object? imageUrl = freezed,
    Object? notificationType = freezed,
    Object? partyId = freezed,
    Object? partyName = freezed,
    Object? boothId = freezed,
    Object? boothName = freezed,
    Object? recipientCount = freezed,
    Object? successCount = freezed,
    Object? failureCount = freezed,
    Object? status = freezed,
    Object? errorMessage = freezed,
    Object? createdAt = freezed,
    Object? lastModifiedAt = freezed,
  }) {
    return _then(_$PushNotificationImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      notificationType: freezed == notificationType
          ? _value.notificationType
          : notificationType // ignore: cast_nullable_to_non_nullable
              as String?,
      partyId: freezed == partyId
          ? _value.partyId
          : partyId // ignore: cast_nullable_to_non_nullable
              as String?,
      partyName: freezed == partyName
          ? _value.partyName
          : partyName // ignore: cast_nullable_to_non_nullable
              as String?,
      boothId: freezed == boothId
          ? _value.boothId
          : boothId // ignore: cast_nullable_to_non_nullable
              as String?,
      boothName: freezed == boothName
          ? _value.boothName
          : boothName // ignore: cast_nullable_to_non_nullable
              as String?,
      recipientCount: freezed == recipientCount
          ? _value.recipientCount
          : recipientCount // ignore: cast_nullable_to_non_nullable
              as int?,
      successCount: freezed == successCount
          ? _value.successCount
          : successCount // ignore: cast_nullable_to_non_nullable
              as int?,
      failureCount: freezed == failureCount
          ? _value.failureCount
          : failureCount // ignore: cast_nullable_to_non_nullable
              as int?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      lastModifiedAt: freezed == lastModifiedAt
          ? _value.lastModifiedAt
          : lastModifiedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PushNotificationImpl implements _PushNotification {
  const _$PushNotificationImpl(
      {this.id,
      this.title,
      this.message,
      @JsonKey(name: 'imageUrl') this.imageUrl,
      @JsonKey(name: 'notificationType') this.notificationType,
      @JsonKey(name: 'partyId') this.partyId,
      @JsonKey(name: 'partyName') this.partyName,
      @JsonKey(name: 'boothId') this.boothId,
      @JsonKey(name: 'boothName') this.boothName,
      @JsonKey(name: 'recipientCount') this.recipientCount,
      @JsonKey(name: 'successCount') this.successCount,
      @JsonKey(name: 'failureCount') this.failureCount,
      this.status,
      @JsonKey(name: 'errorMessage') this.errorMessage,
      @JsonKey(name: 'createdAt') this.createdAt,
      @JsonKey(name: 'lastModifiedAt') this.lastModifiedAt});

  factory _$PushNotificationImpl.fromJson(Map<String, dynamic> json) =>
      _$$PushNotificationImplFromJson(json);

  @override
  final String? id;
  @override
  final String? title;
  @override
  final String? message;
  @override
  @JsonKey(name: 'imageUrl')
  final String? imageUrl;
  @override
  @JsonKey(name: 'notificationType')
  final String? notificationType;
  @override
  @JsonKey(name: 'partyId')
  final String? partyId;
  @override
  @JsonKey(name: 'partyName')
  final String? partyName;
  @override
  @JsonKey(name: 'boothId')
  final String? boothId;
  @override
  @JsonKey(name: 'boothName')
  final String? boothName;
  @override
  @JsonKey(name: 'recipientCount')
  final int? recipientCount;
  @override
  @JsonKey(name: 'successCount')
  final int? successCount;
  @override
  @JsonKey(name: 'failureCount')
  final int? failureCount;
  @override
  final String? status;
  @override
  @JsonKey(name: 'errorMessage')
  final String? errorMessage;
  @override
  @JsonKey(name: 'createdAt')
  final String? createdAt;
  @override
  @JsonKey(name: 'lastModifiedAt')
  final String? lastModifiedAt;

  @override
  String toString() {
    return 'PushNotification(id: $id, title: $title, message: $message, imageUrl: $imageUrl, notificationType: $notificationType, partyId: $partyId, partyName: $partyName, boothId: $boothId, boothName: $boothName, recipientCount: $recipientCount, successCount: $successCount, failureCount: $failureCount, status: $status, errorMessage: $errorMessage, createdAt: $createdAt, lastModifiedAt: $lastModifiedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PushNotificationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.notificationType, notificationType) ||
                other.notificationType == notificationType) &&
            (identical(other.partyId, partyId) || other.partyId == partyId) &&
            (identical(other.partyName, partyName) ||
                other.partyName == partyName) &&
            (identical(other.boothId, boothId) || other.boothId == boothId) &&
            (identical(other.boothName, boothName) ||
                other.boothName == boothName) &&
            (identical(other.recipientCount, recipientCount) ||
                other.recipientCount == recipientCount) &&
            (identical(other.successCount, successCount) ||
                other.successCount == successCount) &&
            (identical(other.failureCount, failureCount) ||
                other.failureCount == failureCount) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.lastModifiedAt, lastModifiedAt) ||
                other.lastModifiedAt == lastModifiedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      message,
      imageUrl,
      notificationType,
      partyId,
      partyName,
      boothId,
      boothName,
      recipientCount,
      successCount,
      failureCount,
      status,
      errorMessage,
      createdAt,
      lastModifiedAt);

  /// Create a copy of PushNotification
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PushNotificationImplCopyWith<_$PushNotificationImpl> get copyWith =>
      __$$PushNotificationImplCopyWithImpl<_$PushNotificationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PushNotificationImplToJson(
      this,
    );
  }
}

abstract class _PushNotification implements PushNotification {
  const factory _PushNotification(
          {final String? id,
          final String? title,
          final String? message,
          @JsonKey(name: 'imageUrl') final String? imageUrl,
          @JsonKey(name: 'notificationType') final String? notificationType,
          @JsonKey(name: 'partyId') final String? partyId,
          @JsonKey(name: 'partyName') final String? partyName,
          @JsonKey(name: 'boothId') final String? boothId,
          @JsonKey(name: 'boothName') final String? boothName,
          @JsonKey(name: 'recipientCount') final int? recipientCount,
          @JsonKey(name: 'successCount') final int? successCount,
          @JsonKey(name: 'failureCount') final int? failureCount,
          final String? status,
          @JsonKey(name: 'errorMessage') final String? errorMessage,
          @JsonKey(name: 'createdAt') final String? createdAt,
          @JsonKey(name: 'lastModifiedAt') final String? lastModifiedAt}) =
      _$PushNotificationImpl;

  factory _PushNotification.fromJson(Map<String, dynamic> json) =
      _$PushNotificationImpl.fromJson;

  @override
  String? get id;
  @override
  String? get title;
  @override
  String? get message;
  @override
  @JsonKey(name: 'imageUrl')
  String? get imageUrl;
  @override
  @JsonKey(name: 'notificationType')
  String? get notificationType;
  @override
  @JsonKey(name: 'partyId')
  String? get partyId;
  @override
  @JsonKey(name: 'partyName')
  String? get partyName;
  @override
  @JsonKey(name: 'boothId')
  String? get boothId;
  @override
  @JsonKey(name: 'boothName')
  String? get boothName;
  @override
  @JsonKey(name: 'recipientCount')
  int? get recipientCount;
  @override
  @JsonKey(name: 'successCount')
  int? get successCount;
  @override
  @JsonKey(name: 'failureCount')
  int? get failureCount;
  @override
  String? get status;
  @override
  @JsonKey(name: 'errorMessage')
  String? get errorMessage;
  @override
  @JsonKey(name: 'createdAt')
  String? get createdAt;
  @override
  @JsonKey(name: 'lastModifiedAt')
  String? get lastModifiedAt;

  /// Create a copy of PushNotification
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PushNotificationImplCopyWith<_$PushNotificationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PushNotificationsListData _$PushNotificationsListDataFromJson(
    Map<String, dynamic> json) {
  return _PushNotificationsListData.fromJson(json);
}

/// @nodoc
mixin _$PushNotificationsListData {
  List<PushNotification>? get content => throw _privateConstructorUsedError;
  @JsonKey(name: 'totalElements')
  int? get totalElements => throw _privateConstructorUsedError;

  /// Serializes this PushNotificationsListData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PushNotificationsListData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PushNotificationsListDataCopyWith<PushNotificationsListData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PushNotificationsListDataCopyWith<$Res> {
  factory $PushNotificationsListDataCopyWith(PushNotificationsListData value,
          $Res Function(PushNotificationsListData) then) =
      _$PushNotificationsListDataCopyWithImpl<$Res, PushNotificationsListData>;
  @useResult
  $Res call(
      {List<PushNotification>? content,
      @JsonKey(name: 'totalElements') int? totalElements});
}

/// @nodoc
class _$PushNotificationsListDataCopyWithImpl<$Res,
        $Val extends PushNotificationsListData>
    implements $PushNotificationsListDataCopyWith<$Res> {
  _$PushNotificationsListDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PushNotificationsListData
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
              as List<PushNotification>?,
      totalElements: freezed == totalElements
          ? _value.totalElements
          : totalElements // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PushNotificationsListDataImplCopyWith<$Res>
    implements $PushNotificationsListDataCopyWith<$Res> {
  factory _$$PushNotificationsListDataImplCopyWith(
          _$PushNotificationsListDataImpl value,
          $Res Function(_$PushNotificationsListDataImpl) then) =
      __$$PushNotificationsListDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<PushNotification>? content,
      @JsonKey(name: 'totalElements') int? totalElements});
}

/// @nodoc
class __$$PushNotificationsListDataImplCopyWithImpl<$Res>
    extends _$PushNotificationsListDataCopyWithImpl<$Res,
        _$PushNotificationsListDataImpl>
    implements _$$PushNotificationsListDataImplCopyWith<$Res> {
  __$$PushNotificationsListDataImplCopyWithImpl(
      _$PushNotificationsListDataImpl _value,
      $Res Function(_$PushNotificationsListDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of PushNotificationsListData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? content = freezed,
    Object? totalElements = freezed,
  }) {
    return _then(_$PushNotificationsListDataImpl(
      content: freezed == content
          ? _value._content
          : content // ignore: cast_nullable_to_non_nullable
              as List<PushNotification>?,
      totalElements: freezed == totalElements
          ? _value.totalElements
          : totalElements // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PushNotificationsListDataImpl implements _PushNotificationsListData {
  const _$PushNotificationsListDataImpl(
      {final List<PushNotification>? content,
      @JsonKey(name: 'totalElements') this.totalElements})
      : _content = content;

  factory _$PushNotificationsListDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$PushNotificationsListDataImplFromJson(json);

  final List<PushNotification>? _content;
  @override
  List<PushNotification>? get content {
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
    return 'PushNotificationsListData(content: $content, totalElements: $totalElements)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PushNotificationsListDataImpl &&
            const DeepCollectionEquality().equals(other._content, _content) &&
            (identical(other.totalElements, totalElements) ||
                other.totalElements == totalElements));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_content), totalElements);

  /// Create a copy of PushNotificationsListData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PushNotificationsListDataImplCopyWith<_$PushNotificationsListDataImpl>
      get copyWith => __$$PushNotificationsListDataImplCopyWithImpl<
          _$PushNotificationsListDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PushNotificationsListDataImplToJson(
      this,
    );
  }
}

abstract class _PushNotificationsListData implements PushNotificationsListData {
  const factory _PushNotificationsListData(
          {final List<PushNotification>? content,
          @JsonKey(name: 'totalElements') final int? totalElements}) =
      _$PushNotificationsListDataImpl;

  factory _PushNotificationsListData.fromJson(Map<String, dynamic> json) =
      _$PushNotificationsListDataImpl.fromJson;

  @override
  List<PushNotification>? get content;
  @override
  @JsonKey(name: 'totalElements')
  int? get totalElements;

  /// Create a copy of PushNotificationsListData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PushNotificationsListDataImplCopyWith<_$PushNotificationsListDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}

PushNotificationsListResponse _$PushNotificationsListResponseFromJson(
    Map<String, dynamic> json) {
  return _PushNotificationsListResponse.fromJson(json);
}

/// @nodoc
mixin _$PushNotificationsListResponse {
  String? get status => throw _privateConstructorUsedError;
  String? get code => throw _privateConstructorUsedError;
  PushNotificationsListData? get data => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  /// Serializes this PushNotificationsListResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PushNotificationsListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PushNotificationsListResponseCopyWith<PushNotificationsListResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PushNotificationsListResponseCopyWith<$Res> {
  factory $PushNotificationsListResponseCopyWith(
          PushNotificationsListResponse value,
          $Res Function(PushNotificationsListResponse) then) =
      _$PushNotificationsListResponseCopyWithImpl<$Res,
          PushNotificationsListResponse>;
  @useResult
  $Res call(
      {String? status,
      String? code,
      PushNotificationsListData? data,
      String? message});

  $PushNotificationsListDataCopyWith<$Res>? get data;
}

/// @nodoc
class _$PushNotificationsListResponseCopyWithImpl<$Res,
        $Val extends PushNotificationsListResponse>
    implements $PushNotificationsListResponseCopyWith<$Res> {
  _$PushNotificationsListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PushNotificationsListResponse
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
              as PushNotificationsListData?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of PushNotificationsListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PushNotificationsListDataCopyWith<$Res>? get data {
    if (_value.data == null) {
      return null;
    }

    return $PushNotificationsListDataCopyWith<$Res>(_value.data!, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PushNotificationsListResponseImplCopyWith<$Res>
    implements $PushNotificationsListResponseCopyWith<$Res> {
  factory _$$PushNotificationsListResponseImplCopyWith(
          _$PushNotificationsListResponseImpl value,
          $Res Function(_$PushNotificationsListResponseImpl) then) =
      __$$PushNotificationsListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? status,
      String? code,
      PushNotificationsListData? data,
      String? message});

  @override
  $PushNotificationsListDataCopyWith<$Res>? get data;
}

/// @nodoc
class __$$PushNotificationsListResponseImplCopyWithImpl<$Res>
    extends _$PushNotificationsListResponseCopyWithImpl<$Res,
        _$PushNotificationsListResponseImpl>
    implements _$$PushNotificationsListResponseImplCopyWith<$Res> {
  __$$PushNotificationsListResponseImplCopyWithImpl(
      _$PushNotificationsListResponseImpl _value,
      $Res Function(_$PushNotificationsListResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of PushNotificationsListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
    Object? code = freezed,
    Object? data = freezed,
    Object? message = freezed,
  }) {
    return _then(_$PushNotificationsListResponseImpl(
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
              as PushNotificationsListData?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PushNotificationsListResponseImpl
    implements _PushNotificationsListResponse {
  const _$PushNotificationsListResponseImpl(
      {this.status, this.code, this.data, this.message});

  factory _$PushNotificationsListResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$PushNotificationsListResponseImplFromJson(json);

  @override
  final String? status;
  @override
  final String? code;
  @override
  final PushNotificationsListData? data;
  @override
  final String? message;

  @override
  String toString() {
    return 'PushNotificationsListResponse(status: $status, code: $code, data: $data, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PushNotificationsListResponseImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, code, data, message);

  /// Create a copy of PushNotificationsListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PushNotificationsListResponseImplCopyWith<
          _$PushNotificationsListResponseImpl>
      get copyWith => __$$PushNotificationsListResponseImplCopyWithImpl<
          _$PushNotificationsListResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PushNotificationsListResponseImplToJson(
      this,
    );
  }
}

abstract class _PushNotificationsListResponse
    implements PushNotificationsListResponse {
  const factory _PushNotificationsListResponse(
      {final String? status,
      final String? code,
      final PushNotificationsListData? data,
      final String? message}) = _$PushNotificationsListResponseImpl;

  factory _PushNotificationsListResponse.fromJson(Map<String, dynamic> json) =
      _$PushNotificationsListResponseImpl.fromJson;

  @override
  String? get status;
  @override
  String? get code;
  @override
  PushNotificationsListData? get data;
  @override
  String? get message;

  /// Create a copy of PushNotificationsListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PushNotificationsListResponseImplCopyWith<
          _$PushNotificationsListResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
