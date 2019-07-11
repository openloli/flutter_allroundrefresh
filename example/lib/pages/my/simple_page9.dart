import 'package:flutter_allroundrefresh/future_refresh.dart';
import 'package:flutter_allroundrefresh_example/my/my_error/my_error1.dart';
import 'package:flutter_allroundrefresh_example/my/my_pro/my_proqress_view2.dart';
import 'package:flutter_allroundrefresh_example/net/bean/simple_bean.dart';
import 'package:flutter_allroundrefresh_example/net/dao/simple_dao.dart';
import 'package:flutter/material.dart';


class SimplePage9 extends StatefulWidget {
  @override
  _SimplePage9State createState() => _SimplePage9State();
}

class _SimplePage9State extends State<SimplePage9>
    with TickerProviderStateMixin {
  var page = 1;

//  List<CourseListData> modelList = [];
  List<SimpleDataBean> modelList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('百度来的十大书籍'),
      ),
      body: Column(
        children: <Widget>[
          headWidget(),
          Expanded(
              child:
              Container(
                child: contentWidget(),
              )
          ),
        ],
      ),
    );
  }


  Widget headWidget() {
    return Container(
      alignment: Alignment.center,
      height: 120.0,
      width: MediaQuery
          .of(context)
          .size
          .width,
      margin: EdgeInsets.all(4.0),
      color: Colors.blue,
      child: Text('HEAD WIDGET'), 
    );
  }

  Widget contentWidget() {
    return AFutureWidget(
      childWidget: yourContentWidget(),
      errorWidget: YourError1Widget(),
      progressWidget: YourProgress2Widget(),
      fRefresh: SimpleDao.getData10(page: 1),
      fLoading: SimpleDao.getData10(page: 1),
      onLoadingCallback: () {
        page = page + 1;
        setState(() {});
      },
      onRefreshCallback: () {
        page = 1;
        modelList.clear();
        setState(() {});
      },
      tokenInvalidCallback: () {
        print('这里是 token失效的回调处理 通常为弹出对话框，点击确定,关闭前置页，打开登录页');
      },
      dataCallback: (List<dynamic> data) {
        data.forEach((v) {
          modelList.add(new SimpleDataBean.fromJson(v));
        });
        setState(() {});
      },
    );
  }

  Widget yourContentWidget() {
    return ListView.builder(
      itemCount: modelList.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          width: MediaQuery
              .of(context)
              .size
              .width,
          alignment: Alignment.center,
          margin: EdgeInsets.fromLTRB(4.0,2.0,4.0,2.0),
          height: 70.0,
          color: index % 2 == 0 ? Colors.blue.withOpacity(0.6) : Colors.green.withOpacity(0.6),
          child: Text('${modelList[index].name}'),
        );
      },
    );
  }
}

