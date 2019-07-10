import 'package:flutter/material.dart';

import 'package:flutter_allroundrefresh_example/net/net.dart';
import 'package:flutter_allroundrefresh_example/pages/bottom_bar_home.dart';
import 'package:flutter_allroundrefresh_example/pages/my/simple_page1.dart';
import 'package:flutter_allroundrefresh_example/pages/my/simple_page2.dart';
import 'package:flutter_allroundrefresh_example/pages/my/simple_page3.dart';
import 'package:flutter_allroundrefresh_example/pages/my/simple_page4.dart';
import 'package:flutter_allroundrefresh_example/pages/my/simple_page5.dart';
import 'package:flutter_allroundrefresh_example/pages/my/simple_page6.dart';
import 'package:flutter_allroundrefresh_example/pages/my/simple_page7.dart';
import 'package:flutter_allroundrefresh_example/pages/tabbar_paper_home.dart';
import 'package:flutter_allroundrefresh_example/util/rout_helper.dart';




class SimpleMyPage extends StatefulWidget {
  @override
  _SimpleMyPageState createState() => _SimpleMyPageState();
}

class _SimpleMyPageState extends State<SimpleMyPage> {

  @override
  void initState() {
    HttpManager().initDio(yourIntercept: null, yourPEM: '9527');
    pageMap.forEach((k, v) {
      dataList.add(k);
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('AllRoundRefresh example app'),
        ),
        body: GridView.builder(
          padding: EdgeInsets.only(top: 2.0, left: 2.0, right: 2.0),
          itemCount: pageMap.length,
          itemBuilder: (context, i) {
            String keyName = dataList[i];
            return new Material(
              elevation: 4.0,
              color: i % 2 == 0 ? Colors.blue : Colors.green,
              borderRadius: new BorderRadius.all(new Radius.circular(6.0)),
              child: new InkWell(
                  onTap: () {
                    callUI(pageMap[keyName]);
                  },
                  child:
                  new Container(
                    margin: EdgeInsets.all(5.0),
                    alignment: Alignment.center,
                    child: new Text(keyName,style: TextStyle(color: Colors.white,fontSize: 16.0),),
                  )
              ),
            );
          },
          gridDelegate: new SliverGridDelegateWithMaxCrossAxisExtent(
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 4.0,
            maxCrossAxisExtent: 160.0,
          ),
        ),
      ),
    );
  }


  callUI(Widget page) {
    if (page != null) {
      RouteHelper.pushWidget(context, page, replaceRoot: false);
    } else {
      print('callUI = ${page.toString()}');
    }
  }

  List<String> dataList = [];
  Map<String, Widget> pageMap = {
    '初始转圈+下拉刷新+无数据（点击重试）': new SimpleMyPage1(),
    '初始转圈+下拉刷新+登录失效': new SimpleMyPage2(),
    '初始转圈+下拉刷新+加载更多': new SimpleMyPage3(),
    '自定义始化转圈1': new SimpleMyPage4(),
    '自定义始化转圈2': new SimpleMyPage5(),
    '自定义错误页面1（点击重试）': new SimpleMyPage6(),
    '自定义错误页面2（点击重试）': new SimpleMyPage7(),
    '底部页面情况（BottomNavigationBar）': new BottomBarHomePage(),
    '顶部页面情况（TabBarView）': new TabBarHomePage(),
    //    '初始转圈+下拉刷新+': new SimpleMyPage3(),
//    '初始转圈+下拉刷新+加载更多（+无网络+网络差或超时）': new SimpleMyPage1(),
//    '无快速返回顶部效果': null,
  };
}
