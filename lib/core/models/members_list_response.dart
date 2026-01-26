import 'package:freezed_annotation/freezed_annotation.dart';

part 'members_list_response.freezed.dart';
part 'members_list_response.g.dart';

@freezed
class Member with _$Member {
  const factory Member({
    String? address,
    double? balance,
    String? bio,
    @JsonKey(name: 'boothId') String? boothId,
    @JsonKey(name: 'boothName') String? boothName,
    @JsonKey(name: 'createdAt') String? createdAt,
    @JsonKey(name: 'designationId') String? designationId,
    @JsonKey(name: 'designationName') String? designationName,
    String? email,
    @JsonKey(name: 'fullName') String? fullName,
    String? id,
    @JsonKey(name: 'lastModifiedAt') String? lastModifiedAt,
    @JsonKey(name: 'partyId') String? partyId,
    @JsonKey(name: 'partyName') String? partyName,
    @JsonKey(name: 'phoneNumber') String? phoneNumber,
    @JsonKey(name: 'referredByMemberId') String? referredByMemberId,
    @JsonKey(name: 'referredByMemberName') String? referredByMemberName,
    String? status,
    @JsonKey(name: 'userEmail') String? userEmail,
    @JsonKey(name: 'userId') String? userId,
    @JsonKey(name: 'userMobileNumber') String? userMobileNumber,
  }) = _Member;

  factory Member.fromJson(Map<String, dynamic> json) =>
      _$MemberFromJson(json);
}

@freezed
class MembersListData with _$MembersListData {
  const factory MembersListData({
    List<Member>? content,
    @JsonKey(name: 'totalElements') int? totalElements,
  }) = _MembersListData;

  factory MembersListData.fromJson(Map<String, dynamic> json) =>
      _$MembersListDataFromJson(json);
}

@freezed
class MembersListResponse with _$MembersListResponse {
  const factory MembersListResponse({
    String? status,
    String? code,
    MembersListData? data,
    String? message,
  }) = _MembersListResponse;

  factory MembersListResponse.fromJson(Map<String, dynamic> json) =>
      _$MembersListResponseFromJson(json);
}
