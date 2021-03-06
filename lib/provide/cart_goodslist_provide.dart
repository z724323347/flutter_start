import 'package:flutter/material.dart';
import 'package:flutter_pro/util/sp_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/cart_goodsinfo_model.dart';

class CartGoodListProvide with ChangeNotifier{
  String cartString = '[]';
  List<CartGoodsInfoModel> cartInfoList = [];
  double allPrice = 0; // 总价格
  int allCount = 0; //总数量
  bool isAllCheck = true; //是否全选

  save(goodsId,goodsName,count,price,images) async{
    cartString = SpUtil.getString('cartInfo'); 
    //判断cartString是否为空，为空说明是第一次添加，或者被key被清除了
    var temp=cartString==null?[]:json.decode(cartString.toString());
    //把获得值转变成List
    List<Map> tempList = (temp as List).cast();
    //声明变量，用于判断购物车中是否已经存在此商品ID
    var isHave = false; 
    int ival = 0; 
    allPrice = 0;
    allCount = 0;
    tempList.forEach((item){//进行循环，找出是否已经存在该商品
      //如果存在，数量进行+1操作
      if(item['goodsId'] == goodsId){
        tempList[ival]['count'] = item['count']+1;
        cartInfoList[ival].count++;
        isHave = true;
      }
      if (item['isCheck']) {
        allPrice += (cartInfoList[ival].price * cartInfoList[ival].count);
        allCount += cartInfoList[ival].count;
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

      allPrice += (price * count);
      allCount += count;
    }
    //把字符串进行encode操作，
    cartString = json.encode(tempList).toString();
    print('添加 set >>>>>> ： ${cartString}');
    print('添加 model >>>>>> ： ${cartInfoList}');
    SpUtil.putString('cartInfo', cartString);
    notifyListeners();
  }

  remove() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.remove('cartInfo');
    cartInfoList = [];
    print('清空完成----------------\n : ${prefs.getString('cartInfo')}');
    print('清空model--------------\n ： ${cartInfoList}');
    notifyListeners();
  }

  //得到购物车中的商品
  getCartGoodsInfo() async {
    cartString = SpUtil.getString('cartInfo');
    cartInfoList = [];
    if (cartString == null) {
      cartInfoList = [];
    } else {
      //temp list
      List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
      allPrice = 0;
      allCount = 0;
      isAllCheck = true;
      //遍历
      tempList.forEach((item) {
        if(item['isCheck']) {
          allPrice += (item['count']*item['price']);
          allCount += item['count'];
        } else {
          isAllCheck = false;
        }
        cartInfoList.add(CartGoodsInfoModel.fromJson(item));
      });
    }
    notifyListeners();
  }

  //删除单个商品
  deteleGoods(String goodsId) async{
    cartString = SpUtil.getString('cartInfo');
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
    SpUtil.putString('cartInfo', cartString);
    //刷新list
    await getCartGoodsInfo();
  }

  changeCheckBoxState(CartGoodsInfoModel cartItem) async {
    cartString = SpUtil.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast(); 
    int tempIndex = 0;
    int changeIndex = 0;
    tempList.forEach((item){
      if(item['goodsId']== cartItem.goodsId){
        changeIndex = tempIndex;
      }
      tempIndex++; 
    });
    tempList[changeIndex] = cartItem.toJson();
    cartString = json.encode(tempList).toString();
    SpUtil.putString('cartInfo', cartString);
    //刷新list
    await getCartGoodsInfo();
  }

  //全选操作
  changAllCheckState(bool isCheck) async {
    cartString = SpUtil.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast(); 
    List<Map> newList = [];
    //forin 
    for (var item in tempList) {
      var newItem = item;
      newItem['isCheck'] = isCheck;
      newList.add(newItem);
    }
    cartString = json.encode(newList).toString();
    SpUtil.putString("cartInfo", cartString);
    //刷新list
    await getCartGoodsInfo();
  }

  //数量 +/-
  goodCountAddorReduce(var cartItem , String action) async{
    cartString = SpUtil.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    int tempIndex = 0;
    int changeIndex = 0;
    tempList.forEach((item){
      if(item['goodsId'] == cartItem.goodsId) {
        changeIndex = tempIndex;
      }
      tempIndex++;
    });

    if(action == 'add') {
      cartItem.count++;
    }else if(cartItem.count > 1){
      cartItem.count--;
    }
    tempList[changeIndex] = cartItem.toJson();
    cartString = json.encode(tempList).toString();
    SpUtil.putString("cartInfo", cartString);
    //刷新list
    await getCartGoodsInfo();
  }

}
