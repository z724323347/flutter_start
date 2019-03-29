import 'package:flutter/material.dart';

import 'package:http/http.dart' as client;
import 'package:flutter/services.dart';

import 'package:flutter_pro/util/toast.dart';
import 'package:flutter_pro/model/test_model.dart';
import 'package:flutter_pro/util/dbhelper.dart';
import 'package:flutter_pro/pages/custom_route.dart';
import 'package:flutter_pro/pages/netease/netease_page.dart';

class TabViewFourPage extends StatefulWidget {

  _TabViewFourPageState createState() => _TabViewFourPageState();
}

class _TabViewFourPageState extends State<TabViewFourPage> with SingleTickerProviderStateMixin{

  Animation<double> _doubleAnimation;
  AnimationController _controller;
  CurvedAnimation curvedAnimation;


  //sqlite 
  List notes = [];
  int i = 0;
  
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
    
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            
            //自定义圆形进度条
            Container(
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
            
            RaisedButton(
              child: Text('打开 播放界面!'),
              onPressed: (){
                  Navigator.of(context).push(
                    CustomRoute(MusicPlayerExample())
                  );
              },
            ),

            //sqlite
            ButtonBar(
              children: <Widget>[
                RaisedButton(
                  onPressed: _insertData,
                  child: Text('存储数据'),
                ),
                RaisedButton(
                  onPressed: getNotes,
                  child: Text('点一次取2条数据'),
                ),
              ],
            ),
            ListView.builder(
              itemBuilder: _itemBuilder,
              shrinkWrap: true,
              itemCount: notes.length,
            )

          ],
        ),
      )
  
    );
  }

  void _insertData() async {
    var db = DatabaseHelper();
    TestModel todo = new TestModel(i, 'imarge', i, i, 0.1 * i, 0.1 * i);
    i++;
    await db.saveNote(todo);

    getNotes();
  }

  void getNotes() async {
    var db = DatabaseHelper();
    var res = await db.getAllNotes(limit: 2, offset: notes.length);
    setState(() {
      notes.addAll(res);
    });
  }

  Widget _itemBuilder(BuildContext context, int index) {
    return Text('${notes[index]}');
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