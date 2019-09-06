import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';

import '../../provide/cart_goodslist_provide.dart';
import '../../model/cart_goodsinfo_model.dart';
import '../../util/toast.dart';


class CartBottomCell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      color: Colors.white,
      child: Provide<CartGoodListProvide>(
        builder: (context,child, childItem) {
          return Row(
            children: <Widget>[
              selectAll(context),
              countArea(context),
              goButton(context)
            ],
          );
        },
      ),
      
      
    );
  }

  //全选
  Widget selectAll(context) {
    bool isAllCheck = Provide.value<CartGoodListProvide>(context).isAllCheck;
    return Container(
      child: Row(
        children: <Widget>[
          Checkbox(
            value: isAllCheck,
            activeColor: Colors.pink,
            onChanged: (bool val) {
              Provide.value<CartGoodListProvide>(context).changAllCheckState(val);
            },
          ),
          Text('全选')
        ],
      ),
    );
  }

  //合计
  Widget countArea(context) {
    double allPrice = Provide.value<CartGoodListProvide>(context).allPrice;
    return Container(
      width: ScreenUtil().setWidth(440),
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(280),
                child: Text(
                  '合计',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(24)
                  )),

              ),
              Container(
                alignment: Alignment.centerLeft,
                width: ScreenUtil().setWidth(160),
                child: Text(
                  '￥ ${allPrice}',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(24),
                    color: Colors.red
                  )
                ),
              ),
            ],
          ),
          Container(
            width: ScreenUtil().setWidth(440),
            alignment: Alignment.centerRight,
            child: Text(
              '满100元配送，预购免费配送',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(20)
              )),
          ),
        ],
      ),
    );
  } 

  //结算
  Widget goButton(context) {
    int allCount = Provide.value<CartGoodListProvide>(context).allCount;
    return Container(
      width: ScreenUtil().setWidth(180),
      padding: EdgeInsets.only(left: 10.0,right: 5.0),
      child: InkWell(
        onTap: () {
          ToastUtil.show('结算');
        },
        child: Container(
          padding: EdgeInsets.all(10.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color:Colors.red,
            borderRadius: BorderRadius.circular(5.0) 
          ),
          child: Text(
            '结算(${allCount})',
            style:TextStyle(
              color: Colors.white
            ),
          ),
        ),
      ),
    );
  }

}