import 'package:flutter/material.dart';

class SignaturePainter extends CustomPainter {
  SignaturePainter(this.points);

  final List<Offset> points; // Offset:一个不可变的2D浮点偏移。

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint() //设置笔的属性
      ..color = Colors.blue[800]
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true
      ..strokeWidth = 4.0
      ..strokeJoin = StrokeJoin.bevel;

    for (int i = 0; i < points.length - 1; i++) {
      //画线
      if (points[i] != null && points[i + 1] != null)
        canvas.drawLine(points[i], points[i + 1], paint);
    }
  }

  @override
  bool shouldRepaint(SignaturePainter other) => other.points != points;
  // bool shouldRepaint(SignaturePainter oldDelegate) {
  //   return oldDelegate.points != oldDelegate;
  // }
}
