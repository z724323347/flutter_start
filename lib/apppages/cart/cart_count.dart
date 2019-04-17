import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../provide/cart_goodslist_provide.dart';
import '../../model/cart_goodsinfo_model.dart';
import '../../util/toast.dart';


class CartCountCell extends StatelessWidget {

  final CartGoodsInfoModel item;
  CartCountCell(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(165),
      margin: EdgeInsets.only(top: 5.0),
      decoration: BoxDecoration(
        border: Border.all(width: 1.0, color: Colors.black12)
      ),
      child: Row(
        children: <Widget>[
          _reduceBtn(),
          _countArea(),
          _addBtn(),
        ],
      ),
    );
  }

  //--
  Widget _reduceBtn() {
    return InkWell(
      onTap: (){

      },
      child: Container(
        width: ScreenUtil().setWidth(45),
        height: ScreenUtil().setHeight(45),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            right: BorderSide(color: Colors.black12, width: 1.0)
          )
        ),
        child: Text('-'),
      ),
    );
  }

  //++
  Widget _addBtn() {
    return InkWell(
      onTap: (){

      },
      child: Container(
        width: ScreenUtil().setWidth(45),
        height: ScreenUtil().setHeight(45),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            left: BorderSide(color: Colors.black12, width: 1.0)
          )
        ),
        child: Text('+'),
      ),
    );
  }

  //中间数值
  Widget _countArea() {
    return Container(
      width: ScreenUtil().setWidth(70),
      height: ScreenUtil().setHeight(45),
      alignment: Alignment.center,
      color: Colors.white,
      child: Text('${item.count}'),
    );
  }
}