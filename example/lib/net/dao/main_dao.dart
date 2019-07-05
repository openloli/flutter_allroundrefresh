import 'dart:convert' show json;
import 'package:dio/dio.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:flutter_allroundrefresh_example/net/net.dart';

class MainDao {
  static var baseUrl = 'http://api.36ve.com/index.php?r=';
  static var courseList = baseUrl + 'app-teacher/get-my-course-list';
  static var courseCatalog = baseUrl + 'pp-teacher/app-get-tcourse-catalog';

  static Future<dynamic> getCourseList({ page}) async {
    print('_onRefresh 触发 getCourseList');
    var uid = '8fbe2b6a-78dd-3551-a52a-4be21b2a1bcf';
    var token = 'e5a383194f8feb9e9a5ed4ffb522d3c7';
    var projectId = '65f00449-78c4-39f5-83c7-0f3707e8b009';
    FormData data = new FormData.from({
      "userId": uid,
      "token": token,
      "pageSize": '10',
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

//

  ///根据课程ID 获取对应的课程目录（资源）
  static Future<Response> getCourseCatalog({ courseId}) async {
    var courseId = '8fbe2b6a-78dd-3551-a52a-4be21b2a1bcf';
    var token = 'b49caaeead8a0e8a8b3c357b24160547';
    FormData data = new FormData.from({
      "token": token,
      "courseId": courseId,
    });
    return HttpManager().post3(
      who: 'getCourseCatalog',
      path: courseCatalog,
      data: data,
    );
  }
}
