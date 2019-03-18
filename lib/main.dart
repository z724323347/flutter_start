import 'package:flutter/material.dart';
import 'apppages/index_page.dart';

import 'package:provide/provide.dart';

import './provide/counter.dart';
import 'package:flutter_pro/pages/navbottombar.dart';

void main() {

  var counter = Counter();
  var providers =Providers();

  providers
  ..provide(Provider<Counter>.value(counter));
  //provide 多个状态的管理， .. 函数添加其它状态 exp.
  // ..provide(Provider<Other>.value(other));


  // runApp(MyApp());
  runApp(ProviderNode(child:MyApp(), providers:providers));
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(

        title: "Material",
        // 去掉右上角debug 图标 ， 默认 true显示
        debugShowCheckedModeBanner: false,

        theme: ThemeData(
          primarySwatch: Colors.lightBlue
        ),

        // 测试入口   定义底部导航栏
        home: NavbottomBar(),
        //项目入口
        // home: IndexPage(),
      ),
    );
  }
}