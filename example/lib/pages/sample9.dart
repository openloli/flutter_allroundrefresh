//import 'package:flutter_allroundrefresh/flutter_allroundrefresh.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter_allroundrefresh_example/net/a_refreshwidget_helper.dart';
//import 'package:flutter_allroundrefresh_example/net/bean/course_list.dart';
//import 'package:flutter_allroundrefresh_example/net/main_dao.dart';
//
/////我（老师）的课程页面
//class Sample9 extends StatefulWidget {
//  @override
//  _Sample9State createState() => _Sample9State();
//}
//
//class _Sample9State extends State<Sample9>
//    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
//
//  AnimationController _animController;
//  List<CourseListData> modelList = [];
//
//  ///刷新框架 之必要字段
//  ///1、核心控件_refreshController，必须有
//  ///2、核心控件resultStatus = ResultStatus.init 必须初始化
//  RefreshController _refreshController;
//  var resultStatus = ResultStatus.init;
//  var page = 1; //加载更多才需要
//  var error = '';
//
//  @override
//  Widget build(BuildContext context) {
//
//    return Scaffold(
//      appBar: AppBar(
//        title: Text('我的课程列表页面'),
//        actions: <Widget>[
//          new IconButton(
//            icon: new Icon(Icons.search),
//            onPressed: () {
//            },
//          )
//        ],
//      ),
//
//      body: AllRoundRefresher(
//        resultStatus: resultStatus,
//        enablePullDown: true,
//        enablePullUp: true,
//        header: WaterDropHeader(),
////        error: CommError(msg: error),
//        controller: _refreshController,
//        onRefresh: _onRefresh,
//        onLoading: _onLoading,
////        onOffsetChange: _onOffsetCallback,
//        child: ListView.builder(
//          itemCount: modelList.length,
//          itemBuilder: (BuildContext context, int index) {
//            return Text('${modelList[index].name}');
//          },
//        ),
//        errCallback: () {
//          print('onTap  11111');
//          resultStatus = ResultStatus.retry;
//          setState(() {});
//        },
//      ),
//    );
//  }
//
//  @override
//  void dispose() {
//    _animController.dispose();
//    _refreshController.dispose();
//    super.dispose();
//  }
//
//  @override
//  void initState() {
//    _animController = AnimationController(vsync: this,
//        duration: Duration(seconds: 3),
//        lowerBound: 0.0,
//        upperBound: 1.0);
//    _refreshController = new RefreshController(); //刷新框架
//    ///刷新框架 之第一次获取数据
//    Future.delayed(const Duration(milliseconds: 2000)).then((val) {
//      _surprise(true);
//    });
//    super.initState();
//  }
//
//  ///刷新框架 之刷新数据，关键字段 true
//  void _onRefresh() {
//    Future.delayed(const Duration(milliseconds: 1000)).then((val) {
//      _surprise(true);
//    });
//  }
//
//  ///刷新框架 之加载更多，关键字段 false
//  void _onLoading() {
//    Future.delayed(const Duration(milliseconds: 1000)).then((val) {
//      _surprise(false);
//    });
//  }
//
//  ///刷新框架 之获取网络数据+情况分析+数据处理
//  ///1、MainDao.getCourseList为本页面具体的接口【手动替换】
//  ///2、callbackNormal 正常数据处理，CourseListData.fromJson2为本页面具体bean处理方式，【手动替换】
//  ///3、callbackError 非正常数据处理，为通用型
//  ///4、根据up 关键字进行上拉刷新和加载更多的数据处理，无加载更多时需要移除else中代码
//  _surprise(up) async {
//    page = up ? 1 : ++page;
//    print('courseList page = ${page},,up = ${up}');
//
//
//
//    ARefreshWidgetHelper.refresh(
//        refreshController: _refreshController,
//        response: MainDao.getCourseList(
//          page: page,
//        ),
//        callbackNormal: (json) {
//          CourseList courseList = CourseList.fromJson(json);
//          print('_onRefresh listData = ${courseList.data.length}');
//
//          if (up) {
//            if (courseList.data.length > 0) {
//              modelList.clear();
//              resultStatus = ResultStatus.nomel;
//              modelList.addAll(courseList.data);
//            } else {
//              resultStatus = ResultStatus.error;
//              error = '暂无数据';
//            }
//          } else {
//            if (courseList.data.length> 0) {
//              resultStatus = ResultStatus.nomel;
//              modelList.addAll(courseList.data);
//              _refreshController.loadComplete();
//            } else {
//              resultStatus = ResultStatus.noMore;
//              _refreshController.loadNoData();
//            }
//          }
//          setState(() {});
//        },
//        callbackError: (msg) {
//          if (up) {
//            resultStatus = ResultStatus.error;
//            error = msg;
//            setState(() {});
//          } else {
//            resultStatus = ResultStatus.noMore;
//            _refreshController.loadNoData();
//          }
//          setState(() {});
//        },
//
//        callbackReLogin: (reLogin) {
//          print('callbackReLogin');
//          ARefreshWidgetHelper.callReLogin(
//              context: context,
//              title: reLogin
//          );
//        }
//    );
//  }
//
//
//  @override
//  // TODO: implement wantKeepAlive
//  bool get wantKeepAlive => true;
//}
