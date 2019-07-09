Language ：[中文简体](<https://github.com/android-pf/flutter_allroundrefresh/blob/master/README.md> )| [English](<https://github.com/android-pf/flutter_allroundrefresh/blob/master/README_EN.md> )

# flutter_allroundrefresh

### Set Initial lap + network normal / abnormal + data normal / abnormal + retry + login invalid + pull-down refresh + load more versatile components.


### Add dependency

```flutter
dependencies:
  flutter_allroundrefresh: ^2.0.0
```

## Use

1、Initialization Method, Internationalization Configuration (Part), Status Code Configuration

```flutter
AFutureWidget.init( );
```

2、Import

```flutter
import 'package:flutter_allroundrefresh/future_refresh.dart';
```

3、Use

```flutter
...
body: AFutureWidget(
        childWidget: yourContentWidget(),
        errorWidget: YourError2Widget(),
        progressWidget: YourProgress2Widget(),
        fRefresh: MainDao.getCourseList(page: 1,),
        fLoading: MainDao.getCourseList(page: page,),
        onLoadingCallback: () {page = page + 1;setState(() {});},
        onRefreshCallback: () {page = 1;modelList.clear();setState(() {});},
        tokenInvalidCallback: () {
        //Callback processing for token failure is usually a pop-up dialog box, //click OK, close the front page, and open the login page.
        },
        dataCallback: (List<dynamic> data) {
          data.forEach((v) {
            modelList.add(new CourseListData.fromJson(v));
          });
          setState(() {});
        },
      ),
...
```

#### Explain

##### AFutureWidgetComponents (highlighted as mandatory)

| field                 | describe1       | describe2                                                    |
| --------------------- | --------------- | ------------------------------------------------------------ |
| enablePullDown        | true            | Not to fill in                                               |
| ==childWidget==       | ScrollView类型  | page item                                                    |
| errorWidget           | error page      | Customizable, pictures, GIF can be                           |
| progressWidget        | Initial loading | Customizable                                                 |
| ==fRefresh==          | Future<dynamic> | Refresh new method, method return type must be consistent    |
| fLoading              | Future<dynamic> | Load more methods, no fill = no load more                    |
| onLoadingCallback     |                 | Load more callbacks and fill in when loading more            |
| ==onRefreshCallback== |                 | New Method of Refreshing                                     |
| tokenInvalidCallback  |                 | Login failure handling callback, depending on the project to see if it is necessary |
| ==dataCallback==      |                 | Data Processing Callback                                     |
| header                |                 | Data Processing Callback                                     |
| footer                |                 | Load more                                                    |

###### Focus on: fRefresh corresponds to a web page acquisition method. The return type of the method is ==Future < dynamic >==. Meanwhile, the data format returned by the method must be in the following format:

```flutter
{
    "code": "Default 200 Access Successful, 900 Logon Failure",
    "msg": "",
    "data": {},//  "data": [],
}
```



##### AFutureWidget.init( );   Initialization Method, Internationalization Configuration Method and State Code Configuration Method

Initialization methods must be turned on

The following texts are currently available and supported for international configuration and status code configuration:

| field            | Default                                      |
| ---------------- | -------------------------------------------- |
| loadingText      | 加载中...                                    |
| noDataText       | 没有更多数据了                               |
| idleText         | 加载更多                                     |
| failedText       | 加载失败，点击重试                           |
| errorMsg         | 暂无数据                                     |
| normalCode       | 200                                          |
| tokenInvalidCode | 900                                          |
| netClose         | 检测到手机没有网络，请打开网络后重试！       |
| netWifiLose      | 网络差或服务器超时，请稍后重试或使用4G尝试！ |
| netLoseOrTimeOut | 网络差或服务器超时，请稍后重试!              |

1、If there is no internationalized configuration in the project, you only need to use AFutureWidget. init () once.

2、Internationalization requires configuration in AFutureWidget.init (loadingText: xxx...); configuration (except normalCode, tokenInvalidCode)

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
