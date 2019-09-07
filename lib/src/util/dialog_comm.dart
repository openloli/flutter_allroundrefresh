import 'package:flutter/material.dart';

callDialog({context, title, cancel = true, Function callback}) async {
  showDialog<Null>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return new AlertDialog(
        content: new SingleChildScrollView(
          child: new ListBody(
            children: <Widget>[
              new Text('$title'),
            ],
          ),
        ),
        actions: <Widget>[
          cancel
              ? FlatButton(
                  child: new Text('取消'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              : Container(
                  height: 0.0,
                ),
          FlatButton(
            child: new Text('确定'),
            onPressed: () {
              callback();
            },
          ),
        ],
      );
    },
  ).then((val) {
    print('11111弹出框 $val');
  });
}
