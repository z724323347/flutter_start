import 'package:flutter/material.dart';

import '../model/category_model.dart';

class CategoryProvide with ChangeNotifier {

  List<BxMallSubDto> childList = [];
  

  getChildCategory(List<BxMallSubDto> list) {

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

  
}