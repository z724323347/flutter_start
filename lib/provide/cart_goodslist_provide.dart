import 'package:flutter/material.dart';
import 'dart:convert';

import '../util/sp_utils.dart';
import '../model/cart_goodsinfo_model.dart';

class CartGoodListProvide with ChangeNotifier{
  String cartString = '[]';
  List<CartGoodsInfoModel> cartInfoList = [];
  double allPrice = 0; // 总价格
  int allCount = 0; //总数量

  save(goodsId,goodsName,count,price,images) async{
    //初始化SharedPreferences
    var prefs = await SpUtil().init;
    cartString = prefs.getString('cartInfo'); 
    //判断cartString是否为空，为空说明是第一次添加，或者被key被清除了
    var temp=cartString==null?[]:json.decode(cartString.toString());
    //把获得值转变成List
    List<Map> tempList = (temp as List).cast();
    //声明变量，用于判断购物车中是否已经存在此商品ID
    var isHave = false; 
    int ival = 0; 
    tempList.forEach((item){//进行循环，找出是否已经存在该商品
      //如果存在，数量进行+1操作
      if(item['goodsId'] == goodsId){
        tempList[ival]['count'] = item['count']+1;
        cartInfoList[ival].count++;
        isHave = true;
      }
      ival++;
    });
    //如果没有，进行增加
    if(!isHave){
      Map<String,dynamic> newGoodsInfo = {
        'goodsId':goodsId,
        'goodsName':goodsName,
        'count':count,
        'price':price,
        'images':images,
        'isCheck':true
      };
      tempList.add(newGoodsInfo);
      cartInfoList.add(CartGoodsInfoModel.fromJson(newGoodsInfo));
    }
    //把字符串进行encode操作，
    cartString = json.encode(tempList).toString();
    print('添加 set >>>>>> ： ${cartString}');
    print('添加 model >>>>>> ： ${cartInfoList}');
    prefs.setString('cartInfo', cartString);
    notifyListeners();
  }

  remove() async {
    var prefs = await SpUtil().init;
    prefs.remove('cartInfo');
    cartInfoList = [];
    print('清空完成----------------\n : ${prefs.getString('cartInfo')}');
    print('清空model--------------\n ： ${cartInfoList}');
    notifyListeners();
  }

  //得到购物车中的商品
  getCartGoodsInfo() async {
    var prefs = await SpUtil().init;
    cartString = prefs.getString('cartInfo');
    cartInfoList = [];
    if (cartString == null) {
      cartInfoList = [];
    } else {
      //temp list
      List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
      allPrice = 0;
      allCount = 0;
      //遍历
      tempList.forEach((item) {
        if(item['isCheck']) {
          allPrice += (item['count']*item['price']);
          allCount += item['count'];
        }
        cartInfoList.add(CartGoodsInfoModel.fromJson(item));
      });
    }
    notifyListeners();
  }

  //删除单个商品
  deteleGoods(String goodsId) async{
    var prefs = await SpUtil().init;
    cartString = prefs.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    //索引变量
    int tempIndex = 0;
    int deteleIndex = 0;
    tempList.forEach((item){
      if(item['goodsId'] == goodsId) {
        deteleIndex = tempIndex;
      }
      tempIndex++;
    });
    tempList.removeAt(deteleIndex);
    cartString = json.encode(tempList).toString();
    //持久化
    prefs.setString('cartInfo', cartString);
    //刷新list
    await getCartGoodsInfo();
  }


}
