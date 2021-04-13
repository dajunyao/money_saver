import 'package:flutter/material.dart';
import 'package:money_saver/pages/booking_list.dart';
import 'package:money_saver/pages/welcome.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Money Saver',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Welcome(),
    );
  }
}
