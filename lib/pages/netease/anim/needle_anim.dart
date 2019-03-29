import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'dart:math';


class PivotTransition extends AnimatedWidget {

  //turns 不能为空
  PivotTransition({
    Key key,
    this.alignment :FractionalOffset.topCenter,
    @required Animation<double> turns,
    this.child,
  }) :super(key:key, listenable:turns);

  Animation<double> get turns => listenable;
  final FractionalOffset alignment;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final double turnsValue =turns.value;
    final Matrix4 transform =new Matrix4.rotationZ(turnsValue * pi * 2.0);

    return Transform(
      transform: transform,
      alignment: alignment,
      child: child,
    );
  }
  
}

class AnimateNeedle extends AnimatedWidget{

  AnimateNeedle({Key key, Animation<double> animation}) : super(key:key, listenable:animation);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final Animation<double> animation = listenable;

    return Container(
      height: 300.0,
      width: 100.0,
      child: PivotTransition(
        turns: animation,
        alignment: FractionalOffset.topCenter,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage('images/play_needle.png')
            )
          ),
        ),
      ),
    );
  }
  
}