import 'package:flutter/material.dart';
import 'apppages/index_page.dart';


import 'package:flutter_pro/pages/navbottombar.dart';

void main() => runApp(
  new MaterialApp(
    title: "Material",

    // 去掉右上角debug 图标 ， 默认 true显示
    debugShowCheckedModeBanner: false,

    theme: ThemeData(
      primarySwatch: Colors.lightBlue
    ),

    // 测试入口   定义底部导航栏
    // home: NavbottomBar(),
    

    //项目入口
    home: IndexPage(),
  )
);