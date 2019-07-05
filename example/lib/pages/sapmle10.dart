import 'package:flutter_allroundrefresh/future_refresh.dart';
import 'package:flutter_allroundrefresh_example/my/my_error/my_error2.dart';
import 'package:flutter_allroundrefresh_example/my/my_pro/my_proqress_view1.dart';
import 'package:flutter_allroundrefresh_example/my/my_pro/my_proqress_view2.dart';
import 'package:flutter_allroundrefresh_example/net/bean/course_list.dart';
import 'package:flutter_allroundrefresh_example/net/dao/main_dao.dart';
import 'package:flutter/material.dart';


class Sample10 extends StatefulWidget {
  @override
  _Sample10State createState() => _Sample10State();
}

class _Sample10State extends State<Sample10> with TickerProviderStateMixin {
  var page = 1;
  List<CourseListData> modelList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('框架测试'),
      ),
      body: AFutureWidget(
        childWidget: yourContentWidget(),
        errorWidget: YourError2Widget(),
        progressWidget: YourProgress2Widget(),
        fRefresh: MainDao.getCourseList(page: 1,),
        fLoading: MainDao.getCourseList(page: page,),
        onLoadingCallback: () {page = page + 1;setState(() {});},
        onRefreshCallback: () {page = 1;modelList.clear();setState(() {});},
        tokenInvalidCallback: () {print('这里是 token失效的回调处理 通常为弹出对话框，点击确定,关闭前置页，打开登录页');},
        dataCallback: (List<dynamic> data) {
          data.forEach((v) {
            modelList.add(new CourseListData.fromJson(v));
          });
          setState(() {});
        },
      ),
    );
  }


  Widget yourContentWidget() {
    return ListView.builder(
      itemCount: modelList.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          alignment: Alignment.center,
          height: 80.0,
          child: Text('${modelList[index].name}'),
        );
      },
    );
  }
}

