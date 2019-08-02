import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pro/pages/demo/chart/page_line_1.dart';
import 'package:flutter_pro/pages/demo/chart/page_line_2.dart';

class LineChartPage extends StatefulWidget {
  @override
  _LineChartPageState createState() => _LineChartPageState();
}

class _LineChartPageState extends State<LineChartPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffffffff),
      child: ListView(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 36.0,
                top: 24,
              ),
              child: Text(
                "Line Chart",
                style: TextStyle(
                    color: Color(
                      0xff6f6f97,
                    ),
                    fontSize: 32,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 28,
              right: 28,
            ),
            child: LineChartPage1(),
          ),
          SizedBox(
            height: 22,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 28.0, right: 28),
            child: LineChartPage2(),
          ),
        ],
      ),
    );
  }
}
