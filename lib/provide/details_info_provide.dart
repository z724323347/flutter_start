import 'package:flutter/material.dart';
import 'dart:convert';


import '../model/details_goods_model.dart';
import '../config/service_method.dart';

class DetailsInfoProvide with ChangeNotifier {

  DetailsGoodsModel goodsInfo = null;

  bool isLeft = true;
  bool isRight = true;

  //tabbar 切换
  changeTabBar(String changeState) {
    if (changeState == 'left') {
      isLeft = true;
      isRight = false;
    } else {
      isLeft = false;
      isRight = true;
    }
    notifyListeners();
  }
  
  //从后台获取数据
  getGoodsInfo(String id) {
    var formData = {'goodId': id};

    request('getGoodDetailById',formData:formData).then((val){
      var responseData = json.decode(val.toString());
      print('responseData : $responseData');

      goodsInfo = DetailsGoodsModel.fromJson(responseData);
      notifyListeners();
    });
  }
}