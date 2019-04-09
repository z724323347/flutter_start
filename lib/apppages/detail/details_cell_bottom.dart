import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../provide/details_info_provide.dart';
import '../../util/toast.dart';

class DetailsBottomCell extends StatelessWidget {
  DetailsBottomCell();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(72),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: (){
              Toast.showCenter('cart');
            },
            child: Container(
              width: ScreenUtil().setWidth(150),
              alignment: Alignment.center,
              child: Icon(
                Icons.shopping_cart,
                size: 40,
                color: Colors.red,
                ),
            ),
          ),

          InkWell(
            onTap: (){
              Toast.showCenter('add cart');
            },
            child: Container(
              width: ScreenUtil().setWidth(300),
              height: ScreenUtil().setHeight(72),
              alignment: Alignment.center,
              color: Colors.green,
              child: Text(
                '加入购物车',
                style: TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(24)),
                ),
            ),
          ),

          InkWell(
            onTap: (){
              Toast.showCenter(' soon');
            },
            child: Container(
              width: ScreenUtil().setWidth(300),
              height: ScreenUtil().setHeight(72),
              alignment: Alignment.center,
              color: Colors.red,
              child: Text(
                '立即购买',
                style: TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(24)),
                ),
            ),
          ),
        ],
      ),
    );
  }
}