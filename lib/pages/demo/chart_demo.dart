import 'package:flutter/material.dart';
import 'package:flutter_pro/widget/chart/chart_pie.dart';
import 'package:flutter_pro/widget/chart/pie_data.dart';
import 'dart:ui';

class ChartPieDemo extends StatefulWidget {

  ChartPieDemo();

  _ChartPieDemoState createState() => _ChartPieDemoState();
}

class _ChartPieDemoState extends State<ChartPieDemo> {

  //数据源 下标  表示当前是PieData哪个对象
  int subscript = 0;
  //数据源
  List<PieData> mData;
  //传递值
  PieData pieData;
  //当前选中
  var currentSelect = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPieData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chart'),
      ),
      body: Container(
        width: 500,
        height: 500,
        child: _buildHeader(),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: Color(0xfff4f4f4),
      width: 300,
      height: 300,
      child: Card(
        margin: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                new IconButton(
                  icon: new Icon(Icons.arrow_left),
                  color: Colors.green[500],
                  onPressed: _left,
                ),
              ],
            ),

            new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                new Container(
                  width: 90.0,
                  height: 90.0,
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: new PieChart(mData, pieData, currentSelect),
                ),
              ],
            ),

            new Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                new IconButton(
                  icon: new Icon(Icons.arrow_right),
                  color: Colors.green[500],
                  onPressed: _changeData,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  //点击按钮时  改变显示的内容
  void _left() {
    setState(() {
      if (subscript > 0) {
        --subscript;
        --currentSelect;
      }
      pieData = mData[subscript];
    });
  }

  //改变饼状图
  void _changeData() {
    setState(() {

      if (subscript < mData.length) {
        ++subscript;
        ++currentSelect;
      }
      pieData = mData[subscript];
    });
  }

  void initPieData() {
    mData = new List();
    PieData p1 = new PieData();
    p1.name = 'A';
    p1.price = 'a';
    p1.percentage = 0.39;
    p1.color = Color(0xffff3333);

    pieData = p1;
    mData.add(p1);

    PieData p2 = new PieData();
    p2.name = 'B';
    p2.price = 'b';
    p2.percentage = 0.11;
    p2.color = Color(0xffccccff);
    mData.add(p2);

    PieData p3 = new PieData();
    p3.name = 'C';
    p3.price = 'c';
    p3.percentage = 0.20;
    p3.color = Color(0xffCD00CD);
    mData.add(p3);

    PieData p4 = new PieData();
    p4.name = 'D';
    p4.price = 'd';
    p4.percentage = 0.30;
    p4.color = Color(0xffD9D9D9);
    mData.add(p4);

  }
}