import 'package:flutter/material.dart';
import 'package:flutter_allroundrefresh_example/pages/my/simple_page1.dart';
import 'package:flutter_allroundrefresh_example/pages/my/simple_page2.dart';
import 'package:flutter_allroundrefresh_example/pages/my/simple_page3.dart';

class TabBarHomePage extends StatefulWidget {
  const TabBarHomePage({Key key,})
      : super(key: key);


  @override
  State<StatefulWidget> createState() {
    return new TabBarHomePageState();
  }
}

class TabBarHomePageState extends State<TabBarHomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  String HasBeenApproved;
  String NotApproved;

  List<Tab> myTabs = [];

  void initTabs() {
    myTabs.clear();
    myTabs.add(Tab(text: '福利 '),);
    myTabs.add(Tab(text: '新闻'),);
    myTabs.add(Tab(text: '政要'),);
  }

  @override
  void initState() {
    initTabs();
    _tabController = new TabController(
      vsync: this,
      length: 3,
      initialIndex: 1,
    );


    super.initState();
  }


  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('发现'),
      ),
      body: DefaultTabController(
        length: myTabs.length,
        child: new Column(children: <Widget>[
          new Material(
            color: Theme
                .of(context)
                .primaryColor,
            child: SizedBox(
              height: 48.0,
              width: double.infinity,
              child: new TabBar(
                controller: _tabController,
                tabs: myTabs, //使用Tab类型的数组呈现Tab标签
                indicatorColor: Colors.white,
                isScrollable: false,
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                new SimpleMyPage1(),
                new SimpleMyPage2(),
                new SimpleMyPage3(),
              ],
            ),
          ),
        ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

}