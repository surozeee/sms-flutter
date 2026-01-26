// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'members_list_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MembersListRequestImpl _$$MembersListRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$MembersListRequestImpl(
      page: (json['page'] as num).toInt(),
      size: (json['size'] as num).toInt(),
    );

Map<String, dynamic> _$$MembersListRequestImplToJson(
        _$MembersListRequestImpl instance) =>
    <String, dynamic>{
      'page': instance.page,
      'size': instance.size,
    };
