import 'package:flutter_allroundrefresh/flutter_allroundrefresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert' show json;
import 'package:dio/dio.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:io';





class ARefreshWidgetHelper {
//  static onRefresh(
//      {bool up, Function refreshCallback, Function noNetworkCallback}) async {
//    print('start 11111');
//    Observable.fromFuture(asyncFunction()).listen((type) {
//      print('start 3333 type =${type}');
//      if (type) {
//        refreshCallback(up);
//      } else {
//        print('start 444');
//        noNetworkCallback();
//      }
//    });
//  }
//
//  static Future<bool> asyncFunction() async {
//    var start = new DateTime.now().millisecondsSinceEpoch;
//    var connectivityResult = await(Connectivity().checkConnectivity());
//    return Future.delayed(const Duration(seconds: 0), () {
//      print('checkConnectivity state = ${connectivityResult.toString() }');
//      if (connectivityResult == ConnectivityResult.none) {
//        var end = new DateTime.now().millisecondsSinceEpoch;
//        print('checkConnectivity  1耗时  end = ${end} - start = ${start} = ${end -
//            start}');
//        return false;
//      }
//      var end = new DateTime.now().millisecondsSinceEpoch;
//      print('checkConnectivity  2耗时  end = ${end} - start = ${start} = ${end -
//          start}');
//      return true;
//    });
//  }

  ///刷新框架 之包装器
  ///包装各类情况下的网络获取的数据
  ///1、正常数据则返回让发起类进行处理
  ///2、非正常则通过直接告诉发起类唤起对应错误页面/情况
  ///3、code=200 data=[]时的情况待观察（后台说不会出现这种情况）
  static refresh({
    refreshController,
    Future<Response> response,
    Function callbackNormal,
    Function callbackError,
    Function callbackReLogin,
  }) async {
    print('ARefreshWidgetHelper refresh result = ${response
        .toString()
        .length > 120 ? response.toString().substring(0, 100) + '...' : response
        .toString()}');
    response.then((response) {
      if (refreshController != null) {
        refreshController.refreshCompleted();
      }
      if (response != null && response.statusCode == HttpStatus.ok) {
        print('ARefreshWidgetHelper 获得数据 = ${response.data.toString()}');
        var code = json.decode(response.data.toString())["code"];
        if (code == 200.toString()) {
          var data = json.decode(response.data.toString())["data"];
          print('ARefreshWidgetHelper 200 = ${data.toString()}');
          callbackNormal(json.decode(response.data.toString()));
        } else {
          var msg = json.decode(response.data.toString())["msg"];
          if (code == '900') {
            print('_surprise2 900 = ${msg}');
            callbackReLogin(msg);
          } else {
            print('_surprise2 !200 = ${msg}');
            callbackError(msg);
          }
        }
      } else {
        ARefreshWidgetHelper.checkConnectivity().then((onValue) {
          callbackError(onValue);
        });
      }
    }
    );
  }

  static void callReLogin({BuildContext context, title, cancel = false}) {
//    print('callbackReLogin');
//    callDialog(
//        title: title,
//        context: context,
//        cancel: true,
//        callback: () {
//          Navigator.of(context).pop();
//          RouteHelper.pushWidget(context, VideoLoginPage(), replaceRoot: true);
//        }
//    );
  }

  static void callError(
      {up, resultStatus, error, msg, refreshController, BuildContext context, title, cancel = false}) {
    if (up) {
      resultStatus = ResultStatus.error;
      error = msg;
    } else {
      resultStatus = ResultStatus.noMore;
      refreshController.loadNoData();
    }
  }


  static Future<String> checkConnectivity() async {
//    var connectivityResult = await(Connectivity().checkConnectivity());
//    print('checkConnectivity 服务器超时、wifi、没开网络 等问题鉴定 : $connectivityResult');
//    return connectivityResult == ConnectivityResult.none
//        ? '检测到手机没有网络，请打开网络后重试！'
//        : (connectivityResult == ConnectivityResult.wifi
//        ? '网络差或服务器超时，请稍后重试或使用4G尝试！'
//        : '网络差或服务器超时，请稍后重试!');
  }

  static refreshSimple({
    Future<Response> response,
    Function callbackNormal,
    Function callbackError,
  }) async {
    print('ARefreshWidgetHelper refreshSimple result = ${response.toString()}');
    response.then((response) {
      try {
        if (response != null && response.statusCode == HttpStatus.ok) {
//          MyBanner myBanner = MyBanner.fromJson(response.data);
//          callbackNormal('200', myBanner.data);
        } else {
          callbackError('404', null);
          print('refreshSimple 没有开wifi等问题');
        }
      } catch (e) {
        print('refreshSimple catch 没有开wifi等问题');
      }
    }
    );
  }


  static refreshOther({
    Future<Response> response,
    Function callbackNormal,
    Function callbackError,
  }) async {
    print('ARefreshWidgetHelper refreshOther result = ${response.toString()}');
    response.then((response) {
      try {
        if (response != null && response.statusCode == HttpStatus.ok) {
          callbackNormal('200', response.data.toString());
        } else {
          callbackError('404', null);
          print('refreshOther 没有开wifi等问题');
        }
      } catch (e) {
        print('refreshOther catch 没有开wifi等问题');
      }
    }
    );
  }


}