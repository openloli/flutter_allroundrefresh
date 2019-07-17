import 'package:flutter/material.dart'
    hide RefreshIndicator, RefreshIndicatorState;
import 'package:flutter_allroundrefresh/src/proview/proqress_view.dart';
import 'package:flutter_allroundrefresh/src/util/dialog_comm.dart';
import 'package:flutter_allroundrefresh/src/smart_refresher.dart';
import 'package:flutter_allroundrefresh/src/bean/comm_bean.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_allroundrefresh/src/util/sp_util.dart';
import '../future_refresh.dart';
import 'dart:async';


class AFutureWidget extends StatefulWidget {

  final bool enablePullDown; //是否开启下拉刷新

  final Widget errorWidget; //404布局头
  final Widget progressWidget; //初始转圈
  final ScrollView childWidget; //具体的展示Widget:ListView...GridView

  Future<dynamic> fRefresh; //刷新方法
  Future<dynamic> fLoading; //加载更多方法，如果不写则表示无上拉加载更多

  final Function dataCallback; //数据回调，用于处理数据
  final Function onRefreshCallback; //刷新回调，用于清理数据，重置page
  final Function onLoadingCallback; //加载更多回调，用于page+1
  final Function tokenInvalidCallback; //Token失效回调，用于处理对应事件
  final Function otherCallback;

  final RefreshIndicator header;
  final LoadIndicator footer;


  AFutureWidget({
    Key key,
    this.enablePullDown = true,
    this.childWidget,
    this.errorWidget,
    this.progressWidget,
    this.fRefresh,
    this.fLoading,
    this.dataCallback,
    this.onRefreshCallback,
    this.onLoadingCallback,
    this.tokenInvalidCallback,
    this.otherCallback,

    this.header,
    this.footer,
  })
      : super(key: key);


  @override
  State<StatefulWidget> createState() => AFutureWidgetState();


  static void init({
    loadingText: '加载中...',
    noDataText: '没有更多数据了',
    idleText: '加载更多',
    failedText: '加载失败，点击重试',
    errorMsg: '暂无数据',
    normalCode: '200',
    noDataCode: '404',
    tokenInvalidCode: '900',
    netClose: '检测到手机没有网络，请打开网络后重试！',
    netWifiLose: '网络差或服务器超时，请稍后重试或使用4G尝试！',
    netLoseOrTimeOut: '网络差或服务器超时，请稍后重试!',

  }) async {
    await SpUtil.getInstance();
    SpUtil.putString('loadingText', loadingText);
    SpUtil.putString('noDataText', noDataText);
    SpUtil.putString('idleText', idleText);
    SpUtil.putString('failedText', failedText);
    SpUtil.putString('errorMsg', errorMsg);
    SpUtil.putString('normalCode', normalCode);
    SpUtil.putString('noDataCode', noDataCode);
    SpUtil.putString('tokenInvalidCode', tokenInvalidCode);
    SpUtil.putString('netClose', netClose);
    SpUtil.putString('netWifiLose', netWifiLose);
    SpUtil.putString('netLoseOrTimeOut', netLoseOrTimeOut);
  }

  static AFutureWidgetState of(BuildContext context) {
    return context?.ancestorStateOfType(
        const TypeMatcher<AFutureWidgetState>());
  }
}

class AFutureWidgetState extends State<AFutureWidget> {

  bool refresh = false,
      first = true,
      error = false;
  RefreshController _refreshController;
  var errorMsg, normalCode, noDataCode, tokenInvalidCode;

  @override
  void initState() {
    _refreshController = new RefreshController(); //刷新框架
    errorMsg = SpUtil.getString('errorMsg');
    normalCode = SpUtil.getString('normalCode');
    noDataCode = SpUtil.getString('noDataCode');
    tokenInvalidCode = SpUtil.getString('tokenInvalidCode');
    first = true;

    _onRefresh();
    super.initState();
  }

