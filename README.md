文档语言：[中文简体](<https://github.com/android-pf/flutter_allroundrefresh/blob/master/README.md> )| [English](<https://github.com/android-pf/flutter_allroundrefresh/blob/master/README_EN.md> )

# flutter_allroundrefresh

### 基于  [pull_to_refresh](<https://pub.flutter-io.cn/packages/pull_to_refresh> ) 在原有下拉刷新、上拉加载更多的基础上实现了初始转圈、数据异常、网络异常、重试以及网络封装、数据中间件的从进入页面到退出页面的全功能组件。



## 添加依赖

```flutter
dependencies:
  flutter_allroundrefresh: ^2.0.0
```

## 使用

1、初始化方法、国际化配置（部分）、状态码配置

```flutter
AFutureWidget.init( );
```

2、引入

```flutter
import 'package:flutter_allroundrefresh/future_refresh.dart';
```

3、使用

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
        //token失效的回调处理 通常为弹出对话框，点击确定,关闭前置页，打开登录页
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

#### 说明

##### AFutureWidget组件（高亮为必填）

| 字段                  | 默认值/返回类型 | 说明                                 |
| --------------------- | --------------- | ------------------------------------ |
| enablePullDown        | true            | 可不填                               |
| ==childWidget==       | ScrollView类型  | 页面item                             |
| errorWidget           | 初始错误页      | 可自定义，图片、gif均可              |
| progressWidget        | 初始转圈        | 可自定义                             |
| ==fRefresh==          | Future<dynamic> | 刷新方法，方法返回类型必须保持一致   |
| fLoading              | Future<dynamic> | 加载更多方法，不填=无加载更多        |
| onLoadingCallback     |                 | 加载更多回调，加载更多时必填         |
| ==onRefreshCallback== |                 | 刷新方法                             |
| tokenInvalidCallback  |                 | 登录失效处理回调，根据项目看是否需要 |
| ==dataCallback==      |                 | 数据处理回调                         |
| header                |                 | 刷新头                               |
| footer                |                 | 加载更多                             |

###### 重点说明：fRefresh 对应是的某个页面的网络获取方法，方法的返回类型为==Future<dynamic>==，同时，方法返回的数据格式必须是以下格式：

```flutter
{
    "code": "默认200访问成功，900登录失效",
    "msg": "",
    "data": {},//  "data": [],
}
```



##### AFutureWidget.init( );   初始化方法、国际化配置方法、状态码配置方法 

必须开启初始化方法

国际化配置、状态码配置 目前出现及支持的文案如下：

| 字段             | 默认                                         |
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

1、如果项目中没有国际化配置，则只需要条用一次AFutureWidget.init( ); 即可，

2、国际化则需要配置在AFutureWidget.init(loadingText:xxx... ); 进行配置（normalCode、tokenInvalidCode除外）







# 其他

### QQ群：10788108。

## 开源协议

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



### 鸣谢

pull_to_refresh