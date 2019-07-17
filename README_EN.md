Language ：[中文简体](<https://github.com/android-pf/flutter_allroundrefresh/blob/master/README.md> )| [English](<https://github.com/android-pf/flutter_allroundrefresh/blob/master/README_EN.md> )

# flutter_allroundrefresh

**Set Initial lap + network normal / abnormal + pull-down refresh + load more + data normal / abnormal + retry + login failed component.**
### Quick use

1. **Adding dependencies**

   ```dart
   dependencies:
     flutter_allroundrefresh: ^2.0.2
   ```

2. **Import**

   ```dart
   import 'package:flutter_allroundrefresh/future_refresh.dart';
   ```

3. **Initialization in the entry method**

   1. **Default initialization**

      ```dart
      AFutureWidget.init( );
      ```

   2. **Need to configure internationalization, or need to change text content**

      ```dart
      AFutureWidget.init(  loadingText: '加载中...',...);
      ```

4. **Specific pages**

   ```dart
   class SimplePage3 extends StatefulWidget {
     @override
     _SimplePage3State createState() => _SimplePage3State();}
   
   class _SimplePage3State extends State<SimplePage3> with TickerProviderStateMixin {
     var page = 1;
     List<SimpleDataBean> modelList = [];
     @override
     Widget build(BuildContext context) {
       return Scaffold(
         appBar: AppBar( title: const Text('AFutureWidget 组件DEMO'),),
         body: AFutureWidget(
           childWidget: yourContentWidget(),//Required
           //errorWidget: YourError1Widget(),//Support customization
           //progressWidget: YourProgress2Widget(),//Support customization
           fRefresh: SimpleDao.getData10(page: 1),//Required，Page must be written 1
           fLoading: SimpleDao.getData10(page: page),//Load more required
           onLoadingCallback: () {page = page + 1;setState(() {});},//Load more required
           onRefreshCallback: () {page = 1;modelList.clear();setState(() {}); },//Required
           tokenInvalidCallback: () { },,//Login invalid callback
           dataCallback: (List<dynamic> data) {
             data.forEach((v) {
               modelList.add(new SimpleDataBean.fromJson(v));
             });
             setState(() {});
           },//Required
         ),
       );
     }
    Widget yourContentWidget() {
       return ListView.builder(
         itemCount: modelList.length,
         itemBuilder: (BuildContext context, int index) {
           return Container(
             alignment: Alignment.center,
             height: 80.0,
             child: Text('${modelList[index].name}'),
           ); },);
     }
   }
   
   ```

   >**In order to achieve a clear effect, it is not difficult to find the whole page code pasted on it**
   >
   >- This page only needs to configure the specific component AFutureWidget under flutter_allroundrefresh
   >- The code of the ListView/GridView of the specific page, that is, the Item style is written
   >  

   

   >**Precautions**
   >
   >- The method of obtaining interface API data, that is, the parameter (method) of fRefresh, it should be noted here that whether it is a get/post/put/delete request, the return value of the specific method must be Future<dynamic>, refer to the demo for details.
   >
   >- errorWidget: YourError1Widget(), / / support custom error page, demo / screenshot shows the default pure text, static map, and animation three effects
   >
   >- progressWidget: YourProgress2Widget (), / / support custom initial circle, demo / screenshot shows the default circle, moving two effects
   >
   >- tokenInvalidCallback: Login invalid callback method, according to the project to decide whether it is needed (the author's project is a pop-up dialog box, click OK to enter the login page)
   >
   >- The json returned by the interface API is recommended to be formatted using  [json_to_dart](https://javiercbk.github.io/json_to_dart/) 
   >
   >
   >  

5. The json format description returned by the interface API (if your background has its own code rules, you need to adapt it in the initialization method AFutureWidget.init();)

   ```
   {
       "code": " 200 access is successful, 404 has no data, 900 login is invalid.",
       "msg": "",
       "data": {},//  "data": [],
   }
   ```

   >**Once you're done here, the benefits of accessing the flutter_allroundrefresh component are clear**
   >
   >- Write / test the interface API data acquisition method (the author uses the dao concept in java, there is no use of bloc)
   >
   >- Write an item for a specific page
   >
   >- Then the overall project includes: the framework build + dao layer + UI layer, whether it is personal development, or team development, the project is very clear, the division of labor and workload are well allocated (non-list page is about to adapt, And return page refresh issues)
   >
   >  




**Description**

**AFutureWidget Components**

| field                 | describe1       | describe2                                                    |
| --------------------- | --------------- | ------------------------------------------------------------ |
| enablePullDown        | true            | Not to fill in                                               |
| ==childWidget==       | ScrollView      | page item                                                    |
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



**International configuration, status code configuration involved**

| field            | Default                                      |
| ---------------- | -------------------------------------------- |
| loadingText      | 加载中...                                    |
| noDataText       | 没有更多数据了                               |
| idleText         | 加载更多                                     |
| failedText       | 加载失败，点击重试                           |
| errorMsg         | 暂无数据                                     |
| normalCode       | 200                                          |
| noDataCode       | 404                                          |
| tokenInvalidCode | 900                                          |
| netClose         | 检测到手机没有网络，请打开网络后重试！       |
| netWifiLose      | 网络差或服务器超时，请稍后重试或使用4G尝试！ |
| netLoseOrTimeOut | 网络差或服务器超时，请稍后重试!              |



## Screenshot

![](https://github.com/android-pf/flutter_allroundrefresh/blob/master/example/assets/screenShots/loading_more.gif)               ![](https://github.com/android-pf/flutter_allroundrefresh/blob/master/example/assets/screenShots/all.gif)

![](https://github.com/android-pf/flutter_allroundrefresh/blob/master/example/assets/screenShots/bottomBar.gif)               ![](https://github.com/android-pf/flutter_allroundrefresh/blob/master/example/assets/screenShots/def.gif)

![](https://github.com/android-pf/flutter_allroundrefresh/blob/master/example/assets/screenShots/error1.gif)               ![](https://github.com/android-pf/flutter_allroundrefresh/blob/master/example/assets/screenShots/error2.gif)

![](https://github.com/android-pf/flutter_allroundrefresh/blob/master/example/assets/screenShots/head1.gif)               ![](https://github.com/android-pf/flutter_allroundrefresh/blob/master/example/assets/screenShots/head2.gif)![](https://github.com/android-pf/flutter_allroundrefresh/blob/master/example/assets/screenShots/no_data.gif)

![](https://github.com/android-pf/flutter_allroundrefresh/blob/master/example/assets/screenShots/relogin.gif)               ![](https://github.com/android-pf/flutter_allroundrefresh/blob/master/example/assets/screenShots/tabbar.gif)



## DEMO Instructions for use

[Because I am using the mocky analog interface, I can't get the data in the official package packaged. That is, after you sway down, the example may run without data. Click here to run](https://github.com/android-pf/flutter_allroundrefresh/blob/master/example/README.md)



## common problem

- type 'String' is not a subtype of type 'Map<String, dynamic>'

- [The demo may run without data](https://github.com/android-pf/flutter_allroundrefresh/blob/master/example/README.md)

  

## other

**Download link **（since the interface API in demo uses   [mocky](https://www.pgyer.com/X4Bi )   for simulation, apk may run without data)

[android apk](https://www.pgyer.com/X4Bi )

**Download QR code**

![](https://www.pgyer.com/app/qrcode/X4Bi)



### Have any questions, suggestions, comments, welcome to  [github to mention issues](https://github.com/android-pf/flutter_allroundrefresh/issues)

### Or join the QQ group: 10788108

## Thanks

[pull_to_refresh](https://pub.flutter-io.cn/packages/pull_to_refresh )

[GSYGithubAppFlutter](https://github.com/CarGuo/GSYGithubAppFlutter )

[领航未来](http://wzk.36ve.com/index.php/home/index )



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
