import 'package:flutter/material.dart';

import '../model/category_goodslist_model.dart';

class CategoryGoodsListProvide with ChangeNotifier {

  List<GoodsList> goodsList = [];
  
  //点击大类，更换商品列表

  getGoodsList(List<GoodsList> list) {
    goodsList =list;
    notifyListeners();
  }

  
}