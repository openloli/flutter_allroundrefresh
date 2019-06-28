import 'package:flutter/material.dart';

/*
This is default  init loading widget.
The background color of the Widget follows the system.
*/
class ProgressView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new SizedBox(
        width: 30.0,
        height: 30.0,
        child: new CircularProgressIndicator(
          strokeWidth: 2.0,
          backgroundColor: Colors.red,
        ),
      ),
    );
  }
}
