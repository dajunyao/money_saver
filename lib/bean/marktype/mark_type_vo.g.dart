// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mark_type_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MarkTypeVO _$MarkTypeVOFromJson(Map<String, dynamic> json) {
  return MarkTypeVO(
    id: json['id'] as int,
    markType: json['markType'] as int,
    markTitle: json['markTitle'] as String,
    markIcon: json['markIcon'] as String,
    custom: json['custom'] as int,
  );
}

Map<String, dynamic> _$MarkTypeVOToJson(MarkTypeVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'markType': instance.markType,
      'markTitle': instance.markTitle,
      'markIcon': instance.markIcon,
      'custom': instance.custom,
    };
