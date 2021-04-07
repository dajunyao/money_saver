import 'package:flutter/material.dart';
import 'package:money_saver/bean/booking/booking_vo.dart';
import 'package:money_saver/bean/booking/booking_vo_provider.dart';
import 'package:money_saver/database/db_instance.dart';
import 'package:sqflite/sqflite.dart';

class BookHomepage extends StatefulWidget {
  final int accountType;

  BookHomepage(this.accountType);

  @override
  _BookHomepageState createState() => _BookHomepageState();
}

class _BookHomepageState extends State<BookHomepage> {
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
        body: _buildBody(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            BookingVO record = BookingVO.getTestData();
            provider.insert(db, record);
            _getLatestData();
          },
          child: Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          child: Container(
            height: 40,
            child: Row(
              children: [
                Expanded(child: Icon(Icons.add)),
                Expanded(child: Icon(Icons.delete)),
              ],
            ),
          ),
        )
        // BottomNavigationBar(
        //   items: [
        //     BottomNavigationBarItem(icon: Icon(Icons.add), label: 'add'),
        //     BottomNavigationBarItem(icon: Icon(Icons.delete), label: 'del')
        //   ],
        //   backgroundColor: Colors.yellow,
        // ),
        // bottomNavigationBar: BottomNavigationBar(
        //
        // ),
        );
  }

  Widget _buildBody() {
    if (db == null || bookingList.isEmpty) {
      return Container(
        alignment: Alignment.center,
        child: Text('getting data'),
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
