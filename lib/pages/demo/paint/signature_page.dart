import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_pro/pages/demo/paint/signature_painter.dart';
import 'package:flutter_pro/util/image_util.dart';

class SignaturePage extends StatefulWidget {
  @override
  _SignaturePageState createState() => _SignaturePageState();
}

class _SignaturePageState extends State<SignaturePage> {
  List<Offset> _points = <Offset>[];
  GlobalKey previewContainer = GlobalKey();
  bool _first = true;
  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: previewContainer,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              color: Colors.blue[200],
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 20),
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios),
                  ),
                  OutlineButton(
                    onPressed: () {
                      setState(() {
                        _first = !_first;
                      });
                      ImageUtil().saveImageBase64(previewContainer);
                    },
                    child: Text('Save'),
                  )
                ],
              ),
            ),
            GestureDetector(
              //手势探测器，一个特殊的widget，想要给一个widge添加手势，直接用这货包裹起来
              onPanUpdate: (DragUpdateDetails details) {
                //按下
                RenderBox referenceBox = context.findRenderObject();
                Offset localPosition =
                    referenceBox.globalToLocal(details.globalPosition);
                setState(() {
                  _points = new List.from(_points)..add(localPosition);
                  // _points.add(localPosition);
                });
              },
              onPanEnd: (DragEndDetails details) => _points.add(null), //抬起来
            ),
            CustomPaint(painter: new SignaturePainter(_points)),
            Positioned(
                bottom: 160,
                child: BackdropFilter(
                  filter:
                      new ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
                  child: new Container(
                    color: Colors.blue.withOpacity(0.1),
                    padding: const EdgeInsets.all(30.0),
                    width: 90.0,
                    height: 90.0,
                    child: new Center(
                      child: _first ? new Text('Test') : null,
                    ),
                  ),
                )),
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: AnimatedCrossFade(
                  duration: Duration(seconds: 2),
                  firstChild: FlutterLogo(
                      style: FlutterLogoStyle.horizontal, size: 100.0),
                  secondChild:
                      FlutterLogo(style: FlutterLogoStyle.stacked, size: 100.0),
                  crossFadeState: _first
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond),
            )
          ],
        ),
      ),
    );
  }
}
