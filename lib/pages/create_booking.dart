import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_saver/bean/booking/booking_vo.dart';
import 'package:money_saver/bean/marktype/mark_type_vo.dart';
import 'package:money_saver/bean/marktype/mark_type_vo_provider.dart';
import 'package:money_saver/common/widgets/common_widget_factory.dart';
import 'package:money_saver/database/db_instance.dart';
import 'package:sqflite/sqflite.dart';

class CreateBooking extends StatefulWidget {
  final int accountType;

  CreateBooking(this.accountType);

  @override
  _CreateBookingState createState() => _CreateBookingState();
}

/// 上半（选择记账类型）+ 下半（数字键盘）
class _CreateBookingState extends State<CreateBooking> {
  double _gridWid;
  double _gridHeight;
  double _containerHeight;
  double _topHeight;

  List<String> keyboard = [
    '7',
    '8',
    '9',
    'x',
    '4',
    '5',
    '6',
    '+',
    '1',
    '2',
    '3',
    '-',
    '.',
    '0',
    '再记',
    '完成',
  ];
  TextEditingController remarkController = TextEditingController();

  BookingVO toSave;
  DateTime bookTime;
  DateTime firstDate;
  DateTime lastDate;

  Database db;
  MarkTypeProvider provider;
  List<MarkTypeVO> markType = [];
  Map<int, MarkTypeVO> markTypeMap = {};

  @override
  void initState() {
    super.initState();
    bookTime = DateTime.now();
    // 最早到记账时间年份的1月1日
    firstDate = DateTime(bookTime.year, 1, 1);
    // 最晚到当前时间的12月31日
    lastDate = DateTime(DateTime.now().year, 12, 31);
    toSave = BookingVO(
        accountType: widget.accountType,
        inOutType: 0,
        bookTime: bookTime.millisecondsSinceEpoch,
        markType: MarkTypeVO.BUY,
        money: 0);
    db = DbInstance().db;
    provider = MarkTypeProvider();
    _getMarkTypes();
  }

  _getMarkTypes() {
    provider.queryList(db).then((value) {
      if (value != null) {
        value.forEach((element) {
          markType.add(element);
          markTypeMap[element.markType] = element;
        });
        setState(() {});
      }
    }).catchError((err) {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _gridWid = size.width / 4;
    _gridHeight = _gridWid / 1.5;
    _containerHeight = _gridHeight * 4;
    _topHeight = size.height - _containerHeight - 50.5;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: CommonWidgets.getAppbar('新记录'),
        backgroundColor: Colors.grey,
        leading: CommonWidgets.getBackWidget(context),
      ),
      body: markType.isEmpty
          ? Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.grey),
              ),
            )
          : Column(
              children: [
                // 上半部分滚动适配显示不全的情况
                // 选择记账类型
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // 类别 ，金额
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 30, horizontal: 15),
                          margin: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.grey,
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 15,
                              ),
                              // 图标
                              Image.asset(
                                MarkTypeVO.getIconByType(
                                    toSave?.markType ?? MarkTypeVO.BUY),
                                width: 24,
                                height: 24,
                              ),
                              // title
                              Text(
                                markTypeMap.isEmpty
                                    ? ''
                                    : markTypeMap[
                                            toSave?.markType ?? MarkTypeVO.BUY]
                                        .markTitle,
                              ),
                              // 金额
                              Expanded(
                                  child: Text(
                                (toSave == null ? '0' : toSave.getShowMoney()),
                                textAlign: TextAlign.right,
                              )),
                              SizedBox(
                                width: 15,
                              ),
                            ],
                          ),
                        ),
                        // markType 选择
                        Container(
                          height: 200,
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10),
                            itemBuilder: (ctx, index) {
                              MarkTypeVO mark = markType[index];
                              return Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // 图标
                                    Image.asset(
                                      MarkTypeVO.getIconByType(mark.markType),
                                      width: 20,
                                      height: 20,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    // 文字
                                    Text(
                                      mark.markTitle,
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.black),
                                    )
                                  ],
                                ),
                              );
                            },
                            itemCount: markType.length,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                // 时间与备注
                Container(
                  height: 50,
                  color: Colors.white,
                  child: Row(
                    children: [
                      Expanded(
                          child: GestureDetector(
                        onTap: () {
                          showDatePicker(
                                  context: context,
                                  initialDate: bookTime,
                                  firstDate: firstDate,
                                  lastDate: lastDate)
                              .then((value) {
                            bookTime = value;
                            // 最早到记账时间年份的1月1日
                            firstDate = DateTime(bookTime.year, 1, 1);
                            toSave.bookTime = bookTime.millisecondsSinceEpoch;
                            setState(() {});
                          }).catchError((err) {});
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            (bookTime == null)
                                ? '时间'
                                : (bookTime.month.toString() +
                                    '月' +
                                    bookTime.day.toString() +
                                    '日 '),
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ),
                      )),
                      Container(
                        width: 0.3,
                        color: Colors.grey,
                      ),
                      Expanded(
                          child: GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (ctx) {
                                return AlertDialog(
                                  title: Text(
                                    '请输入备注',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  content: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: Colors.white),
                                    child: TextField(
                                      maxLength: 30,
                                      controller: remarkController,
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 15),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              borderSide: BorderSide(
                                                  color: Colors.grey)),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              borderSide: BorderSide(
                                                  color: Colors.grey))),
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.zero,
                                  // actionsPadding: EdgeInsets.zero,
                                  buttonPadding: EdgeInsets.zero,
                                  titlePadding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 15),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          '取消',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w600),
                                        )),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(
                                              context, remarkController.text);
                                        },
                                        child: Text(
                                          '确定',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600),
                                        ))
                                  ],
                                );
                              }).then((value) {
                            toSave.remark = value ?? '';
                            setState(() {});
                          }).catchError((err) {});
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            (toSave?.remark == null || toSave.remark == '')
                                ? '备注'
                                : toSave.remark,
                            style: TextStyle(fontSize: 14, color: Colors.black),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      )),
                    ],
                  ),
                ),
                Container(
                  height: 0.5,
                  color: Colors.grey,
                ),
                // // 数字键盘
                Container(
                  height: _containerHeight,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4, childAspectRatio: 1.5 / 1),
                    itemBuilder: (ctx, index) {
                      String text = keyboard[index];
                      bool isComplete = text == '完成';
                      return Container(
                        alignment: Alignment.center,
                        color: (isComplete) ? Colors.grey : Colors.white,
                        child: Text(
                          text,
                          style: TextStyle(
                              fontSize: 16,
                              color: isComplete ? Colors.white : Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                      );
                    },
                    itemCount: 16,
                  ),
                )
              ],
            ),
    );
  }
}
