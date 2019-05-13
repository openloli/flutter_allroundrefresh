import 'package:flutter/material.dart';

class MyError1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160.0,
      width: MediaQuery
          .of(context)
          .size
          .width,
      child: Container(
        alignment: Alignment.center,

        child: Image.asset(
          "images/error.jpg",
          fit: BoxFit.cover,),
      ),
    );
  }
}
