import 'package:flutter/material.dart';

import 'package:http/http.dart' as client;
import 'package:flutter/services.dart';

import 'package:flutter_pro/util/toast.dart';

class TabViewFourPage extends StatefulWidget {

  _TabViewFourPageState createState() => _TabViewFourPageState();
}

class _TabViewFourPageState extends State<TabViewFourPage> with SingleTickerProviderStateMixin{

  Animation<double> _doubleAnimation;
  AnimationController _controller;
  CurvedAnimation curvedAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 2));
    curvedAnimation = CurvedAnimation(parent: _controller, curve: Curves.decelerate);
    _doubleAnimation = Tween(begin: 0.0, end: 360.0).animate(_controller);

    _controller.addListener(() {
      this.setState(() {});
    });
    onAnimationStart();
  }

  void onAnimationStart() {
    _controller.forward(from: 0.0);
  }
  
  @override
  void reassemble(){
    super.reassemble();
    onAnimationStart();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return Center(
      child: Container(
        width: 200.0,
        height: 200.0,
        margin: EdgeInsets.all(8.0),
        child: CustomPaint(
          child: Center(
            child: Text((_doubleAnimation.value /3.6).round().toString()),
          ),
          painter: CircleProgressBarPainter(_doubleAnimation.value),
        ),
      ),
    );
  }

  

}

class CircleProgressBarPainter extends CustomPainter{
  Paint _paintBackground;
  Paint _paintFore;
  final double pi = 3.1415926;
  var progress;

  CircleProgressBarPainter(this.progress) {
     _paintBackground = Paint()  
      ..color = Colors.blueGrey
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.0
      ..isAntiAlias = true;
    _paintFore = Paint()
      ..color = Colors.blue
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12.0
      ..isAntiAlias = true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
     canvas.drawCircle(Offset(size.width / 2, size.height / 2), size.width / 2,
        _paintBackground);
    Rect rect = Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: size.width / 2,
    );
    canvas.drawArc(rect, 0.0, progress * 3.14 / 180, false, _paintFore);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
  
}