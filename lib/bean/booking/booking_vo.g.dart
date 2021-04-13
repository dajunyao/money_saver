// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingVO _$BookingVOFromJson(Map<String, dynamic> json) {
  return BookingVO(
    id: json['id'] as int,
    accountType: json['accountType'] as int,
    inOutType: json['inOutType'] as int,
    markType: json['markType'] as int,
    bookTime: json['bookTime'] as int,
    money: json['money'] as num,
    remark: json['remark'] as String,
  );
}

Map<String, dynamic> _$BookingVOToJson(BookingVO instance) => <String, dynamic>{
      'id': instance.id,
      'accountType': instance.accountType,
      'inOutType': instance.inOutType,
      'markType': instance.markType,
      'bookTime': instance.bookTime,
      'money': instance.money,
      'remark': instance.remark,
    };
