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

  get({path, Function callback}) async {
    await _dio.get(path).then((response) {
      print("[${response.statusCode}]");
      if (response.statusCode == HttpStatus.ok) {
        callback(response.data);
      } else {
        callback('${response.statusCode}');
      }
    });
  }

  Future<Response> get3({who, path, FormData data, Function callback}) async {
    try {

      return await _dio.get(
        path,
      );
    } catch (e) {
      print("[${who == null ? '' : who}]=> post catch = \n${e.toString()}");
      return null;
    }
  }

  ///刷新框架 之数据访问
  ///1、正常情况返回 Response
  ///2、异常情况（关闭网络等）返回 null
  Future<dynamic> post3({who, path, FormData data, Function callback}) async {
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

  Future<dynamic> get33({who, path, FormData data, Function callback}) async {
    try {
      Response response = await _dio.get(
        path,
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

  Future<Response> post5({who, path, FormData data, Function callback}) async {
    try {
      return await _dio.post(
        path,
        data: data,
      ).then((response) {
        print("[${who == null ? '' : who}]=> code = ${response.statusCode}");
        if (response.statusCode == HttpStatus.ok) {
          return json.decode(response.data.toString());
        } else {
          return null;
        }
      });
    } catch (e) {
      print("[${who == null ? '' : who}]=> post catch = \n${e.toString()}");
      return null;
    }
  }

  post1({who, path, FormData data, Function callback}) async {
    try {
      await _dio.post(
        path,
        data: data,
      ).then((response) {
        print("[${who == null ? '' : who}]=> code = ${response.statusCode}");
        if (response.statusCode == HttpStatus.ok) {
          callback(json.decode(response.data.toString()));
        } else {
          callback(null);
        }
      });
    } catch (e) {
      callback(null);
      print("[${who == null ? '' : who}]=> post catch = \n${e.toString()}");
    }
  }

//  download2({who, path, Function callback}) async {
//    return _dio;
//  }
//
//  download({who, path, Function callback}) async {
//    print('download ');
//    try {
////      final dir = await getApplicationDocumentsDirectory();
//      String dir = (await getExternalStorageDirectory()).path;
//      print('path = ${dir}/wzkt.apk');
//      await _dio.download(path, "${dir}/wzkt.apk",
//          onReceiveProgress: (progress, all) {
//            callback(all, progress);
//          });
//    } catch (e) {
//      print("[${who == null ? '' : who}]=> post catch = \n${e.toString()}");
//    }
//  }



  post4({ path, FormData data}) async {
    try {
      return await _dio.post(
        path,
        data: data,
      );
    } catch (e) {
      return null;
    }
  }

  post2({who, path, FormData data, Function callback}) async {
    try {
      await _dio.post(
        path,
        data: data,
      ).then((response) {
        print("[${who == null ? '' : who}]=> response code = ${response
            .statusCode}");
        if (response.statusCode == HttpStatus.ok) {
          callback(response.data);
        } else {
          callback('${response.statusCode}');
        }
      });
    } catch (e) {
      callback(null);
      print("[${who == null ? '' : who}]=> post catch = \n${e.toString()}");
    }
  }

  post(path, {String who, Map<String,
      dynamic> queryParameters, FormData data, Function callback}) async {
    try {
      dynamic result = await _dio.post(
        path,
        data: data,
      ).then((response) {
        print("[${who == null ? '' : who}]=> code = ${response.statusCode}");
        if (response.statusCode == HttpStatus.ok) {
          return response.data;
        } else {
          return response.statusCode;
        }
      });
      Future.delayed(Duration(milliseconds: 500), () {
        print("[${who == null ? '' : who}]=> path = ${path}");
        print("[${who == null ? '' : who}]=> post jsons = \n${result}");
        callback(result);
      });
    } catch (e) {
      ///这里需要 新增一个errrobean，封装异常数据，以便解析使用
      print("[${who == null ? '' : who}]=> post catch = \n${e.toString()}");
      callback(null);
    }
  }

}