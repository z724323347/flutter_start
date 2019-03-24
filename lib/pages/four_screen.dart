import 'package:flutter/material.dart';
import 'package:http/http.dart' as client;
import 'package:flutter/services.dart';


import './tabs/tab_one.dart';
import './tabs/tab_two.dart';
import './tabs/tab_three.dart';

class FourScreen extends StatefulWidget {
  _FourScreenState createState() => _FourScreenState();
}

class _FourScreenState extends State<FourScreen> with SingleTickerProviderStateMixin,AutomaticKeepAliveClientMixin{

  TabController _tabController; //需要定义一个Controller
  List tabs = ["新闻", "历史", "图片"];

  void initState() { 
    super.initState();
    // 创建Controller  
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TabBar(
          controller: _tabController,
            tabs: tabs.map((e) => Tab(text: e)).toList()),
        ),
      // body: Test(),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          TabViewOnePage(),
          TabViewTwoPage(),
          TabViewThreePage()
        ],
        // children: tabs.map((e) { //模拟创建3个Tab页
        //   return Container(
        //     alignment: Alignment.center,
        //     child: Text(e, textScaleFactor: 2),
        //   );
        // }).toList(),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

