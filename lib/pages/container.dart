import 'package:flutter/material.dart';

class TestContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Container'),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: 30.0, left: 50.0), //容器外补白
          constraints: BoxConstraints.tightFor(width: 200.0, height: 150.0), //卡片大小,
          decoration: BoxDecoration(
            gradient: RadialGradient( //背景径向渐变
              colors: [Colors.red, Colors.orange],
              center: Alignment.topLeft,
              radius: .8
            ),
            boxShadow: [ //卡片阴影
              BoxShadow(
                color: Colors.black45,
                offset: Offset(2.0, 2.0),
                blurRadius: 4.0
              )
              
            ]
          ),
          transform: Matrix4.rotationZ(.2), //卡片倾斜变换
          alignment: Alignment.center, //卡片内文字居中
          child: Text(//卡片文字
          '5.20 ￥',style:TextStyle(color: Colors.white, fontSize: 40.0)
          ),
        ),
      ),

    );
  }
}