import 'dart:io';
import 'package:dio/dio.dart';
import 'dart:convert' show json;

class HttpManager {
  static const CONTENT_TYPE_JSON = "application/json";
  static const CONTENT_TYPE_FORM = "application/x-www-form-urlencoded";
  static const CONTENT_TYPE_data = "text/html; charset=UTF-8";
  static const CONTENT_TYPE_data2 = "data-form";
  static Dio _dio;
  static final int CONNECR_TIME_OUT = 20000;
  static final int RECIVE_TIME_OUT = 20000;
  static Map<String, CancelToken> _cancelTokens;


  ///配置dio
  initDio({var yourIntercept, yourPEM, yourProxy}) {
    if (_dio == null) {
      _dio = Dio();
      _dio.options.connectTimeout = CONNECR_TIME_OUT;
      _dio.options.receiveTimeout = RECIVE_TIME_OUT;

      ///代理设置
      if (yourProxy != null && yourProxy != '') {
        (_dio.httpClientAdapter as DefaultHttpClientAdapter)
            .onHttpClientCreate =
            (client) {
          // config the http client
          client.findProxy = (uri) {
            //proxy all request to localhost:8888
            return yourProxy;
          };
          // you can also create a new HttpClient to dio
          // return new HttpClient();
        };
      }

      /// 证书配置
      if (yourPEM != null && yourPEM != '') {
        (_dio.httpClientAdapter as DefaultHttpClientAdapter)
            .onHttpClientCreate = (client) {
          client.badCertificateCallback =
              (X509Certificate cert, String host, int port) {
            print('证书 cert.pem = ${cert.pem},, = PEM = ${yourPEM}');
            if (cert.pem == yourPEM) { // Verify the certificate

              return true;
            }
            return false;
          };
        };
      }

      /// 添加拦截器

      if (yourIntercept != null) {
        _dio.interceptors.add(yourIntercept);
      }
//      addInterceptors(new MyIntercept());
      return this;
    }
  }

  addInterceptors(var yourIntercept) {
    print('添加拦截器 ${yourIntercept.toString()}');
    _dio.interceptors.add(yourIntercept);
  }

  Future<dynamic> get({who, path, Function callback}) async {
    try {
      Response response = await _dio.get(
        path,
      );
      if (response.statusCode == HttpStatus.ok) {
        return json.decode(response.data);
      } else {
        return null;
      }
    } catch (e) {
      print("[${who == null ? '' : who}]=> get catch = \n${e.toString()}");
      return null;
    }
  }

  Future<dynamic> post1({who, path, FormData data, Function callback}) async {
    try {
      Response response = await _dio.post(
        path,
        data: data,
      );
      if (response.statusCode == HttpStatus.ok) {
        return json.decode(response.data.toString());
      } else {
        return null;
      }
    } catch (e) {
      print("[${who == null ? '' : who}]=> post catch = \n${e.toString()}");
      return null;
    }
  }


}