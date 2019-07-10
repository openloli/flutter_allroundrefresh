import 'package:flutter/material.dart';

class YourError1Widget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery
          .of(context)
          .size
          .height / 4),
      width: MediaQuery
          .of(context)
          .size
          .width,
      child: Column(
        children: <Widget>[
          Container(
            height: 160.0,
            width: MediaQuery
                .of(context)
                .size
                .width,
            alignment: Alignment.center,
            child: Image.asset(
              "images/error.jpg",
              fit: BoxFit.cover,),
          ),
        ],
      ),
    );
  }
}
