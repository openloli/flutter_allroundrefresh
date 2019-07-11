import 'dart:async';
import 'package:flutter_allroundrefresh_example/net/net.dart';

class SimpleDao {
  static var API_date10 = "http://www.mocky.io/v2/5d25615d2f00006400c10754";//  十条数据
  static var API_date3 = "http://www.mocky.io/v2/5d25892f2f00009136c10841";// 三条数据
  static var API_date0 = "http://www.mocky.io/v2/5d2596052f00000a35c108c7";//数据为空
  static var API_date_out = "http://www.mocky.io/v2/5d2596052f00000a35c108c7?mocky-delay=600000ms";//模拟超时
  static var API_date900 = "http://www.mocky.io/v2/5d25968c2f00004834c108d1";//登录失效重新登录

  static var API_date_err = "http://www.mocky.io/v2/5d25968c2f00004834c108d11111";//模式错误

  ///十条数据1
  static Future<dynamic> getData10({ page}) async {
    return HttpManager().get(
      who: 'getData10',
      path: API_date10,
    );
  }

  /// 三条数据
  static Future<dynamic> getData4({ page}) async {
    return HttpManager().get(
      who: 'getData4',
      path: API_date3,
    );
  }

  ///没有数据
  static Future<dynamic> getData0({ page}) async {
    return HttpManager().get(
      who: 'getData0',
      path: API_date0,
    );
  }

  ///登录失效重新登录
  static Future<dynamic> getData900({ page}) async {
    return HttpManager().get(
      who: 'API_date900',
      path: API_date900,
    );
  }

  ///超时
  static Future<dynamic> getDataTimeOut({ page}) async {
    return HttpManager().get(
      who: 'API_date900',
      path: API_date_out,
    );
  }

  ///错误
  static Future<dynamic> getDataErr({ page}) async {
    return HttpManager().get(
      who: 'API_date_err',
      path: API_date_err,
    );
  }
}
