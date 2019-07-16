import 'package:flutter_allroundrefresh/future_refresh.dart';
import 'package:flutter_allroundrefresh_example/my/my_error/my_error1.dart';
import 'package:flutter_allroundrefresh_example/my/my_error/my_error2.dart';
import 'package:flutter_allroundrefresh_example/my/my_pro/my_proqress_view1.dart';
import 'package:flutter_allroundrefresh_example/my/my_pro/my_proqress_view2.dart';
import 'package:flutter_allroundrefresh_example/net/bean/simple_bean.dart';
import 'package:flutter_allroundrefresh_example/net/dao/simple_dao.dart';
import 'package:flutter/material.dart';


class SimplePage7 extends StatefulWidget {
  @override
  _SimplePage7State createState() => _SimplePage7State();
}

class _SimplePage7State extends State<SimplePage7>
    with TickerProviderStateMixin {
  var page = 1;


  List<SimpleDataBean> modelList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('AFutureWidget 组件DEMO'),
        ),
        body: Column(
          children: <Widget>[

            GestureDetector(
              onTap: () {
                _surprise(false);
              },
              child: Container(
                height: 50.0,
                margin: EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 0.0,),
                decoration: BoxDecoration(
                  color: Theme
                      .of(context)
                      .primaryColor,
                  border: new Border.all(width: 0.5, color: Colors.black45),
                  borderRadius: new BorderRadius.all(new Radius.circular(35.0)),
                ),
                child: Container(
                  alignment: Alignment.center,
                  height: 40.0,
                  //登录
                  child: Text('点击获取数据'),),
              ),
            ),
            Expanded(
              child: AFutureWidget(
                childWidget: yourContentWidget(),
                errorWidget: YourError1Widget(),
                progressWidget: YourProgress1Widget(),

                fRefresh: _surprise(true),
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
                otherCallback: (helper) {
                  this.helper = helper;
                },
              ),
            ),
          ],
        )
    );
  }

  AFutureWidgetHelper helper;


  _surprise(up) async {
    print('执行了_surprise1 ');
    Future<dynamic> data10 = null;

    if (!up) {
      data10 = SimpleDao.getData4(page: 1);
      if (helper != null) {
        helper.manualRefresh(data10);
      } else {
        print('执行了_surprise1  helper=null ');
      }
    } else {
      data10 = SimpleDao.getData10(page: 1);
    }
    return data10;
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

