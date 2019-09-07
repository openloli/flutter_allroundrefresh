文档语言：[中文简体](<https://github.com/android-pf/flutter_allroundrefresh/blob/master/README.md> )| [English](<https://github.com/android-pf/flutter_allroundrefresh/blob/master/README_EN.md> )

# flutter_allroundrefresh

**集 初始转圈+网络正常/异常+下拉刷新+加载更多+数据正常/异常+重试+登录失效 的组件。**

## 快速使用

1. **添加依赖 ** 

   ```dart
   dependencies:
     flutter_allroundrefresh: ^2.0.3
   ```

2. 引用

   ```dart
   import 'package:flutter_allroundrefresh/future_refresh.dart';
   ```

3. 在入口方法中进行初始化

   1. 默认初始化

      ```dart
      AFutureWidget.init( );
      ```

   2. 需要配置国际化、或需要改变文字内容

      ```dart
      AFutureWidget.init(  loadingText: '加载中...',...);
      ```

4. 具体页面

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
           childWidget: yourContentWidget(),//必填
           //errorWidget: YourError1Widget(),//支持自定义
           //progressWidget: YourProgress2Widget(),//支持自定义
           fRefresh: SimpleDao.getData10(page: 1),//必填，page 必须写1
           fLoading: SimpleDao.getData10(page: page),//有加载更多必填
           onLoadingCallback: () {page = page + 1;setState(() {});},//有加载更多必填
           onRefreshCallback: () {page = 1;modelList.clear();setState(() {}); },//必填
           tokenInvalidCallback: () { },,//登录失效回调
           dataCallback: (List<dynamic> data) {
             data.forEach((v) {
               modelList.add(new SimpleDataBean.fromJson(v));
             });
             setState(() {});
           },//必填
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

   >**为了达到一目了然的效果，上面贴上了整个页面的代码，不难发现**
   >
   >- 该页面只需要配置flutter_allroundrefresh 下的具体组件AFutureWidget 即可
   >
   >- 具体页面的ListView/GridView 的代码，即Item样式编写
   >
   >  

   

   

   >**注意事项**
   >
   >- 获取接口API数据的方法，即**fRefresh**的参数（方法），这里需要注意，无论是get/post/put/delete请求，具体**方法的返回值**必须是**Future<dynamic>**，详情参考demo
   >
   >- errorWidget: YourError1Widget(),//支持**自定义错误页面**，demo/截图展示了默认纯文字、静态图、和动图三种效果
   >
   >- progressWidget: YourProgress2Widget(),//支持**自定义初始转圈**，demo/截图展示了默认转圈、动图两种效果
   >
   >- tokenInvalidCallback： **登录失效**的回调方法，根据项目决定是否需要（作者的项目是弹出对话框，点击确定进入登录页面）
   >
   >- 接口API返回的json建议使用 [json_to_dart](https://javiercbk.github.io/json_to_dart/) 进行格式化
   >
   >  

   

5. 接口API返回的**json格式**说明（**若你的后台有自己的code规则**则需要在初始化方法AFutureWidget.init();中进行适配）

```json
{
    "code": "默认200访问成功，404无数据，900登录失效",
    "msg": "",
    "data": {},//  "data": [],
}
```



>**完成到这里，接入 flutter_allroundrefresh 组件的优势也就很清晰了**
>
>- 编写/测试接口API数据获取的方法（作者使用了java中的dao概念，木有使用bloc）
>
>- 编写具体页面的Item
>
>- 那么整体项目就包含：载框架搭建+dao层+UI层,不管是个人开发，还是团队开发，项目就很清晰了，分工与工作量就都很好分配了（非列表页面即将适配哈，以及返回页面刷新的问题）
>
>  



**说明**

AFutureWidget组件

| 字段                 | 默认值/返回类型 | 是否必须 | 说明                                 |
| -------------------- | --------------- | -------- | ------------------------------------ |
| enablePullDown       | true            | 非       | 可自定义                             |
| childWidget          | ScrollView类型  | 必须     | 页面item                             |
| errorWidget          | 初始错误页      | 非       | 可自定义，图片、gif均可              |
| progressWidget       | 初始转圈        | 非       | 可自定义                             |
| fRefresh             | Future<dynamic> | 必须     | 刷新方法，方法返回类型必须保持一致   |
| fLoading             | Future<dynamic> | 非       | 加载更多方法，不填=无加载更多        |
| onLoadingCallback    |                 | 非       | 加载更多回调，加载更多时必填         |
| onRefreshCallback    |                 | 必须     | 刷新方法                             |
| tokenInvalidCallback |                 | 非       | 登录失效处理回调，根据项目看是否需要 |
| dataCallback         |                 | 必须     | 数据处理回调                         |
| header               |                 | 非       | 刷新头                               |
| footer               |                 | 非       | 加载更多                             |



**涉及到的国际化配置、状态码配置**

| 字段             | 默认                                         |
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



## 截图

![](https://github.com/android-pf/flutter_allroundrefresh/blob/master/example/assets/screenShots/loading_more.gif)               ![](https://github.com/android-pf/flutter_allroundrefresh/blob/master/example/assets/screenShots/all.gif)

![](https://github.com/android-pf/flutter_allroundrefresh/blob/master/example/assets/screenShots/bottomBar.gif)               ![](https://github.com/android-pf/flutter_allroundrefresh/blob/master/example/assets/screenShots/def.gif)

![](https://github.com/android-pf/flutter_allroundrefresh/blob/master/example/assets/screenShots/error1.gif)               ![](https://github.com/android-pf/flutter_allroundrefresh/blob/master/example/assets/screenShots/error2.gif)

![](https://github.com/android-pf/flutter_allroundrefresh/blob/master/example/assets/screenShots/head1.gif)               ![](https://github.com/android-pf/flutter_allroundrefresh/blob/master/example/assets/screenShots/head2.gif)![](https://github.com/android-pf/flutter_allroundrefresh/blob/master/example/assets/screenShots/no_data.gif)

![](https://github.com/android-pf/flutter_allroundrefresh/blob/master/example/assets/screenShots/relogin.gif)               ![](https://github.com/android-pf/flutter_allroundrefresh/blob/master/example/assets/screenShots/tabbar.gif)



## DEMO使用说明

[由于使用的是mocky模拟接口 我打包的正式包是无法获取数据的，也就是大家荡下来以后example跑起来也可能是没有数据的，具体跑起来点击这里](https://github.com/android-pf/flutter_allroundrefresh/blob/master/example/README.md)



## 常见问题

- type 'String' is not a subtype of type 'Map<String, dynamic>'

- [demo 跑起来可能是没有数据](https://github.com/android-pf/flutter_allroundrefresh/blob/master/example/README.md)

  

## 其他

**下载链接**（由于demo中的接口API使用了  [mocky](https://www.pgyer.com/X4Bi ) 进行模拟所以，apk跑起来可能是没有数据的）

[android apk](https://www.pgyer.com/X4Bi )

**下载二维码**

![](https://www.pgyer.com/app/qrcode/X4Bi)



### 有任何问题、建议、意见 ，欢迎到 [github提issues](https://github.com/android-pf/flutter_allroundrefresh/issues)
### 或者加入QQ群：10788108

**鸣谢**

[pull_to_refresh](https://pub.flutter-io.cn/packages/pull_to_refresh )

[GSYGithubAppFlutter](https://github.com/CarGuo/GSYGithubAppFlutter )

[领航未来](http://wzk.36ve.com/index.php/home/index )



**开源协议**

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









