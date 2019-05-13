import 'package:flutter/material.dart';

class MyProgressView1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new SizedBox(
        width: 80.0,
        height: 80.0,
        child: new CircularProgressIndicator(
          strokeWidth: 2.0,
          backgroundColor: Colors.red,
        ),
      ),
    );
  }
}
