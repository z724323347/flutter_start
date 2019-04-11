import 'package:flutter/material.dart';
import 'dart:convert';

import '../util/sp_utils.dart';

class CartGoodListProvide with ChangeNotifier{
  String cartString = '[]';

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
        isHave = true;
      }
      ival++;
    });
    //如果没有，进行增加
    if(!isHave){
      tempList.add({
        'goodsId':goodsId,
        'goodsName':goodsName,
        'count':count,
        'price':price,
        'images':images
      });
    }
    //把字符串进行encode操作，
    cartString = json.encode(tempList).toString();
    print('添加 set： ${cartString}');
    prefs.setString('cartInfo', cartString);
  }

  remove() async {
    var prefs = await SpUtil().init;
    prefs.remove('cartInfo');
    print('清空完成----------------\n : ${prefs.getString('cartInfo')}');
    notifyListeners();
  }
  
}
