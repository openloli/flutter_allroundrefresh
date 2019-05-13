/*
    Author: Jpeng
    Email: peng8350@gmail.com
    createTime:2018-05-01 11:39
 */

import 'package:flutter/material.dart'
    hide RefreshIndicator, RefreshIndicatorState;
import 'package:flutter_allroundrefresh/src/internals/indicator_wrap.dart';
import 'package:flutter_allroundrefresh/src/proview/proqress_view.dart';
import 'internals/default_constants.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import 'indicator/classic_indicator.dart';
import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_allroundrefresh/flutter_allroundrefresh.dart';

enum RefreshStatus { idle, canRefresh, refreshing, completed, failed }

enum LoadStatus { idle, loading, noMore }

enum RefreshStyle { Follow, UnFollow, Behind }
enum ResultStatus { init, nomel, error, noMore, retry }

/*
    This is the most important component that provides drop-down refresh and up loading.
 */
class AllRoundRefresher extends StatefulWidget {
  //indicate your listView
  final ScrollView child;

  final RefreshIndicator header;
  final LoadIndicator footer;

  // This bool will affect whether or not to have the function of drop-up load.
  final bool enablePullUp;

  //This bool will affect whether or not to have the function of drop-down refresh.
  final bool enablePullDown;

  //This bool will 快速返回顶部，，后期在写注释
  final bool enableQuickTop; //
  // This bool will 转圈，，后期在写注释
  final Widget progress; //
  final Widget error; //


  // if open OverScroll if you use RefreshIndicator and LoadFooter
  final bool enableOverScroll;

  // upper and downer callback when you drag out of the distance
  final Function onRefresh, onLoading;

  // This method will callback when the indicator changes from edge to edge.
  final OnOffsetChange onOffsetChange;

  //controll inner state
  final RefreshController controller;

  // When SmartRefresher is wrapped in some ScrollView,if true:it will find the primaryScrollController in parent widget
  final bool isNestWrapped;
  var resultStatus;
  Function errCallback;

  AllRoundRefresher({Key key,
    @required this.child,
    @required this.controller,
    RefreshIndicator header,
    LoadIndicator footer,
    this.enableOverScroll: default_true,
    this.enablePullDown: default_true,
    this.enablePullUp: default_false,
    this.enableQuickTop: default_true,
    this.progress,
    this.error,
    this.onRefresh,
    this.onLoading,
    this.resultStatus,
    this.errCallback,
    this.onOffsetChange,
    this.isNestWrapped: false})
      : assert(child != null),
        assert(controller != null),
        this.header = header ?? ClassicHeader(),
        this.footer = footer ?? ClassicFooter(),
        super(key: key);

  @override
  AllRoundRefresherState createState() => AllRoundRefresherState();

  static AllRoundRefresherState of(BuildContext context) {
    return context
        ?.ancestorStateOfType(const TypeMatcher<AllRoundRefresherState>());
  }
}

class AllRoundRefresherState extends State<AllRoundRefresher> {
  // listen the listen offset or on...
  ScrollController scrollController;

  // check the header own height
  ValueNotifier<bool> hasHeaderLayout = ValueNotifier(false);
  bool isShowFloat = false;

