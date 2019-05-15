文档语言：[中文简体](<https://github.com/android-pf/flutter_allroundrefresh/blob/master/README.md> )| [English](<https://github.com/android-pf/flutter_allroundrefresh/blob/master/README_EN.md> )

# flutter_allroundrefresh

### 基于  [pull_to_refresh](<https://pub.flutter-io.cn/packages/pull_to_refresh> ) 在原有下拉刷新、上拉加载更多的基础上实现了初始转圈、数据异常、网络异常、重试以及网络封装、数据中间件的从进入页面到退出页面的全功能组件。

## 下载APK体验

## 添加依赖

```flutter
dependencies:
  flutter_allroundrefresh: ^1.0.0
```

## 使用

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
        header: WaterDropHeader(),
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
    _animController.dispose();
    _refreshController.dispose();
    super.dispose();
  }

  @override
  void initState() {
	...
    _refreshController = new RefreshController(); 
    //第一次(初始)获取网络数据
    
    super.initState();
  }

  void _onRefresh() {
   //刷新数据
  }


  void _onLoading() {
  	//加载更多
  }


  _surprise(up) async {
	...
    ARefreshWidgetHelper.refresh(
        refreshController: _refreshController,
        response: "当前页面获取数据的方法",
        callbackNormal: (json) {
       	...
       	//刷新情况处理、加载更多处理
        },
        callbackError: (msg) {
          ...
       	//刷新数据异常处理、加载更多异常处理
        }
    );
  }
```

常见list页面复制以上代码后，只需要编写 item 即可



## 属性说明

AllRoundRefresher:

| 属性名         | 说明             | 默认          | 必要性 |
| -------------- | ---------------- | ------------- | :----: |
| resultStatus   | 结果状态器       | null          |  必要  |
| controller     | 状态控制器       | null          |  必要  |
| child          | 内部组件         | null          |  必要  |
| onRefresh      | 刷新数据         | null          |  必要  |
| onLoading      | 加载更多         | null          |  必要  |
| header         | 刷新头           | ClassicHeader |  可选  |
| footer         | 底部加载         | ClassicFooter |  可选  |
| enablePullDown | 下拉开关         | true          |  可选  |
| enablePullUp   | 加载更多开关     | false         |  可选  |
| progress       | 自定义初始加载   | ProgressView  |  可选  |
| error          | 自定义错误页面   | Container     |  可选  |
| enableQuickTop | 快速返回顶部开关 | true          |  可选  |

ARefreshWidgetHelper:

| 属性名            | 说明                   | 必要性 |
| ----------------- | ---------------------- | :----: |
| refreshController | 状态控制器             |  必要  |
| response          | 获取数据的方法的结果集 |  必要  |
| callbackNormal    | 正常数据回调           |  必要  |
| callbackError     | 非正常数据回调         |  必要  |



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