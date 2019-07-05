import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_allroundrefresh_example/net/net.dart';
import 'package:flutter_allroundrefresh_example/pages/sample2.dart';
import 'package:flutter_allroundrefresh_example/pages/sample3.dart';
import 'package:flutter_allroundrefresh_example/pages/sample4.dart';
import 'package:flutter_allroundrefresh_example/pages/sample5.dart';
import 'package:flutter_allroundrefresh_example/pages/sample6.dart';
import 'package:flutter_allroundrefresh_example/pages/sample7.dart';
import 'package:flutter_allroundrefresh_example/pages/sample8.dart';
import 'package:flutter_allroundrefresh_example/pages/sample9.dart';
import 'package:flutter_allroundrefresh_example/pages/sapmle1.dart';
import 'package:flutter_allroundrefresh_example/pages/sapmle10.dart';
import 'package:flutter_allroundrefresh_example/util/rout_helper.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    HttpManager().initDio(yourIntercept: null, yourPEM: '9527');
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('AllRoundRefresh example app'),
        ),
        body: SingleChildScrollView(
          child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: 120.0,
              ),
              child: Column(
                children: _buildItemWidget(context),
              )
          ),
        ),
      ),
    );
  }

  _buildItemWidget(BuildContext context) {
    List<Widget> _list = new List();
    for (int i = 0; i < _styleList.length; i++) {
      _list.add(buildListData(context, _styleList[i], iconItems[i]));
    }
    return ListTile.divideTiles(context: context, tiles: _list)
        .toList();
  }

  Widget buildListData(BuildContext context, String strItem, Icon iconItem) {
    return new ListTile(
      isThreeLine: false,
      leading: (strItem == '' ? Icon(null) : iconItem),
      title: new Text(strItem),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () {
        switchOnTap(context, strItem);
      },
    );
  }

  switchOnTap(context, String strItem) {
    Widget page = null;
//    if (strItem == _styleList[0]) {
//      page = Sample1();
//    } else if (strItem == _styleList[1]) {
//      page = Sample2();
//    } else if (strItem == _styleList[2]) {
//      page = Sample3();
//    } else if (strItem == _styleList[3]) {
//      page = Sample4();
//    } else if (strItem == _styleList[4]) {
//      page = Sample5();
//    } else if (strItem == _styleList[5]) {
//      page = Sample6();
//    } else if (strItem == _styleList[6]) {
//      page = Sample7();
//    } else if (strItem == _styleList[7]) {
//      page = Sample8();
//    } else if (strItem == _styleList[8]) {
//      page = Sample9();
//    } else if (strItem == _styleList[9]) {
//    } else if (strItem == _styleList[10]) {
//    }

    if (strItem == _styleList[9]) {
      page = Sample10();
    }
    if (page != null) {
      RouteHelper.pushWidget(
          context, page, replaceRoot: false);
    }
  }

  List<Icon> iconItems = <Icon>[
    new Icon(Icons.ac_unit), new Icon(Icons.weekend),
    new Icon(Icons.web), new Icon(Icons.keyboard),
    new Icon(Icons.print), new Icon(Icons.router),
    new Icon(Icons.pages), new Icon(Icons.person),
    new Icon(Icons.zoom_out_map), new Icon(Icons.wifi_tethering),
    new Icon(Icons.wifi_lock), new Icon(Icons.widgets),


  ];
  List<String> _styleList = [
    '1初始化',
    '2初始化+下拉刷新+(第二次后：随机刷新失败+重试)',
    '3初始化+下拉刷新+上拉加载+(第二次后：随机 刷新/加载 失败)',
    '4无快速返回顶部效果',
    '5自定义始化转圈1',
    '6自定义始化转圈2',
    '7自定义错误页面1（可重试）',
    '8自定义错误页面2（不可重试） ',
    '9正式接口正式页面',
    '10 大跃进框架尝试',
  ];
}
