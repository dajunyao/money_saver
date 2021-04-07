// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingVO _$BookingVOFromJson(Map<String, dynamic> json) {
  return BookingVO(
    id: json['id'] as int,
    accountType: json['accountType'] as int,
    bookTime: json['bookTime'] as int,
    bookYear: json['bookYear'] as int,
    bookMonth: json['bookMonth'] as int,
    bookDay: json['bookDay'] as int,
    money: json['money'] as int,
    iconType: json['iconType'] as int,
    type: json['type'] as int,
    title: json['title'] as String,
    custom: json['custom'] as int,
    remark: json['remark'] as String,
  );
}

Map<String, dynamic> _$BookingVOToJson(BookingVO instance) => <String, dynamic>{
      'id': instance.id,
      'accountType': instance.accountType,
      'bookTime': instance.bookTime,
      'bookYear': instance.bookYear,
      'bookMonth': instance.bookMonth,
      'bookDay': instance.bookDay,
      'money': instance.money,
      'iconType': instance.iconType,
      'type': instance.type,
      'title': instance.title,
      'custom': instance.custom,
      'remark': instance.remark,
    };
