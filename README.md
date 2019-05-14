# flutter_allroundrefresh

## Intro

A component that provides initial load + drop-down refresh + pull-up load + error page on the basis of  [pull_to_refresh](<https://pub.flutter-io.cn/packages/pull_to_refresh> )framework, while supporting Android and Ios
If you are Chinese,click here([中文文档](<https://github.com/android-pf/flutter_allroundrefresh/blob/master/README_CN.md> ))

## Features
* pull_to_refresh framework all features
* pull up and pull down
* provide initial load and error pages



## Props Table

SmartRefresher:

| Attribute Name     |     Attribute Explain     | Parameter Type | Default Value  | requirement |
|---------|--------------------------|:-----:|:-----:|:-----:|
| controller | controll inner some states  | RefreshController | null | necessary |
| child      | your content View   | ? extends ScrollView   |   null |  necessary |
| header | the header indictor     | RefreshIndicator | ClassicHeader | optional |
| footer | the footer indictor     | LoadIndicator  | ClassicFooter | optional |
| enablePullDown | switch of the pull down      | boolean | true | optional |
| enablePullUp |   switch of the pull up  | boolean | false |optional |
| onRefresh | will callback when the header indicator is getting refreshing   | () => Void | null | optional |
| onLoad | will callback when the footer indicator is getting loading   | () => Void | null | optional |
| onOffsetChange | callback while you dragging and outOfrange  | (bool,double) => Void | null | optional |
| enableOverScroll |  the switch of Overscroll,When you use  RefreshIndicator(Material), you may have to shut down.    | bool | true | optional |
| isNestWrapped | it will set true when SmartRefresher is wrapped by NestedScrollView  | bool | false | optional |





## LICENSE

```
 
MIT License

Copyright (c) 2018 pf

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

 
```
