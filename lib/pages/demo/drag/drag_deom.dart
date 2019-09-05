import 'package:flutter/material.dart';
import 'package:flutter_pro/pages/demo/drag/drag_pull.dart';

class DragDeom extends StatefulWidget {
  @override
  _DragDeomState createState() => _DragDeomState();
}

class _DragDeomState extends State<DragDeom> {
  Color _draggableColor = Colors.grey;
  Offset _offset = Offset(80, 80);
  Color yellowColor = Colors.yellowAccent;
   
  double dx = 0.0;
  double dy = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DragDeom'),
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.grey[300],
        child: Stack(
          children: <Widget>[
            // Positioned(
            //   left: 0,
            //   right: 0,
            //   bottom: 10,
            //   child: Container(
            //     color: Colors.white,
            //     width: 300,
            //     height: 600,
            //     child: PullDragWidget(
            //       dragHeight: 400,
            //       parallaxRatio: 0.1,
            //       thresholdRatio: 0.1,
            //       header: _createHeader(),
            //       child: _createContent(),
            //     ),
            //   ),
            // ),

            Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                      dy = 300;
                    });
                  },

                  onVerticalDragUpdate: (_d){
                    // print('_d.delta.dx  ------- ${_d.delta.dx}');
                    print('_d.delta.dy  ------- ${_d.delta.dy}');
                    setState(() {
                      dy = -_d.delta.dy;
                    });
                  },
                  onHorizontalDragUpdate: (_d){
                    print('_d.delta.dx  ------- ${_d.delta.dx}');
                    // print('_d.delta.dy  ------- ${_d.delta.dy}');
                    dx = _d.delta.dx;
                  },
                  child: Container(
                      width: 50.0 + dx,
                      height: (80.0 + dy) >= 300 ? 300 : 80.0 + dy,
                      color: Colors.red[400],
                    ),
                  // child: Draggable(
                  //   data: yellowColor,
                  //   child: Container(
                  //     width: 50.0,
                  //     height: (50.0 + _offset.dy) >= 300 ? 300 : 50.0 + _offset.dy,
                  //     color: yellowColor,
                  //   ),
                  //   feedback: Container(
                  //     width:MediaQuery.of(context).size.width,
                  //     height: (50.0 + _offset.dy) >= 400 ? 400 : 50.0 + _offset.dy,
                  //     color: yellowColor.withOpacity(0.5),
                  //   ),
                  //   onDraggableCanceled: (velocity, offset) {
                  //     print("_offset ---->${_offset}");
                  //     setState(() {
                  //       this._offset = offset;
                  //     });
                  //   },
                  // ),
                )),
          ],
        ),
      ),
    );
  }

  Widget _createHeader() {
    return Container(
      height: MediaQuery.of(context).size.height / 10,
      child: Text('_createHeader'),
    );
  }

  Widget _createContent() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      color: Colors.red,
    );
  }
}
