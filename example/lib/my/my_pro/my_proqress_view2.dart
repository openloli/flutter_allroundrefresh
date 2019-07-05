import 'package:flutter/material.dart';

class YourProgress2Widget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Container(
        width: 80.0,
        height: 80.0,
        child: Image.asset(
          "images/xiaoxin.gif",
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
