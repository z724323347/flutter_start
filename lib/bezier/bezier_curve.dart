import 'package:flutter/material.dart';
import 'package:flutter_pro/bezier/curve_clipper.dart';
import 'package:flutter_pro/bezier/wave_clipper.dart';

class BezierCurve extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            ClipPath(
              clipper: CurveClipper(), //弧形剪切
              // clipper: WaveClipper(), //波浪剪切
            ),
          ],
        ),

      ),
    );
  }
}