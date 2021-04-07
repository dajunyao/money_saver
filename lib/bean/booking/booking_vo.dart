import 'package:json_annotation/json_annotation.dart';

part 'booking_vo.g.dart';

@JsonSerializable()
class BookingVO {
  // id
  int id;

  // 账本类型
  int accountType;

  // 记账时间
  int bookTime;

  // 记账年
  int bookYear;

  // 记账月
  int bookMonth;

  // 记账日
  int bookDay;

  // 记账金额 // 存储到数据库时 * 100
  int money;

  // 图标
  int iconType;

  // 记账类型
  int type;

  // 记账类型标题
  String title;

  // 是否自定义  //0 true 1 false
  int custom;

  // 备注
  String remark;

  BookingVO(
      {this.id,
      this.accountType,
      this.bookTime,
      this.bookYear,
      this.bookMonth,
      this.bookDay,
      this.money,
      this.iconType,
      this.type,
      this.title,
      this.custom,
      this.remark});

  factory BookingVO.fromJson(Map<String, dynamic> json) => _$BookingVOFromJson(json);
  Map<String, dynamic> toJson() => _$BookingVOToJson(this);

  static BookingVO getTestData(){
    DateTime now = DateTime.now();
    return BookingVO(
      accountType: 1,
      bookTime: now.millisecondsSinceEpoch,
      bookYear: now.year,
      bookMonth: now.month,
      bookDay: now.day,
      money: 50,
      iconType: 0,
      type: 0,
      title: '单1',
      custom: 1,
      remark: 'remark'
    );
  }
}
