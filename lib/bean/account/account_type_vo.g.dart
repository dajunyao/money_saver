// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_type_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountTypeVO _$AccountTypeVOFromJson(Map<String, dynamic> json) {
  return AccountTypeVO(
    id: json['id'] as int,
    accountType: json['accountType'] as int,
    accountName: json['accountName'] as String,
    iconType: json['iconType'] as int,
    lastTime: json['lastTime'] as int,
  );
}

Map<String, dynamic> _$AccountTypeVOToJson(AccountTypeVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'accountType': instance.accountType,
      'accountName': instance.accountName,
      'iconType': instance.iconType,
      'lastTime': instance.lastTime,
    };
