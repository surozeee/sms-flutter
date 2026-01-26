// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'members_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MemberImpl _$$MemberImplFromJson(Map<String, dynamic> json) => _$MemberImpl(
      address: json['address'] as String?,
      balance: (json['balance'] as num?)?.toDouble(),
      bio: json['bio'] as String?,
      boothId: json['boothId'] as String?,
      boothName: json['boothName'] as String?,
      createdAt: json['createdAt'] as String?,
      designationId: json['designationId'] as String?,
      designationName: json['designationName'] as String?,
      email: json['email'] as String?,
      fullName: json['fullName'] as String?,
      id: json['id'] as String?,
      lastModifiedAt: json['lastModifiedAt'] as String?,
      partyId: json['partyId'] as String?,
      partyName: json['partyName'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      referredByMemberId: json['referredByMemberId'] as String?,
      referredByMemberName: json['referredByMemberName'] as String?,
      status: json['status'] as String?,
      userEmail: json['userEmail'] as String?,
      userId: json['userId'] as String?,
      userMobileNumber: json['userMobileNumber'] as String?,
    );

Map<String, dynamic> _$$MemberImplToJson(_$MemberImpl instance) =>
    <String, dynamic>{
      'address': instance.address,
      'balance': instance.balance,
      'bio': instance.bio,
      'boothId': instance.boothId,
      'boothName': instance.boothName,
      'createdAt': instance.createdAt,
      'designationId': instance.designationId,
      'designationName': instance.designationName,
      'email': instance.email,
      'fullName': instance.fullName,
      'id': instance.id,
      'lastModifiedAt': instance.lastModifiedAt,
      'partyId': instance.partyId,
      'partyName': instance.partyName,
      'phoneNumber': instance.phoneNumber,
      'referredByMemberId': instance.referredByMemberId,
      'referredByMemberName': instance.referredByMemberName,
      'status': instance.status,
      'userEmail': instance.userEmail,
      'userId': instance.userId,
      'userMobileNumber': instance.userMobileNumber,
    };

_$MembersListDataImpl _$$MembersListDataImplFromJson(
        Map<String, dynamic> json) =>
    _$MembersListDataImpl(
      content: (json['content'] as List<dynamic>?)
          ?.map((e) => Member.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalElements: (json['totalElements'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$MembersListDataImplToJson(
        _$MembersListDataImpl instance) =>
    <String, dynamic>{
      'content': instance.content,
      'totalElements': instance.totalElements,
    };

_$MembersListResponseImpl _$$MembersListResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$MembersListResponseImpl(
      status: json['status'] as String?,
      code: json['code'] as String?,
      data: json['data'] == null
          ? null
          : MembersListData.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$$MembersListResponseImplToJson(
        _$MembersListResponseImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'data': instance.data,
      'message': instance.message,
    };
