[TOCM]

[TOC]



# flutter_allroundrefresh_example

Demonstrates how to use the flutter_allroundrefresh plugin.

## 使用事项

1. 必须使用初始化方法 `AFutureWidget.init();`

2. 获取网络数据的方法返回值必须是 `Future<dynamic>` (其实不全对，后面详细说)

3. 接口API数据格式必须是统一的

   ```json
   {
       "code": "默认200访问成功，900登录失效",
       "msg": "",
       "data": {},//  "data": [],
   }
   ```

4. 如果是直接使用自己的组件，或使用自己的接口API，则无需再看剩下5，6、7

5. fdsfs



**不运行 demo 请跳过该小节（）**

1. 由于demo中的接口API使用了  [mocky](https://www.pgyer.com/X4Bi ) 进行模拟所以，demo跑起来若没有数据：
   1. 需要在demo的 `assets` 下找到对应的`json`文件，并打开 [mocky](https://www.pgyer.com/X4Bi )  参考 demo中的 `SimpleDao` 进行无数据、正常获取数据，等情况的模拟（替换掉demo中的API链接即可）
   2. 注意参考SimpleDao 及 HttpManager 中对数据返回类型

