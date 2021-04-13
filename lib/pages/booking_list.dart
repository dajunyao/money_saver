import 'package:flutter/material.dart';
import 'package:money_saver/bean/booking/booking_vo.dart';
import 'package:money_saver/bean/booking/booking_vo_provider.dart';
import 'package:money_saver/common/widgets/common_widget_factory.dart';
import 'package:money_saver/database/db_instance.dart';
import 'package:money_saver/pages/create_booking.dart';
import 'package:sqflite/sqflite.dart';

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
            String json = bookingList[index].toJson().toString();
            return Container(
              color: Colors.blue,
              child: Text(
                json,
                style: TextStyle(fontSize: 14, color: Colors.black),
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
