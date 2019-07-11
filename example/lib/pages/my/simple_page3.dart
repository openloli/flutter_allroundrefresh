import 'package:flutter_allroundrefresh/future_refresh.dart';
import 'package:flutter_allroundrefresh_example/my/my_error/my_error1.dart';
import 'package:flutter_allroundrefresh_example/my/my_pro/my_proqress_view2.dart';
import 'package:flutter_allroundrefresh_example/net/bean/simple_bean.dart';
import 'package:flutter_allroundrefresh_example/net/dao/simple_dao.dart';
import 'package:flutter/material.dart';

class SimplePage3 extends StatefulWidget {
  @override
  _SimplePage3State createState() => _SimplePage3State();
}

class _SimplePage3State extends State<SimplePage3>
    with TickerProviderStateMixin {
  var page = 1;

  List<SimpleDataBean> modelList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AFutureWidget 组件DEMO'),),
      body: AFutureWidget(
        enablePullDown: true,
        //下啦刷新开关，
        childWidget: yourContentWidget(),
        errorWidget: YourError1Widget(),
        progressWidget: YourProgress2Widget(),
        fRefresh: SimpleDao.getData10(page: 1),
        fLoading: SimpleDao.getData10(page: page),
        onLoadingCallback: () {page = page + 1;setState(() {});},
        onRefreshCallback: () {page = 1;modelList.clear();setState(() {});
        },
        tokenInvalidCallback: () {print('这里是 token失效的回调处理 通常为弹出对话框，点击确定,关闭前置页，打开登录页');
        },
        dataCallback: (List<dynamic> data) {
          data.forEach((v) {
            modelList.add(new SimpleDataBean.fromJson(v));
          });
          setState(() {});
        },
      ),
    );
  }


  Widget childItemWidget(index) {
    return Card(
      margin: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0,),
      child: Row(
        children: <Widget>[
          Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: Image.network(
                  modelList[index].imageUrl, fit: BoxFit.cover,
                ),
              )
          ),
          Expanded(
            flex: 7,
            child: Container(
              alignment: Alignment.center,
              child: Text('${modelList[index].name}-${modelList[index].petName}',style: TextStyle(fontSize: 18.0),),)
            ,
          ),
        ],
      ),
    );
  }

  Widget yourContentWidget() {
    return ListView.builder(
      itemCount: modelList.length,
      itemBuilder: (BuildContext context, int index) {
        return childItemWidget(index);
      },
    );
  }
}

