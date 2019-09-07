import 'package:flutter/material.dart';

import 'package:flutter_allroundrefresh_example/net/net.dart';
import 'package:flutter_allroundrefresh/future_refresh.dart';
import 'package:flutter_allroundrefresh_example/page/home_page/bottom_bar_home.dart';
import 'package:flutter_allroundrefresh_example/page/home_page/bottom_bar_home2.dart';
import 'package:flutter_allroundrefresh_example/page/home_page/tabbar_paper_home2.dart';
import 'package:flutter_allroundrefresh_example/page/simple_page1.dart';
import 'package:flutter_allroundrefresh_example/page/simple_page10.dart';
import 'package:flutter_allroundrefresh_example/page/simple_page11.dart';
import 'package:flutter_allroundrefresh_example/page/simple_page12.dart';
import 'package:flutter_allroundrefresh_example/page/simple_page2.dart';
import 'package:flutter_allroundrefresh_example/page/simple_page3.dart';
import 'package:flutter_allroundrefresh_example/page/simple_page4.dart';
import 'package:flutter_allroundrefresh_example/page/simple_page5.dart';
import 'package:flutter_allroundrefresh_example/page/simple_page6.dart';
import 'package:flutter_allroundrefresh_example/page/simple_page7.dart';
import 'package:flutter_allroundrefresh_example/page/simple_page8.dart';
import 'package:flutter_allroundrefresh_example/page/simple_page9.dart';
import 'package:flutter_allroundrefresh_example/page/home_page/tabbar_paper_home.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
          title: const Text('AllRoundRefresh/AFutureWidget'),
          actions: <Widget>[],
        ),
        body: GridView.builder(
          padding: EdgeInsets.only(top: 2.0, left: 2.0, right: 2.0),
          itemCount: pageMap.length,
          itemBuilder: (context, i) {
            String keyName = dataList[i];
            return new Material(
              elevation: 4.0,
              color: i % 2 == 0
                  ? Colors.blue.withOpacity(0.7)
                  : Colors.green.withOpacity(0.7),
              borderRadius: new BorderRadius.all(new Radius.circular(6.0)),
              child: new InkWell(
                  onTap: () {
                    callUI(pageMap[keyName]);
                  },
                  child: new Container(
                    margin: EdgeInsets.all(5.0),
                    alignment: Alignment.center,
                    child: new Text(
                      keyName,
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                  )),
            );
          },
          gridDelegate: new SliverGridDelegateWithMaxCrossAxisExtent(
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 4.0,
            maxCrossAxisExtent: 180.0,
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
    '随机模拟：下拉刷新+加载更多+无数据+服务器异常+登录失效+页面返回+其他按钮触发网络': new SimplePage1(),
    '头布局1-活动头布局': new SimplePage2(),
    '头布局2-固定头布局': new SimplePage3(),
    '头布局3-复杂布局': new SimplePage4(),
//    '底部部布局': new SimplePage4(),
    '列表中有输入框的情况': new SimplePage5(),
    '九宫格': new SimplePage6(),
    '底部页面情况1（BottomNavigationBar,不重复加载）': new BottomBarHomePage(),
    '底部页面情况2（BottomNavigationBar）': new BottomBarHomePage2(),
    '顶部页面情况1（TabBarView）': new TabBarHomePage(),
    '顶部页面情况2（TabBarView,不重复加载）': new TabBarHomePage2(),

//    'Gank API': new SimplePage3(),
//    '自定义异常情况+随机数据获取': new SimplePage4(),
//    '初始转圈+下拉刷新+无数据（点击重试）': new SimplePage1(),
//    '初始转圈+下拉刷新+登录失效': new SimplePage2(),
//    '初始转圈+下拉刷新+加载更多': new SimplePage3(),
//    '默认转圈+默认错误页面（点击重试）': new SimplePage6(),
//    '有其他按钮触发网络的情况': new SimplePage5(),
//    '有头布局1': new SimplePage6(),
//    '有头布局2': new SimplePage11(),
//    '底部部布局': new SimplePage7(),
//    '列表中有输入框的情况': new SimplePage8(),
//    '九宫格': new SimplePage9(),
//    '非列表页面(如我的页面)': new SimplePage10(),
//    '头布局2+初始转圈+下拉刷新+加载更多': new SimplePage10(),
//    '自定义:始化转圈1+错误页面1（点击重试）': new SimplePage7(),
//    '自定义:始化转圈2+错误页面2（点击重试）': new SimplePage8(),
//    '底部页面情况（BottomNavigationBar）': new BottomBarHomePage(),
//    '顶部页面情况（TabBarView）': new TabBarHomePage(),
//    '从上个页面返回后刷新页面': new SimplePage12(),

//    '进度条': new SimplePage11(),
//    '背景动画': new SkyHomePage(),
//    '框架测试': new SimplePage12(),

//    '待定1': new SimplePage4(),
//    '待定2': new SimplePage5(),
//    '无快速返回顶部效果': null,
  };
}