  void _onOffsetCallback(bool isUp, double offset) {
    if (isUp) {} else {}
  }

  @override
  Widget build(BuildContext context) {
    helperSetting(context);
    return new Scaffold(
      body: content1(),
    );
  }


  Future<String> checkConnectivity() async {
    var connectivityResult = await(Connectivity().checkConnectivity());
    return connectivityResult == ConnectivityResult.none
        ? SpUtil.getString('netClose')
        : (connectivityResult == ConnectivityResult.wifi
        ? SpUtil.getString('netWifiLose')
        : SpUtil.getString('netLoseOrTimeOut'));
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }


  void _onRefresh() {
    if (widget.fRefresh != null) {
      _refreshController.loadComplete();
      Future.delayed(const Duration(milliseconds: 1000)).then((val) {
        widget.fRefresh.then((result) {
          if (result != null) {
            first = false;
            error = false;
            CommBean bean = CommBean.fromJson(result);
            if (bean.data == null || bean.data == '') {
              _refreshController.refreshFailed();
            } else {
              _refreshController.refreshCompleted();
              widget.onRefreshCallback();
              if (bean.code == normalCode) {
                widget.dataCallback(bean.data);
              } else if (bean.code == noDataCode) {
                errorMsg = bean.msg;
                error = true;
              } else if (bean.code == tokenInvalidCode) {
                callDialog(
                    title: bean.msg,
                    context: context,
                    cancel: false,
                    callback: () {
                      Navigator.of(context).pop();
                      widget.tokenInvalidCallback();
                    }
                );
              } else {
                errorMsg = bean.msg;
                error = true;
              }
            }
          } else {
            first = false;
            error = true;
            widget.onRefreshCallback();
            _refreshController.refreshFailed();
            checkConnectivity().then((onValue) {
              errorMsg = onValue;
              setState(() {});
            });
          }
          setState(() {});
        });
      });
    }
  }


  void _onLoading() {
    if (widget.fLoading != null) {
      widget.onLoadingCallback();
      Future.delayed(const Duration(milliseconds: 1000)).then((val) {
        widget.fLoading.then((result) {
          if (result != null) {
            CommBean bean = CommBean.fromJson(result);
            if (bean.data == null || bean.data == '') {
              _refreshController.loadFailed();
            } else {
              if (bean.code == normalCode) {
                _refreshController.loadComplete();
                widget.dataCallback(bean.data);
              } else if (bean.code == noDataCode) {
                _refreshController.loadNoData();
              }
            }
          } else {
            _refreshController.loadFailed();
          }
        });
      });
    }
  }


  Widget content1() {
    return Stack(
      children: <Widget>[
        SmartRefresher(
          enablePullDown: widget.enablePullDown,
          enablePullUp: widget.fLoading == null ? false : true,
          onOffsetChange: _onOffsetCallback,
          header: defaultTargetPlatform == TargetPlatform.iOS
              ? WaterDropHeader()
              : MaterialClassicHeader(),
          footer: ClassicFooter(
            loadingText: SpUtil.getString('loadingText'),
            noDataText: SpUtil.getString('noDataText'),
            idleText: SpUtil.getString('idleText'),
            failedText: SpUtil.getString('failedText'),
          ),
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          child: widget.childWidget,
        ),
        //初始转圈扩展
        new Offstage(
          offstage: first ? false : true,
          child: new Container(
            alignment: Alignment.center,
            color: Colors.white70,
            child: widget.progressWidget == null ? ProgressView() : widget
                .progressWidget,
          ),
        ),
        //错误页面
        new Offstage(
          offstage: error ? false : true,
          child: new Container(
            alignment: Alignment.center,
            color: Colors.white70,
            child: GestureDetector(
              onTap: () {
                SchedulerBinding.instance.addPostFrameCallback((_) {
                  _refreshController.requestRefresh();
                });
              },
              child: widget.errorWidget == null ? Text(errorMsg) :
              Column(children: <Widget>[
                widget.errorWidget,
                Text(errorMsg),
              ],)
              ,
            ),
          ),
        )
      ],
    );
  }

