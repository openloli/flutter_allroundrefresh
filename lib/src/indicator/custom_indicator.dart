import 'package:flutter_allroundrefresh/flutter_allroundrefresh.dart';
import 'package:flutter/material.dart'
    hide RefreshIndicator, RefreshIndicatorState;
import '../internals/default_constants.dart';
import '../internals/indicator_wrap.dart';
import '../all_round_refresher.dart';

class CustomHeader extends RefreshIndicator {
  final HeaderBuilder builder;

  const CustomHeader({
    Key key,
    @required this.builder,
    double height: default_height,
    RefreshStyle refreshStyle: RefreshStyle.Follow,
    double triggerDistance: default_refresh_triggerDistance,
  }) : super(
            key: key,
            triggerDistance: triggerDistance,
            refreshStyle: refreshStyle,
            height: height);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CustomHeaderState();
  }
}

class _CustomHeaderState extends RefreshIndicatorState<CustomHeader> {
  @override
  Widget buildContent(BuildContext context, RefreshStatus mode) {
    // TODO: implement buildContent
    return widget.builder(context, mode);
  }
}

class CustomFooter extends LoadIndicator {
  final FooterBuilder builder;

  const CustomFooter({
    Key key,
    @required this.builder,
    bool autoLoad: true,
    Function onClick,
    double triggerDistance: default_load_triggerDistance,
  }) : super(
            key: key,
            autoLoad: autoLoad,
            triggerDistance: triggerDistance,
            onClick: onClick);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CustomFooterState();
  }
}

class _CustomFooterState extends LoadIndicatorState<CustomFooter> {
  @override
  Widget buildContent(BuildContext context, LoadStatus mode) {
    // TODO: implement buildContent
    return widget.builder(context, mode);
  }
}
