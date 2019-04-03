import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'pie_data.dart';
import 'dart:math';


//自定义饼状图表📈

class PieChart extends StatelessWidget {
  //数据源
  List<PieData> datas;
  //当前数据对象
  PieData data;
  var dataSize;
  //当前选中
  var currentSelect;
  PieChart(this.datas,this.data,this.currentSelect);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: PieChartView(datas, data, currentSelect,true),
    );
  }
}

class PieChartView extends CustomPainter {
  //中间文字
  var text='center text';
  bool isChange=false;
  //当前选中的扇形
  var currentSelect=0;

  double animValue;
  Paint _mPaint;
  Paint textPaint;
  int mWidth, mHeight;
  num mRadius, mInnerRadius,mBigRadius;
  num mStartAngle = 0;
  Rect mOval,mBigOval;
  List<PieData> mData;
  PieData pieData;

  var startAngles=[];

  PieChartView(this.mData,this.pieData,this.currentSelect,this.isChange);

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    _mPaint = new Paint();
    textPaint = new Paint();
    mWidth = 100;
    mHeight = 100;

    // 生成纵轴的文字的TextPaniter
    TextPainter textPainter = new TextPainter(
      textDirection: TextDirection.ltr,
      maxLines: 1
    );

    TextPainter _newVerticalAxisTextPainter(String text) {
      return textPainter
          ..text = TextSpan(
            text: text,
            style: TextStyle(
              color: Colors.black,
              fontSize: 10.0
            )
          );
    }


    //正常半径
    mRadius = 50.0;
    //加大半径  用来绘制被选中的扇形区域
    mBigRadius = 51.0;
    //內园半径
    mInnerRadius = mRadius * 0.8;
    // 未选中的扇形绘制的矩形区域
    mOval = Rect.fromLTRB(-mRadius, -mRadius, mRadius, mRadius);
    // 选中的扇形绘制的矩形区域
    mBigOval = Rect.fromLTRB(-mBigRadius, -mBigRadius, mBigRadius, mBigRadius);
    //当没有数据时 直接返回
    if (mData.length == null || mData.length <= 0) {
      return;
    }

    //绘制
    canvas.save();
    //将坐标移动到view的中心
    canvas.translate(mRadius, mRadius);
    // 1. 画扇形
    num startAngle = 0.0;
    for (var i = 0; i < mData.length; i++) {
      PieData p = mData[i];
      double radian = p.percentage;
      //计算当前偏移量（单位:radian）
      double sweepAngle = 2*pi*radian;
      //画笔颜色
      _mPaint..color = p.color;
      if(currentSelect >= 0 && i == currentSelect) {
        //如果当前为所选中的扇形， 则将其半径加大 并突出显示
        canvas.drawArc(mBigOval, startAngle, sweepAngle, true, _mPaint);
      } else {
        //绘制没被选中的扇形， 正常半径
        canvas.drawArc(mOval, startAngle, sweepAngle, true, _mPaint);
      }
      //计算每次开始绘制的弧度
      startAngle += sweepAngle;
    }
    
    //2.画内园
    _mPaint..color = Colors.white;
    canvas.drawCircle(Offset.zero, mInnerRadius, _mPaint);

    canvas.restore();

    //当前百分百
    double percentage = pieData.percentage * 100;
    //绘制文字内容
    var texts = '${percentage}%';
    var tp = _newVerticalAxisTextPainter(texts)..layout();

    //Text的绘制起始点 = 可用宽度 - 文字宽度 - 左边距
    var textLeft = 35.0;
    tp.paint(canvas, Offset(textLeft, 50.0 - tp.height / 2));

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}