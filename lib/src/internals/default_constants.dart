import 'package:flutter_allroundrefresh/flutter_allroundrefresh.dart';
import 'package:flutter/widgets.dart';
import '../all_round_refresher.dart';


typedef void OnOffsetChange(bool up, double offset);
typedef Widget HeaderBuilder(BuildContext context, RefreshStatus mode);
typedef Widget FooterBuilder(BuildContext context, LoadStatus mode);

const int default_completeDuration = 800;

const double default_refresh_triggerDistance = 100.0;

const double default_load_triggerDistance = 15.0;

const double default_height = 60.0;

const double default_headerExceed = 100.0;

const double default_footerExceed = 100.0;

const int spaceAnimateMill = 300;

const double minSpace = 0.000001;

const RefreshStyle default_refreshStyle = RefreshStyle.Follow;

const bool default_true = true;

const bool default_false = false;
