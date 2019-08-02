import 'package:flutter/material.dart';
import 'package:flutter_pro/pages/demo/chart/page_bar_1.dart';
import 'package:flutter_pro/pages/demo/chart/page_line.dart';
import 'package:flutter_pro/pages/demo/chart/page_pie.dart';

class BaseChartPage extends StatefulWidget {
  @override
  _BaseChartPageState createState() => _BaseChartPageState();
}

class _BaseChartPageState extends State<BaseChartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back),
        ),
        title: Text('BaseChartPage'),
        centerTitle: true,
      ),
      body: PageView(
        children: <Widget>[
          LineChartPage(),
          BarChartPage1(),
          PieChartPage(),
        ],
      ),
    );
  }
}
