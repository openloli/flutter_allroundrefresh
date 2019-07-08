import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_allroundrefresh/future_refresh.dart';
import 'package:flutter_allroundrefresh_example/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AFutureWidget.init(
//      loadingText: '111加载中...',
//      noDataText: '111没有更多数据了',
//      idleText: '111加载更多',
//      failedText: '111加载失败，点击重试',
//      errorMsg: '111暂无数据',
    );
    return MaterialApp(
      title: 'AllRoundRefresh  Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
