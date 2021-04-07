import 'package:json_annotation/json_annotation.dart';

part 'account_type_vo.g.dart';

@JsonSerializable()
class AccountTypeVO {
  // id
  int id;

  // 账本类型
  int accountType;

  // 名称
  String accountName;

  // 图标
  int iconType;

  // 访问时间
  int lastTime;

  AccountTypeVO(
      {this.id,
      this.accountType,
      this.accountName,
      this.iconType,
      this.lastTime});

  factory AccountTypeVO.fromJson(Map<String, dynamic> json) => _$AccountTypeVOFromJson(json);
  Map<String, dynamic> toJson() => _$AccountTypeVOToJson(this);
}
