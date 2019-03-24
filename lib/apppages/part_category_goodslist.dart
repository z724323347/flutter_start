import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';


import 'package:flutter_pro/config/service_method.dart';
import 'package:flutter_pro/util/toast.dart';
import 'package:flutter_pro/model/category_goodslist_model.dart';
import '../provide/category_goodslist_provide.dart';

//商品列表
class CategoryGoodsList extends StatefulWidget {
  @override
  _CategoryGoodsListState createState() => _CategoryGoodsListState();
}


class _CategoryGoodsListState extends State<CategoryGoodsList> {
  // List list = [];

   @override
  void initState() {
    // _getGoodList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provide<CategoryGoodsListProvide>(
      builder: (context, child, data) {
        return Container(
          width: ScreenUtil().setWidth(570),
          height: ScreenUtil().setHeight(1110),
          child: ListView.builder(
            itemCount: data.goodsList.length,
            itemBuilder: (context,index) {
              return buildItem(data.goodsList ,index);
            },
          ),
        );
      },

    );
    
    
  }

  // void _getGoodList() async {
  //   var data = {
  //     'categoryId':'5',
  //     'categorySubId':"",
  //     'page':1
  //   };

  //   await request('getMallGoods',formData:data).then((val){
  //     var data = json.decode(val.toString());

  //     CategoryGoodsListModel goodsList =  CategoryGoodsListModel.fromJson(data);

  //     Toast.showCenter('------------------- ${goodsList.data[0].goodsName}');

  //     setState(() {
  //      list =goodsList.data; 
  //     });

  //     // print('分类商品列表：>>>>>>>>>>>>>>>>>> ${data}');
  //     // Toast.showCenter('分类商品列表：\n${data}');
  //   });
  // }


  Widget buildImage(List newList , int index) {
    return Container(
      width: ScreenUtil().setWidth(200),
      child: Image.network(newList[index].image),
    );
  }

  Widget buildName(List newList ,int index) {
    return Container(
      padding: EdgeInsets.all(5.0),
      width: ScreenUtil().setWidth(350),
      child: Text(
        newList[index].goodsName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style:TextStyle(fontSize: ScreenUtil().setSp(24))
      ),
    );
  }

  Widget buildPrice(List newList ,int index) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      width: ScreenUtil().setWidth(350),
      child: Row(
        children: <Widget>[
          Text(
            '价格￥ ${newList[index].presentPrice}',
            style: TextStyle(color: Colors.pink, fontSize: ScreenUtil().setSp(26)),
          ),
          Text(
            '价格￥ ${newList[index].oriPrice}',
            style: TextStyle(color: Colors.black12, decoration: TextDecoration.lineThrough, fontSize: ScreenUtil().setSp(20)),
          ),
        ],
      ),
    );
  }

  Widget buildItem(List newList ,int index) {
    return InkWell(
      onTap: () {
        Toast.showCenter('onTap :  ${index}');
      },
      child: Container(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(width: 1, color: Colors.black12)
          )
        ),
        child: Row(
          children: <Widget>[
            buildImage(newList,index),
            Column(
              children: <Widget>[
                buildName(newList,index),
                buildPrice(newList,index)
              ],
            )
          ],
        ),
      ),
    );
  }


}