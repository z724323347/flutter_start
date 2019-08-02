import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartPage1 extends StatefulWidget {
  @override
  _LineChartPage1State createState() => _LineChartPage1State();
}

class _LineChartPage1State extends State<LineChartPage1> {
  StreamController<LineTouchResponse> controller;

  @override
  void initState() {
    super.initState();
    controller = StreamController();
    controller.stream.distinct().listen((LineTouchResponse response) {
      /// do whatever you want and change any property of the chart.
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Color> gradientColors = [
      Color(0xff23b6e6),
      Color(0xff02d39a),
    ];
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      child: AspectRatio(
        aspectRatio: 1.5,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(18)),
              color: Color(0xff232d37)),
          child: Padding(
            padding: const EdgeInsets.only(
                right: 18.0, left: 12.0, top: 24, bottom: 12),
            child: FlChart(
              chart: LineChart(LineChartData(
                lineTouchData: LineTouchData(
                    touchTooltipData: TouchTooltipData(
                  tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
                )),
                gridData: FlGridData(
                  show: true,
                  drawVerticalGrid: true,
                  drawHorizontalGrid: true,
                  getDrawingVerticalGridLine: (value) {
                    return const FlLine(
                      color: Color(0xff37434d),
                      strokeWidth: 1,
                    );
                  },
                  getDrawingHorizontalGridLine: (value) {
                    return const FlLine(
                      color: Color(0xff37434d),
                      strokeWidth: 1,
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 22,
                    textStyle: TextStyle(
                        color: const Color(0xff68737d),
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                    getTitles: (value) {
                      switch (value.toInt()) {
                        case 0:
                          return '1月';
                        case 5:
                          return '6月';
                        case 6:
                          return '7月';
                      }

                      return '';
                    },
                    margin: 8,
                  ),
                  leftTitles: SideTitles(
                    showTitles: true,
                    textStyle: TextStyle(
                      color: const Color(0xff67727d),
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                    getTitles: (value) {
                      switch (value.toInt()) {
                        case 1:
                          return '10k';
                        case 2:
                          return '20k';
                        case 3:
                          return '30k';
                        case 4:
                          return '40k';
                        case 5:
                          return '50k';
                      }
                      return '';
                    },
                    reservedSize: 28,
                    margin: 10,
                  ),
                ),
                borderData: FlBorderData(
                    show: true,
                    border: Border.all(color: Color(0xff37434d), width: 1)),
                minX: 0,
                maxX: 12,
                minY: 0,
                maxY: 6,
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      FlSpot(0, 3),
                      FlSpot(2.6, 2),
                      FlSpot(4.9, 5),
                      FlSpot(6.8, 3.1),
                      FlSpot(8, 4),
                      FlSpot(9.5, 3),
                      FlSpot(11, 4),
                      FlSpot(12, 2),
                    ],
                    isCurved: true,
                    colors: gradientColors,
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: FlDotData(
                      show: true,
                    ),
                    preventCurveOverShooting: false,
                    belowBarData: BelowBarData(
                      show: true,
                      colors: gradientColors
                          .map((color) => color.withOpacity(0.3))
                          .toList(),
                    ),
                  ),
                ],
              )),
            ),
          ),
        ),
      ),
    );
  }
}
