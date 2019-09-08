import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_allroundrefresh_example/page/bat_page/bar_page1.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:flutter/widgets.dart';


import 'package:flutter_allroundrefresh/future_refresh.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_allroundrefresh_example/my/my_pro/my_proqress_view2.dart';
import 'package:flutter_allroundrefresh_example/util/dialog_comm.dart';
import 'package:connectivity/connectivity.dart';

/**
 * Core class
 * Use polymorphism and overloading
 * Encapsulate common page styles
 * Package refresh plugin
 * Package data processing
 * Package turn effect
 * Adapt the title, floating window in the upper right corner, etc.
 */

///
enum DataState { normal, noData, noNetwork, catched }

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  int pageSize = 10;
  bool isFirst = true, isLoading = false, isError = false, isPrint = false;
  var tokenInvalidCode = '900',
      normalCode = '200',
      noDataCode = '404',
      errorMsg = '暂无内容',
      netClose = '检测到手机没有网络，请打开网络后重试！',
      netWifiLose = '网络差或服务器超时，请稍后重试或使用4G尝试！',
      netLoseOrTimeOut = '网络差或服务器超时，请稍后重试!';

  ///手动调动初始转圈
  callLoadingCheck(int size) {
    size >= pageSize ? isLoading = true : isLoading = false;
  }

  ///手动调动初始转圈
  callInitLoading() {
    isFirst = true;
    setState(() {});
  }

  ///使用刷新组件
  bodyWidget({
    Object model,
    List<Object> modelList,
    onRefresh,
    onLoading,
    contentBody,
  }) {
    if (isPrint) {
      print('callRefresh onRefresh = $onRefresh');
      print('callRefresh onLoading = $onLoading');
      print('callRefresh contentBody = $contentBody');
    }
    if (onLoading == null) {
      isLoading = false;
    }
    return Stack(
      children: <Widget>[
        SmartRefresher(
          enablePullDown: true,
          enablePullUp: isLoading,
          header: WaterDropHeader(),
          footer: CustomFooter(
            builder: (BuildContext context, LoadStatus mode) {
              Widget body;
              if (mode == LoadStatus.idle) {
                body = Text("");
              } else if (mode == LoadStatus.loading) {
                body = CupertinoActivityIndicator();
              } else if (mode == LoadStatus.failed) {
                body = Text("点击重试");
              } else {
                body = Text("没有更多数据了");
              }
              return Container(
                height: 55.0,
                child: Center(child: body),
              );
            },
          ),
          controller: refreshController,
          onRefresh: onRefresh,
          onLoading: onLoading,
          child: isError
              ? bodyError(model: model, modelList: modelList)
              : contentBody,
        ),
        //初始转圈扩展
        new Offstage(
          offstage: isFirst ? false : true,
          child: new Container(
            alignment: Alignment.center,
            color: Colors.white70,
            child: YourProgress2Widget(),
          ),
        ),
      ],
    );
  }

  ///使用刷新组件
  bodyHeadWidget({
    BuildContext context,
    Object model,
    List<Object> modelList,
    onRefresh,
    onLoading,
    headBody,
    contentBody,
  }) {
    if (isPrint) {
      print('callRefresh onRefresh = $onRefresh');
      print('callRefresh onLoading = $onLoading');
      print('callRefresh contentBody = $contentBody');
    }
    if (onLoading == null) {
      isLoading = false;
    }
    return Column(
      children: <Widget>[
        headBody,
        Expanded(
          child: Stack(
            children: <Widget>[
              SmartRefresher(
                enablePullDown: true,
                enablePullUp: isLoading,
                header: WaterDropHeader(),
                footer: CustomFooter(
                  builder: (BuildContext context, LoadStatus mode) {
                    Widget body;
                    if (mode == LoadStatus.idle) {
                      body = Text("");
                    } else if (mode == LoadStatus.loading) {
                      body = CupertinoActivityIndicator();
                    } else if (mode == LoadStatus.failed) {
                      body = Text("点击重试");
                    } else {
                      body = Text("没有更多数据了");
                    }
                    return Container(
                      height: 55.0,
                      child: Center(child: body),
                    );
                  },
                ),
                controller: refreshController,
                onRefresh: onRefresh,
                onLoading: onLoading,
                child: isError
                    ? bodyError(model: model, modelList: modelList)
                    : contentBody,
              ),
              //初始转圈扩展
              new Offstage(
                offstage: isFirst ? false : true,
                child: new Container(
                  alignment: Alignment.center,
                  color: Colors.white70,
                  child: YourProgress2Widget(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  ///使用刷新组件
  bodyComplexWidget({
    BuildContext context,
    Object model,
    List<Object> modelList,
    onRefresh,
    onLoading,
    headBody,
    contentBody,
  }) {
    if (isPrint) {
      print('callRefresh onRefresh = $onRefresh');
      print('callRefresh onLoading = $onLoading');
      print('callRefresh contentBody = $contentBody');
    }
    if (onLoading == null) {
      isLoading = false;
    }
    return Column(
      children: <Widget>[
        headBody,
        Expanded(
          child: Stack(
            children: <Widget>[
              SmartRefresher(
                enablePullDown: true,
                enablePullUp: isLoading,
                header: WaterDropHeader(),
                footer: CustomFooter(
                  builder: (BuildContext context, LoadStatus mode) {
                    Widget body;
                    if (mode == LoadStatus.idle) {
                      body = Text("");
                    } else if (mode == LoadStatus.loading) {
                      body = CupertinoActivityIndicator();
                    } else if (mode == LoadStatus.failed) {
                      body = Text("点击重试");
                    } else {
                      body = Text("没有更多数据了");
                    }
                    return Container(
                      height: 55.0,
                      child: Center(child: body),
                    );
                  },
                ),
                controller: refreshController,
                onRefresh: onRefresh,
                onLoading: onLoading,
                child: isError
                    ? bodyError(model: model, modelList: modelList)
                    : contentBody,
              ),
              //初始转圈扩展
              new Offstage(
                offstage: isFirst ? false : true,
                child: new Container(
                  alignment: Alignment.center,
                  color: Colors.white70,
                  child: YourProgress2Widget(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  ///使用错误页面
  Widget bodyError({
    Object model,
    List<Object> modelList,
  }) {
    print('bodyError');
    return Center(
      child: GestureDetector(
        child: Container(
          alignment: Alignment.center,
          width: 200.0,
          height: 120.0,
          color: Colors.green[300],
          child: Text('$errorMsg'),
        ),
        onTap: () {
          if (model == null) {
            modelList.clear();
          } else {
            model = null;
          }

          SchedulerBinding.instance.addPostFrameCallback((_) {
            print('bodyError 1');
            refreshController.requestRefresh();
          });
        },
      ),
    );
  }

  ///使用刷新处理器
  void callRefresh({
    Object model,
    List<Object> modelList,
    dao,
    dataCallback,
    tokenInvalidCallback,
    other = false,
  }) async {
    callLoadComplete();
    Future.delayed(const Duration(milliseconds: 2000)).then((val) {
      dao.then((result) {
        if (result != null) {
          if (isPrint) {
            print('callRefresh result = ${result.toString()}');
            print('modelList = ${modelList}'); //临时
            print('model = ${model}'); //临时
          }
          isFirst = false;
          isError = false;
          if (other) {
            dataCallback('1111');
          } else {
            if (model == null) {
              modelList.clear();
            } else {
              model = null;
            }
            CommBean bean = CommBean.fromJson(result);
            if (bean.data == null || bean.data == '') {
              callRefreshFailed();
            } else {
              callRefreshCompleted();
              if (bean.code == normalCode) {
                if (isPrint) {
                  print('callRefresh bean.data = ${bean.data}');
                }
                dataCallback(bean.data);
                setState(() {});
              } else if (bean.code == noDataCode) {
                callRefreshResultNoData(bean.msg);
              } else if (bean.code == tokenInvalidCode) {
                print('是这里弹出的 of bean?');
                callRefreshResultToken(bean.msg,
                    tokenInvalidCallback: tokenInvalidCallback);
              } else {
                callRefreshOther(bean.msg);
              }
            }
          }
        } else {
          callRefreshResultNull();
        }
      });
    });
  }




  void callRefreshOther(msg) {
    errorMsg = msg;
    isError = true;
  }

  void callLoadComplete() {
    refreshController.loadComplete();
  }

  void callRefreshFailed() {
    refreshController.refreshFailed();
  }

  void callRefreshCompleted() {
    refreshController.refreshCompleted();
  }

  void callRefreshResultNoData(msg) {
    errorMsg = msg;
    isError = true;
    setState(() {});
  }

  void callRefreshResultToken(msg, {tokenInvalidCallback}) {
    print('callRefreshResultToken  $msg');
    callDialog(
        title: msg,
        context: context,
        cancel: false,
        callback: () {
          Navigator.of(context).pop();
          tokenInvalidCallback();
        });
  }

  void callRefreshResultNull() {
    isFirst = false;
    isError = true;
    refreshController.refreshFailed();
    checkConnectivity().then((onValue) {
      errorMsg = onValue;
      setState(() {});
    });
  }

  ///使用加载更多处理器
  void callLoading({
    dao,
    dataCallback,
    tokenInvalidCallback,
  }) async {
    Future.delayed(const Duration(milliseconds: 1000)).then((val) {
      dao.then((result) {
        if (result != null) {
          if (isPrint) {
            print('callLoading result = ${result.toString()}');
          }
          CommBean bean = CommBean.fromJson(result);
          if (bean.data == null || bean.data == '') {
            refreshController.loadFailed();
          } else {
            if (bean.code == normalCode) {
              refreshController.loadComplete();
              if (isPrint) {
                print('callLoading bean.data = ${bean.data}');
              }
              dataCallback(bean.data);
              setState(() {});
            } else if (bean.code == noDataCode) {
              refreshController.loadNoData();
            } else if (bean.code == tokenInvalidCode) {
              callRefreshResultToken(bean.msg,
                  tokenInvalidCallback: tokenInvalidCallback);
            } else {
              refreshController.loadFailed();
            }
          }
        } else {
          refreshController.loadFailed();
        }
      });
    });
  }

  ///使用网络异常情况分析器
  Future<String> checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult == ConnectivityResult.none
        ? netClose
        : (connectivityResult == ConnectivityResult.wifi
            ? netWifiLose
            : netLoseOrTimeOut);
  }
}
