//import 'package:flutter_allroundrefresh/src/internals/indicator_wrap.dart';
//import 'package:flutter_allroundrefresh/src/proview/proqress_view.dart';
//import 'package:flutter_allroundrefresh/flutter_allroundrefresh.dart';
//import 'package:flutter/material.dart'
//    hide RefreshIndicator, RefreshIndicatorState;
//import 'internals/default_constants.dart';
//import 'indicator/classic_indicator.dart';
//import 'package:flutter/foundation.dart';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/scheduler.dart';
//import 'package:flutter/widgets.dart';
//
//enum RefreshStatus { idle, canRefresh, refreshing, completed, failed }
//
//enum LoadStatus { idle, loading, noMore }
//
//enum RefreshStyle { Follow, UnFollow, Behind }
//enum ResultStatus { init, nomel, error, noMore, retry }
//
///*
//    This is the most important component that provides full functionality.
// */
//class AllRoundRefresher extends StatefulWidget {
//  //indicate your listView
//  final ScrollView child;
//
//  //Refresh header
//  final RefreshIndicator header;
//
//  //Footer loading
//  final LoadIndicator footer;
//
//  //This bool will affect whether or not to have the function of drop-up load.
//  final bool enablePullUp;
//
//  //This bool will affect whether or not to have the function of drop-down refresh.
//  final bool enablePullDown;
//
//  //This bool will affect whether or not to have the function of quickly return to the top.
//  final bool enableQuickTop;
//
//  //This is a custom init loading widget
//  final Widget progress;
//
//  //This is a custom error widget
//  final Widget error;
//
//  //if open OverScroll if you use RefreshIndicator and LoadFooter
//  final bool enableOverScroll;
//
//  //upper and downer callback when you drag out of the distance
//  final Function onRefresh, onLoading;
//
//  //This method will callback when the indicator changes from edge to edge.
//  final OnOffsetChange onOffsetChange;
//
//  //controll inner state
//  final RefreshController controller;
//
//  //When SmartRefresher is wrapped in some ScrollView,if true:it will find the primaryScrollController in parent widget
//  final bool isNestWrapped;
//
//  //Component state manager
//  var resultStatus;
//
//  //Error callback
//  final Function errCallback;
//
//  AllRoundRefresher({Key key,
//    @required this.child,
//    @required this.controller,
//    RefreshIndicator header,
//    LoadIndicator footer,
//    this.enableOverScroll: default_true,
//    this.enablePullDown: default_true,
//    this.enablePullUp: default_false,
//    this.enableQuickTop: default_true,
//    this.progress,
//    this.error,
//    this.onRefresh,
//    this.onLoading,
//    this.resultStatus,
//    this.errCallback,
//    this.onOffsetChange,
//    this.isNestWrapped: false})
//      : assert(child != null),
//        assert(controller != null),
//        this.header = header ?? ClassicHeader(),
//        this.footer = footer ?? ClassicFooter(),
//        super(key: key);
//
//  @override
//  AllRoundRefresherState createState() => AllRoundRefresherState();
//
//  static AllRoundRefresherState of(BuildContext context) {
//    return context?.ancestorStateOfType(const TypeMatcher<AllRoundRefresherState>());
//  }
//}
//
//class AllRoundRefresherState extends State<AllRoundRefresher> {
//  //Listen the listen offset or on...
//  ScrollController scrollController;
//
//  //Check the header own height
//  ValueNotifier<bool> hasHeaderLayout = ValueNotifier(false);
//
//  //Quick return internal keywords
//  bool isShowFloat = false;
//
//  void temp() {
//    Future.delayed(const Duration(milliseconds: 1000)).then((val) {
////      _surprise(false);
//    });
//  }
//
//  @override
//  void dispose() {
//    // TODO: implement dispose
//    if (!widget.isNestWrapped && widget.child.controller == null) {
//      scrollController.dispose();
//    }
//    hasHeaderLayout.dispose();
//    hasHeaderLayout = null;
//
//
//    super.dispose();
//  }
//
//  @override
//  void initState() {
//    // TODO: implement initState
//    if (!widget.isNestWrapped) {
//      scrollController = widget.child.controller ?? ScrollController();
//      widget.controller.scrollController = scrollController;
//    }
//    widget.controller._header = widget.header;
//    if (widget.enableQuickTop) {
//      WidgetsBinding.instance.addPostFrameCallback((_) {
//        widget.controller.scrollController.addListener(() {
//          int offset = widget.controller.scrollController.offset.toInt();
////        print('offset = ${offset}');
//          if (offset < 480 && isShowFloat) {
//            isShowFloat = false;
//            setState(() {});
//          } else if (offset > 480 && !isShowFloat) {
//            isShowFloat = true;
//            setState(() {});
//          }
//        });
//      });
//    }
//    super.initState();
//  }
//
//  @override
//  void didChangeDependencies() {
//    if (widget.isNestWrapped) {
//      scrollController = PrimaryScrollController.of(context);
//      widget.controller.scrollController = scrollController;
//    }
//
//    super.didChangeDependencies();
//  }
//
//  @override
//  void didUpdateWidget(AllRoundRefresher oldWidget) {
//    // TODO: implement didUpdateWidget
//    if (widget.enablePullDown != oldWidget.enablePullDown) {
//      widget.controller.headerMode.value = RefreshStatus.idle;
//      hasHeaderLayout.value = false;
//    }
//    if (widget.enablePullUp != oldWidget.enablePullUp) {
//      widget.controller.footerMode.value = LoadStatus.idle;
//    }
//    if (!widget.isNestWrapped && widget.child.controller != null) {
//      scrollController = widget.child.controller;
//      isShowProView = true;
//      setState(() {});
//    }
//
//    if (widget.isNestWrapped) {
//      scrollController = PrimaryScrollController.of(context);
//    }
//    widget.controller.scrollController = scrollController;
//    widget.controller._header = widget.header;
//    super.didUpdateWidget(oldWidget);
//  }
//
//  bool isShowProView = false;
//
//  @override
//  Widget build(BuildContext context) {
//    List<Widget> slivers =
//    List.from(widget.child.buildSlivers(context), growable: true);
//
//    if (widget.enablePullDown) {
//      slivers.insert(0, widget.header);
//    }
//    if (widget.enablePullUp) {
//      slivers.add(widget.footer);
//    }
//
//    return new Scaffold(
//      body: Stack(
//        children: <Widget>[
//          CustomScrollView(
//            physics: RefreshScrollPhysics(
//                enableOverScroll: widget.enableOverScroll
//            ),
//            controller: scrollController,
//            cacheExtent: widget.child.cacheExtent,
//            key: widget.child.key,
//            center: widget.child.center,
//            anchor: widget.child.anchor,
//            semanticChildCount: widget.child.semanticChildCount,
//            slivers: slivers,
//            reverse: widget.child.reverse,
//          ),
//          //初始转圈
//          new Offstage(
//            offstage: widget.resultStatus == ResultStatus.init ? false : true,
//            child: new Container(
//              alignment: Alignment.center,
//              color: Colors.white70,
//              child: ProgressView(),
//            ),
//          ),
//          //初始转圈扩展，上面的是不是可以去掉了？
//          new Offstage(
//            offstage: widget.resultStatus == ResultStatus.init ? false : true,
//            child: new Container(
//              alignment: Alignment.center,
//              color: Colors.white70,
//              child: widget.progress == null ? ProgressView() : widget.progress,
//            ),
//          ),
//          //错误页面
//          new Offstage(
//            offstage: widget.resultStatus == ResultStatus.error ? false : true,
//            child: new Container(
//              alignment: Alignment.center,
//              color: Colors.white70,
//              child: GestureDetector(
//                onTap: () {
//                  SchedulerBinding.instance.addPostFrameCallback((_) {
//                    widget.controller.requestRefresh();
//                  });
//                  widget.errCallback();
//                },
//                child: widget.error == null ? Text('暂无数据') : widget.error,
//              ),
//            ),
//          )
//        ],
//      ),
//      //快速返回按钮，当数据过长时出现
//      floatingActionButton: buildFloatingActionButton(),
//    );
//  }
//  //快速返回按钮，当数据过长时出现
//  Widget buildFloatingActionButton() {
//    return isShowFloat ? FloatingActionButton(
//        backgroundColor: Theme
//            .of(context)
//            .primaryColor,
//        child: Icon(
//          Icons.keyboard_arrow_up,
//        ),
//        onPressed: () {
//          scrollTop();
//        }) : Container();
//  }
//  //快速返回按钮-返回顶部功能
//  void scrollTop() {
//    widget.controller.scrollController.animateTo(0.0,
//        duration: new Duration(microseconds: 1000), curve: ElasticInCurve());
//  }
//}
//
//class RefreshController {
//  ValueNotifier<RefreshStatus> headerMode = ValueNotifier(RefreshStatus.idle);
//  ValueNotifier<LoadStatus> footerMode = ValueNotifier(LoadStatus.idle);
//  ScrollController scrollController;
//  RefreshIndicator _header;
//
//  void requestRefresh({bool needDownAnimate: true,
//    Duration duration: const Duration(milliseconds: 400),
//    Curve curve: Curves.linear}) {
//    assert(scrollController != null,
//    'Try not to call requestRefresh() before build,please call after the ui was rendered');
//    if (headerStatus == RefreshStatus.idle)
//      scrollController.animateTo(-_header.triggerDistance,
//          duration: duration, curve: curve);
//  }
//
//  void requestLoading({Duration duration: const Duration(milliseconds: 200),
//    Curve curve: Curves.linear}) {
//    assert(scrollController != null,
//    'Try not to call requestLoading() before build,please call after the ui was rendered');
//    if (footerStatus == LoadStatus.idle) {
//      scrollController.animateTo(scrollController.position.maxScrollExtent,
//          duration: duration, curve: curve);
//    }
//  }
//
//  void refreshCompleted() {
//    headerMode?.value = RefreshStatus.completed;
//  }
//
//  void refreshFailed() {
//    headerMode?.value = RefreshStatus.failed;
//  }
//
//  void loadComplete() {
//    // change state after ui update,else it will have a bug:twice loading
//    SchedulerBinding.instance.addPostFrameCallback((_) {
//      footerMode?.value = LoadStatus.idle;
//    });
//  }
//
//  void loadNoData() {
//    SchedulerBinding.instance.addPostFrameCallback((_) {
//      footerMode?.value = LoadStatus.noMore;
//    });
//  }
//
//  void dispose() {
//    headerMode.dispose();
//    footerMode.dispose();
//    headerMode = null;
//    footerMode = null;
//  }
//
//  RefreshStatus get headerStatus => headerMode?.value;
//
//  LoadStatus get footerStatus => footerMode?.value;
//
//  bool get isRefresh => headerMode?.value == RefreshStatus.refreshing;
//
//  bool get isLoading => footerMode?.value == LoadStatus.loading;
//}
