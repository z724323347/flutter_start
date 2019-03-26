import 'package:flutter/material.dart';

import '../model/category_model.dart';

class CategoryProvide with ChangeNotifier {

  List<BxMallSubDto> childList = [];
  int childIndex = 0;  //子类索引
  String categoryId = '4'; // 大类ID
  String subId = ''; // 子类ID
  

  getChildCategory(List<BxMallSubDto> list, String id) {

    childIndex = 0;
    categoryId = id;
    BxMallSubDto all = BxMallSubDto.fromParams();
    all.mallSubId = '00';
    all.mallSubName = '全部';
    all.mallCategoryId = '00';
    all.comments = '0';
    childList = [all];
    childList.addAll(list);
    // childList =list;
    notifyListeners();
  }

  //改变子类索引
  changeChildIndex(index, String id) {
    childIndex = index;
    subId = id;
    notifyListeners();
  }

  
}