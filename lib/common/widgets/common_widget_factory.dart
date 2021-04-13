import 'package:flutter/material.dart';

class CommonWidgets {
  static Widget getAppbar(String title) {
    return Text(
      title,
      style: TextStyle(
          fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
    );
  }

  static Widget getBackWidget(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Icon(
        Icons.arrow_back,
        size: 24,
      ),
    );
  }
}
