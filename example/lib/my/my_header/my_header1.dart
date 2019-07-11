import 'package:flutter/material.dart';

class MyHeader1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      width: MediaQuery
          .of(context)
          .size
          .width,
      child: Container(
        alignment: Alignment.center,
        width: 30.0,
        height: 30.0,
        child: Image.asset(
          "assets/images/loading.gif",
          fit: BoxFit.fill,),
      ),
    );
  }
}
