import 'package:flutter/material.dart';
import 'package:flutter_allroundrefresh_example/pages/my/simple_page1.dart';
import 'package:flutter_allroundrefresh_example/pages/my/simple_page2.dart';
import 'package:flutter_allroundrefresh_example/pages/my/simple_page3.dart';


class BottomBarHomePage extends StatefulWidget {
  @override
  _BottomBarHomePageState createState() => _BottomBarHomePageState();
}

class _BottomBarHomePageState extends State<BottomBarHomePage>
    with SingleTickerProviderStateMixin {

  TabController _tabController;

  void _onBottomNavigationBarTap(int index) {
    setState(() {
      _tabController.index = index;
    });
  }


  @override
  void initState() {
    super.initState();
    _tabController = new TabController(
      vsync: this,
      length: 3,
      initialIndex: 0, //控制默认显示第几页
    );
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[SimplePage1(), SimplePage3(),SimplePage2() ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tabController.index,
        type: BottomNavigationBarType.fixed,
        fixedColor: Theme
            .of(context)
            .primaryColor,
        onTap: _onBottomNavigationBarTap,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              title: Text('首页')),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.golf_course,
              ),
              title: Text('发现')),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              title: Text('我的')),
        ],
      ),
    );
  }
}