  /**
   * 扩展方法，作者的实际项目项目中有这样一个要求，在页面内，可通过点击按钮触发接口
   * （可以理解为切换uid进行数据访问）
   * 在原组件中无法实现该功能，于是有了这个 helper 类，若有更好的方案，希望能告知作者。
   *
   * The extension method, the author's actual project project has such a requirement,
   * in the page, the interface can be triggered by clicking the button
   * (can be understood as switching uid for data access)
           This function cannot be implemented in the original component,
      so I have this helper class. If there is a better solution, I hope to inform the author.
   * */
  void helperSetting(BuildContext context) {
    if(widget.otherCallback!=null){
      var helper = AFutureWidgetHelper(
        context: context,
        fRefresh: widget.fRefresh,
        refreshController: _refreshController,
        first: first,
        error: error,
        onRefreshCallback: widget.onRefreshCallback,
        dataCallback: widget.dataCallback,
        tokenInvalidCallback: widget.tokenInvalidCallback,
        normalCode: normalCode,
        noDataCode: noDataCode,
        tokenInvalidCode: tokenInvalidCode,
        errorMsg: errorMsg,
        setStateCallBack: () {
          checkConnectivity().then((onValue) {
            errorMsg = onValue;
            setState(() {});
          });
        },
        checkConnectivitycallBack: () {
          setState(() {});
        },
      );

      widget.otherCallback(helper);
    }
  }
}

class AFutureWidgetHelper {

  var context, fRefresh, _refreshController, first, error, onRefreshCallback,
      dataCallback, tokenInvalidCallback, normalCode, noDataCode, errorMsg,
      tokenInvalidCode, setStateCallBack, checkConnectivitycallBack;

  AFutureWidgetHelper({
    context, fRefresh, refreshController, first, error,
    onRefreshCallback, dataCallback, tokenInvalidCallback, normalCode,
    noDataCode, tokenInvalidCode, errorMsg, Function setStateCallBack, Function checkConnectivitycallBack,
  }) {
    this.context = context;
    this.fRefresh = fRefresh;
    this._refreshController = refreshController;
    this.first = first;
    this.error = error;
    this.onRefreshCallback = onRefreshCallback;
    this.dataCallback = dataCallback;
    this.tokenInvalidCallback = tokenInvalidCallback;
    this.normalCode = normalCode;
    this.noDataCode = noDataCode;
    this.tokenInvalidCode = tokenInvalidCode;
    this.errorMsg = errorMsg;
    this.setStateCallBack = setStateCallBack;
    this.checkConnectivitycallBack = checkConnectivitycallBack;
  }

  void manualRefresh(Future<dynamic> FutureResult) {
    if (FutureResult != null) {
      FutureResult.then((result) {
        _refreshController.loadComplete();
        if (result != null) {
          first = false;
          error = false;
          CommBean bean = CommBean.fromJson(result);
          if (bean.data == null || bean.data == '') {
            _refreshController.refreshFailed();
          } else {
            _refreshController.refreshCompleted();
            onRefreshCallback();
            if (bean.code == normalCode) {
              dataCallback(bean.data);
            } else if (bean.code == noDataCode) {
              errorMsg = bean.msg;
              error = true;
            } else if (bean.code == tokenInvalidCode) {
              callDialog(
                  title: bean.msg,
                  context: context,
                  cancel: false,
                  callback: () {
                    Navigator.of(context).pop();
                    tokenInvalidCallback();
                  }
              );
            } else {
              errorMsg = bean.msg;
              error = true;
            }
          }
        } else {
          first = false;
          error = true;
          onRefreshCallback();
          _refreshController.refreshFailed();
          checkConnectivitycallBack();
        }
        setStateCallBack();
      });
    }
  }
}
