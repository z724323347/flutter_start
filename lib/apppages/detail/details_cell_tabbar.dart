import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../provide/details_info_provide.dart';


class DetailsTabBarCell extends StatelessWidget {
  DetailsTabBarCell();

  @override
  Widget build(BuildContext context) {
    return Provide<DetailsInfoProvide>(
      builder: (context, child, val) {
        var isLeft  = Provide.value<DetailsInfoProvide>(context).isLeft;
        var isRight  = Provide.value<DetailsInfoProvide>(context).isRight;

        return Container(
          margin: EdgeInsets.only(top: 15.0),
          child: Row(
            children: <Widget>[
              _buildTabBarLeft(context,isLeft),
              _buildTabBarRight(context,isRight)
            ],
          ),
        );
      } ,
    );
  }

  Widget _buildTabBarLeft(BuildContext context, bool isLeft) {
    return InkWell(
      onTap: () {
        Provide.value<DetailsInfoProvide>(context).changeTabBar('left');
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(375),
        
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 1.0,
              color: isLeft ? Colors.pink : Colors.black12,
            )
          )
        ),
        child: Text(
          '详情',
          style:TextStyle(
            color: isLeft ? Colors.pink : Colors.black,
          )
        ),
      ),
    );
  }

  Widget _buildTabBarRight(BuildContext context, bool isRight) {
    return InkWell(
      onTap: () {
        Provide.value<DetailsInfoProvide>(context).changeTabBar('right');
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(375),
        
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 1.0,
              color: isRight ? Colors.pink : Colors.black12,
            )
          )
        ),
        child: Text(
          '评论',
          style:TextStyle(
            color: isRight ? Colors.pink : Colors.black,
          )
        ),
      ),
    );
  }

}