import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';

import '../../provide/cart_goodslist_provide.dart';
import '../../model/cart_goodsinfo_model.dart';
import '../../util/toast.dart';
import '../cart/cart_count.dart';


class CartItem extends StatelessWidget {
  final CartGoodsInfoModel item;

  CartItem(this.item);

  @override
  Widget build(BuildContext context) {
    print(item);
    return Container(
      margin:EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
      padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 1.0, color: Colors.black12)
        )
      ),
      child: Row(
        children: <Widget>[
          _cartCheckBox(),
          _cartImage(),
          _cartGoodsName(context),
          _cartPrice()

        ],
      ),
    );
  }

  //复选框
  Widget _cartCheckBox() {
    return Container(
      child: Checkbox(
        value: true,
        activeColor: Colors.pink,
        onChanged: (bool val){

        },
      ),
    );
  }

  //图片
  Widget _cartImage() {
    return Container(
      width: ScreenUtil().setWidth(150),
      // height: ScreenUtil().setHeight(150),
      padding: EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        border: Border.all(width: 1,color: Colors.black12)
      ),
      child: Image.network(item.images),
    );
  }

  //名称
  Widget _cartGoodsName(context) {
    return Container(
      width: ScreenUtil().setWidth(300),
      padding: EdgeInsets.all(10.0),
      // alignment: Alignment.centerLeft,
      child: Column(
        children: <Widget>[
          Text(
            item.goodsName
          ),
          
          CartCountCell(this.item),
          
        ],
      ),
    );
  }

  //价格
  Widget _cartPrice() {
    return Container(
      width: ScreenUtil().setWidth(150),
      alignment: Alignment.centerRight,
      child: Column(
        children: <Widget>[
          Text('￥ ${item.price}'),
          Container(
            child: InkWell(
              onTap: () {
                Toast.showCenter('点击删除 ${item.goodsName}');
              },
              child: Icon(
                Icons.delete_forever,
                color:Colors.black26,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }

}

