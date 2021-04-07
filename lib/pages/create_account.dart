import 'package:flutter/material.dart';
import 'package:money_saver/bean/account/account_type_vo.dart';
import 'package:money_saver/bean/account/account_type_vo_provider.dart';
import 'package:money_saver/database/db_instance.dart';
import 'package:money_saver/pages/book_homepage.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  List<int> defaultAccountTypes = [0, 1];
  List<String> defaultTypes = ['日常', '工作'];

  AccountTypeProvider provider;

  bool saving = false;

  @override
  void initState() {
    super.initState();
    provider = AccountTypeProvider();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          '选择记账模版',
          style: TextStyle(fontSize: 14, color: Colors.black),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1 / 1.5),
            itemBuilder: (ctx, index) {
              return GestureDetector(
                onTap: () {
                  if (!saving) {
                    saving = true;
                    // 点击选择一个模版
                    int type = defaultAccountTypes[index];
                    String name = defaultTypes[index];
                    int lastTime = DateTime.now().millisecondsSinceEpoch;
                    AccountTypeVO save = AccountTypeVO(
                        accountType: type,
                        accountName: name,
                        iconType: type,
                        lastTime: lastTime);
                    provider.insert(DbInstance().db, save);
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (ctx) {
                      return BookHomepage(type);
                    }));
                    saving = false;
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      border: Border.all(color: Colors.grey, width: 0.5)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add),
                      Text(
                        defaultTypes[index],
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      )
                    ],
                  ),
                ),
              );
            },
            itemCount: defaultTypes.length),
      ),
    );
  }
}
