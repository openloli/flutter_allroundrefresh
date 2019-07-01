import 'package:flutter/material.dart';

class MyProgressView2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Container(
          width: 300.0,
          height: 300.0,
          child: Image.asset(
            "images/loading.gif",
            fit: BoxFit.fill,
          ),
      ),
    );
  }
}
