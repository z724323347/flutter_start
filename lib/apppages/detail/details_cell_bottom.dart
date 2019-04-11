import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../provide/cart_goodslist_provide.dart';
import '../../provide/details_info_provide.dart';
import '../../util/toast.dart';

class DetailsBottomCell extends StatelessWidget {
  DetailsBottomCell();

  @override
  Widget build(BuildContext context) {

    var goodsInfo = Provide.value<DetailsInfoProvide>(context).goodsInfo.data.goodInfo;
    var goodsId = goodsInfo.goodsId;
    var goodsName = goodsInfo.goodsName;
    var count = 1;
    var price = goodsInfo.presentPrice;
    var image = goodsInfo.image1;
    
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
            onTap: () async {
              Toast.showCenter('add cart');
              await Provide.value<CartGoodListProvide>(context).save(goodsId, goodsName, count, price, image);
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
            onTap: () async {
              Toast.showCenter(' soon');
              await Provide.value<CartGoodListProvide>(context).remove();
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