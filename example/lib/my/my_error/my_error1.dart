import 'package:flutter/material.dart';

class YourError1Widget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery
          .of(context)
          .size
          .height / 4),
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
