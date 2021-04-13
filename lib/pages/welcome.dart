import 'package:flutter/material.dart';
import 'package:money_saver/bean/account/account_type_vo.dart';
import 'package:money_saver/bean/account/account_type_vo_provider.dart';
import 'package:money_saver/database/db_instance.dart';
import 'package:money_saver/pages/booking_list.dart';
import 'package:sqflite/sqflite.dart';

import 'create_account.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  void initState() {
    super.initState();
    _initDb();
  }

  Database db;
  AccountTypeProvider provider;

  _initDb() async {
    await DbInstance().initDatabase();
    db = DbInstance().db;
    // 判断是否有账本
    provider = AccountTypeProvider();
    List<AccountTypeVO> accounts = await provider.queryList(db);
    if (accounts == null || accounts.isEmpty) {
      // 跳转创建账本
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) {
        return CreateAccount();
      }));
    } else {
      // 跳转本地记录的上次访问的账本
      int accountType = accounts.first.accountType;
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) {
        return BookingList(accountType);
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Text(
          'loading database',
          style: TextStyle(fontSize: 26, color: Colors.black),
        ),
      ),
    );
  }
}
