import 'package:json_annotation/json_annotation.dart';

part 'mark_type_vo.g.dart';

@JsonSerializable()
class MarkTypeVO {
  static const int BUY = 0;
  static const int CAR = 1;
  static const int CLOTHES = 2;
  static const int EAT = 3;
  static const int HOUSE = 4;
  static const int PET = 5;
  static const int TRAFFIC = 0;

  static String getIconByType(int markType) {
    switch (markType) {
      case BUY:
        return 'images/ic_buy.png';
      case CAR:
        return 'images/ic_car.png';
      case CLOTHES:
        return 'images/ic_clothes.png';
      case EAT:
        return 'images/ic_eat.png';
      case HOUSE:
        return 'images/ic_house.png';
      case PET:
        return 'images/ic_pets.png';
      case TRAFFIC:
        return 'images/ic_traffic.png';
    }
    return 'images/ic_buy.png';
  }


  int id;
  int markType; // 记账类型
  String markTitle; // 类型标题
  String markIcon; // 类型图标
  int custom; // 是否自定义类型 0 false 1 true

  MarkTypeVO({
    this.id,
    this.markType,
    this.markTitle,
    this.markIcon,
    this.custom,
  });

  factory MarkTypeVO.fromJson(Map<String, dynamic> json) =>
      _$MarkTypeVOFromJson(json);

  Map<String, dynamic> toJson() => _$MarkTypeVOToJson(this);
}
