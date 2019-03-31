import 'package:flutter/material.dart';
import 'dart:convert';


import '../model/details_goods_model.dart';
import '../config/service_method.dart';

class DetailsInfoProvide with ChangeNotifier {

  DetailsGoodsModel goodsInfo = null;
  
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