Language ：[中文简体](<https://github.com/android-pf/flutter_allroundrefresh/blob/master/README.md> )| [English](<https://github.com/android-pf/flutter_allroundrefresh/blob/master/README_EN.md> )

# flutter_allroundrefresh

### Based on pull_to_refresh, the initial pull-around, data exception, network exception, retry, and full-featured components of the network package and data middleware from the entry page to the exit page are implemented based on the original pull-down refresh and pull-up load.



### Add dependency

```flutter
dependencies:
  flutter_allroundrefresh: ^1.0.1
```

## Use

```flutter
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

After copying the above code from the common list page, you only need to write the item.



## Props Table

AllRoundRefresher:

| Attribute Name | Attribute Explain            | Default Value | Requirement |
| -------------- | ---------------------------- | ------------- | :---------: |
| resultStatus   | result stater                | null          |  necessary  |
| controller     | state controller             | null          |  necessary  |
| child          | your widget                  | null          |  necessary  |
| onRefresh      | refresh data                 | null          |  necessary  |
| onLoading      | load more                    | null          |  necessary  |
| header         | refresh header               | ClassicHeader |  optional   |
| footer         | footer loading               | ClassicFooter |  optional   |
| enablePullDown | pull-down switch             | true          |  optional   |
| enablePullUp   | load more switch             | false         | 可optional  |
| progress       | custom initial progress view | ProgressView  |  optional   |
| error          | custom error page            | Container     |  optional   |
| enableQuickTop | quick return to top switch   | true          |  optional   |

ARefreshWidgetHelper:

| Attribute Name    | Attribute Explain                                | Requirement |
| ----------------- | ------------------------------------------------ | :---------: |
| refreshController | state controller                                 |  necessary  |
| response          | the result set of the method of getting the data |  necessary  |
| callbackNormal    | normal data callback                             |  necessary  |
| callbackError     | abnormal data callback                           |  necessary  |



# Other

### QQ Group：10788108。

## LICENSE

```
 
Copyright 2019 pf

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
 
```