  @override
  void dispose() {
    // TODO: implement dispose
    if (!widget.isNestWrapped && widget.child.controller == null) {
      scrollController.dispose();
    }
    hasHeaderLayout.dispose();
    hasHeaderLayout = null;
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    if (!widget.isNestWrapped) {
      scrollController = widget.child.controller ?? ScrollController();
      widget.controller.scrollController = scrollController;
    }
    widget.controller._header = widget.header;
    if (widget.enableQuickTop) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.controller.scrollController.addListener(() {
          int offset = widget.controller.scrollController.offset.toInt();
//        print('offset = ${offset}');
          if (offset < 480 && isShowFloat) {
            isShowFloat = false;
            setState(() {});
          } else if (offset > 480 && !isShowFloat) {
            isShowFloat = true;
            setState(() {});
          }
        });
      });
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    // there is no method to get PrimaryScrollController in initState
    if (widget.isNestWrapped) {
      scrollController = PrimaryScrollController.of(context);
      widget.controller.scrollController = scrollController;
    }

    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(AllRoundRefresher oldWidget) {
    // TODO: implement didUpdateWidget
    if (widget.enablePullDown != oldWidget.enablePullDown) {
      widget.controller.headerMode.value = RefreshStatus.idle;
      hasHeaderLayout.value = false;
      print('11111');
    }
    if (widget.enablePullUp != oldWidget.enablePullUp) {
      widget.controller.footerMode.value = LoadStatus.idle;
      print('2222');
    }
    if (!widget.isNestWrapped && widget.child.controller != null) {
      scrollController = widget.child.controller;
      print('333');
      isShowProView = true;
      setState(() {});
    }

    if (widget.isNestWrapped) {
      scrollController = PrimaryScrollController.of(context);
      print('444');
    }
    widget.controller.scrollController = scrollController;
    widget.controller._header = widget.header;
    super.didUpdateWidget(oldWidget);
  }

  bool isShowProView = false;

  @override
  Widget build(BuildContext context) {
    List<Widget> slivers =
    List.from(widget.child.buildSlivers(context), growable: true);

    if (widget.enablePullDown) {
      slivers.insert(0, widget.header);
      print('55555');
    }
    if (widget.enablePullUp) {
      slivers.add(widget.footer);
      print('66666');
    }


//    if(widget.size!=0){
//      isShowProView=true;
//          print('7777 if ${widget.size}');
//      setState(() {});
//    }else{
//      print('7777 else ${widget.resultStatus}');
//    }
    print('7777 resultStatus ${widget.resultStatus}');

    return new Scaffold(
      body: Stack(
        children: <Widget>[
          CustomScrollView(
            physics: RefreshScrollPhysics(
                enableOverScroll: widget.enableOverScroll),
            controller: scrollController,
            cacheExtent: widget.child.cacheExtent,
            key: widget.child.key,
            center: widget.child.center,
            anchor: widget.child.anchor,
            semanticChildCount: widget.child.semanticChildCount,
            slivers: slivers,
            reverse: widget.child.reverse,
          ),
          new Offstage(
            offstage: widget.resultStatus == ResultStatus.init ? false : true,
            child: new Container(
              alignment: Alignment.center,
              color: Colors.white70,
              child: ProgressView(),
            ),
          ),
          new Offstage(
            offstage: widget.resultStatus == ResultStatus.init ? false : true,
            child: new Container(
              alignment: Alignment.center,
              color: Colors.white70,
              child: widget.progress == null ? ProgressView() : widget
                  .progress,
            ),
          ),
          new Offstage(
            offstage: widget.resultStatus == ResultStatus.error ? false : true,
            child: new Container(
              alignment: Alignment.center,
              color: Colors.white70,
              child: GestureDetector(
                onTap: () {
                  print('onTap  0000');
                  widget.errCallback();
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    widget.controller.requestRefresh();
                  });
                },
                child: widget.error == null ?
                Text('暂无数据') :
                widget.error,
              ),
            ),
          )
        ],
      ),
      floatingActionButton: buildFloatingActionButton(),
    );
  }

  Widget buildFloatingActionButton() {
    return isShowFloat ? FloatingActionButton(
        backgroundColor: Theme
            .of(context)
            .primaryColor,
        child: Icon(
          Icons.keyboard_arrow_up,
        ),
        onPressed: () {
          scrollTop();
        }) : Container();
  }

  void scrollTop() {
    widget.controller.scrollController.animateTo(0.0,
        duration: new Duration(microseconds: 1000), curve: ElasticInCurve());
  }
}

class RefreshController {
  ValueNotifier<RefreshStatus> headerMode = ValueNotifier(RefreshStatus.idle);
  ValueNotifier<LoadStatus> footerMode = ValueNotifier(LoadStatus.idle);
  ScrollController scrollController;
  RefreshIndicator _header;

  void requestRefresh({bool needDownAnimate: true,
    Duration duration: const Duration(milliseconds: 400),
    Curve curve: Curves.linear}) {
    assert(scrollController != null,
    'Try not to call requestRefresh() before build,please call after the ui was rendered');
    if (headerStatus == RefreshStatus.idle)
      scrollController.animateTo(-_header.triggerDistance,
          duration: duration, curve: curve);
  }

  void requestLoading({Duration duration: const Duration(milliseconds: 200),
    Curve curve: Curves.linear}) {
    assert(scrollController != null,
    'Try not to call requestLoading() before build,please call after the ui was rendered');
    if (footerStatus == LoadStatus.idle) {
      scrollController.animateTo(scrollController.position.maxScrollExtent,
          duration: duration, curve: curve);
    }
  }

  void refreshCompleted() {
    headerMode?.value = RefreshStatus.completed;
  }

  void refreshFailed() {
    headerMode?.value = RefreshStatus.failed;
  }

  void loadComplete() {
    // change state after ui update,else it will have a bug:twice loading
    SchedulerBinding.instance.addPostFrameCallback((_) {
      footerMode?.value = LoadStatus.idle;
    });
  }

  void loadNoData() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      footerMode?.value = LoadStatus.noMore;
    });
  }

  void dispose() {
    headerMode.dispose();
    footerMode.dispose();
    headerMode = null;
    footerMode = null;
  }

  RefreshStatus get headerStatus => headerMode?.value;

  LoadStatus get footerStatus => footerMode?.value;

  bool get isRefresh => headerMode?.value == RefreshStatus.refreshing;

  bool get isLoading => footerMode?.value == LoadStatus.loading;
}
