import 'package:flutter/material.dart';
import 'package:money_saver/bean/booking/booking_vo.dart';
import 'package:money_saver/bean/booking/booking_vo_provider.dart';
import 'package:money_saver/bean/marktype/mark_type_vo.dart';
import 'package:money_saver/common/widgets/common_widget_factory.dart';
import 'package:money_saver/database/db_instance.dart';
import 'package:money_saver/pages/create_booking.dart';
import 'package:sqflite/sqflite.dart';

import '../bean/booking/booking_vo.dart';

class BookingList extends StatefulWidget {
  final int accountType;

  BookingList(this.accountType);

  @override
  _BookingListState createState() => _BookingListState();
}

class _BookingListState extends State<BookingList> {
  Database db;
  BookingProvider provider;

  @override
  void initState() {
    super.initState();
    db = DbInstance().db;
    provider = BookingProvider();
    _getLatestData();
  }

  List<BookingVO> bookingList = [];

  _getLatestData() async {
    int now = DateTime.now().millisecondsSinceEpoch;
    List<BookingVO> result =
        await provider.queryList(db, now, 30, widget.accountType);
    if (result != null && result.isNotEmpty) {
      bookingList.clear();
      bookingList.addAll(result);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: CommonWidgets.getAppbar('记账单'),
          backgroundColor: Colors.grey,
        ),
        body: _buildBody(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // 添加一笔记账
            Navigator.push(context, MaterialPageRoute(builder: (ctx) {
              return CreateBooking(widget.accountType);
            })).then((value) {
              if (value ?? false) {
                _getLatestData();
              }
            });
          },
          backgroundColor: Colors.grey,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          shape: CircularNotchedRectangle(),
          child: Container(
            height: 50,
          ),
        ));
  }

  Widget _buildBody() {
    if (db == null || bookingList.isEmpty) {
      return Container(
        alignment: Alignment.center,
        child: Text(
          '快来记下第一笔吧...',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
      );
    } else {
      return ListView.separated(
          itemBuilder: (ctx, index) {
            BookingVO booking = bookingList[index];
            return GestureDetector(
              onTap: () {
                // TODO 修改或删除
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
                      MarkTypeVO.getIconByType(booking.markType),
                      width: 24,
                      height: 24,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    // title
                    Text(
                      '111111111',
                    ),
                    // 金额
                    Expanded(
                        child: Text(
                      booking.money.toString(),
                      textAlign: TextAlign.right,
                    )),
                    SizedBox(
                      width: 15,
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (ctx, index) {
            return Container();
          },
          itemCount: bookingList.length);
    }
  }
}
