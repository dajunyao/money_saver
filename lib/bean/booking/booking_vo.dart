import 'package:json_annotation/json_annotation.dart';

part 'booking_vo.g.dart';

@JsonSerializable()
class BookingVO {
  // id
  int id;

  // 账本类型
  int accountType;

  // 收支类型  // 0 支出 1 收入
  int inOutType;

  // 记账类型 // 从 MARK_TYPE 中获取
  int markType;

  // 记账时间
  int bookTime;

  // 记账金额 // 存储到数据库时 * 100
  num money;

  // 备注
  String remark;

  BookingVO({
    this.id,
    this.accountType,
    this.inOutType,
    this.markType,
    this.bookTime,
    this.money,
    this.remark,
  });

  factory BookingVO.fromJson(Map<String, dynamic> json) =>
      _$BookingVOFromJson(json);

  Map<String, dynamic> toJson() => _$BookingVOToJson(this);
}
