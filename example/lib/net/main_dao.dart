import 'dart:convert' show json;
import 'package:dio/dio.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:flutter_allroundrefresh_example/net/net.dart';

class MainDao {
  static var baseUrl = 'http://api.36ve.com/index.php?r=';
  static var courseList = baseUrl + 'app-teacher/get-my-course-list';

  static Future<Response> getCourseList({ page}) async {
    var uid = '2d809d05-bb0b-34f4-a0e4-b80e75e519d8';
    var token = '819c8a057468453685fcdec0a5c3f8f0';
    var projectId = '65f00449-78c4-39f5-83c7-0f3707e8b009';
    FormData data = new FormData.from({
      "userId": uid,
      "token": token,
      "pageSize": '20',
      "page": page.toString(),
      "projectId": projectId,
      "type": 'all',
    });
    return HttpManager().post3(
      who: 'teacherCourseList',
      path: courseList,
      data: data,
    );
  }


}
