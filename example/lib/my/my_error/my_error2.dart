import 'package:flutter/material.dart';

class MyError2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180.0,
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
              "images/error2.gif",
              fit: BoxFit.cover,),
          ),
          Text('暂无数据'),
        ],
      ),
    );
  }
}
