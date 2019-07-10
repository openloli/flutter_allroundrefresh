import 'package:flutter_allroundrefresh/future_refresh.dart';
import 'package:flutter_allroundrefresh_example/net/bean/simple_bean.dart';
import 'package:flutter_allroundrefresh_example/net/dao/simple_dao.dart';
import 'package:flutter/material.dart';


class SimpleMyPage1 extends StatefulWidget {
  @override
  _SimpleMyPage1State createState() => _SimpleMyPage1State();
}

class _SimpleMyPage1State extends State<SimpleMyPage1> with TickerProviderStateMixin {
  var page = 1;

  List<SimpleDataBean> modelList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('初始转圈+下拉刷新+无数据（点击重试）'),
      ),
      body: AFutureWidget(
        childWidget: yourContentWidget(),
        fRefresh: SimpleDao.getData0(page: 1),
        onRefreshCallback: () {page = 1;modelList.clear();setState(() {});},
        tokenInvalidCallback: () {print('这里是 token失效的回调处理 通常为弹出对话框，点击确定,关闭前置页，打开登录页');},
        dataCallback: (List<dynamic> data) {
          data.forEach((v) {
            modelList.add(new SimpleDataBean.fromJson(v));
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

