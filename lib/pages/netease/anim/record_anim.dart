import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class RotatrRecord extends AnimatedWidget {

  RotatrRecord({Key key, Animation<double> animation}) :super(key:key, listenable:animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation =listenable;

    // TODO: implement build
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      height: 250.0,
      width: 250.0,
      child: RotationTransition(
        turns: animation,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage(
                'http://hiphotos.qianqian.com/ting/pic/item/4ec2d5628535e5ddf8d5f6b875c6a7efcf1b62df.jpg'
              )
            )
          ),
        ),
      )
      
      
    );
  }
  
}