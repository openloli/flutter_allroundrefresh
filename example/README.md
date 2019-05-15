# flutter_allroundrefresh_example

Demonstrates how to use the flutter_allroundrefresh plugin.

## Getting Started

1:

```flutter
...
AllRoundRefresher(
        resultStatus: resultStatus,
        enablePullDown: true,
        enablePullUp: true,
        controller: _controller,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: "your child widget",
        errCallback: () {
		...
        },
      ),
...
```
t2:

```
import 'package:flutter_allroundrefresh/flutter_allroundrefresh.dart';
...
RefreshController _refreshController;
var resultStatus = ResultStatus.init;
		...
	    body: AllRoundRefresher(
        resultStatus: resultStatus,
        enablePullDown: true,
        enablePullUp: true,
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: "your child"
        errCallback: () {
			...
        },
      ),
      ...
 @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  void initState() {
	...
    _refreshController = new RefreshController(); 
    //init get data
    super.initState();
  }

  void _onRefresh() {
   //Refresh data
  }


  void _onLoading() {
  	//load more
  }


  _surprise(up) async {
	...
    ARefreshWidgetHelper.refresh(
        refreshController: _refreshController,
        response: "current page acquisition method",
        callbackNormal: (json) {
       	...
       	//refresh condition processing, load more processing
        },
        callbackError: (msg) {
          ...
       	//refresh data exception handling, load more exception handling
        }
    );
  }
```

