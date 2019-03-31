import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import '../apppages/detail/details_goods_pages.dart';

Handler detailsGoodsHandler = Handler(
  handlerFunc: (BuildContext context, Map<String,List<String>> params){
    String goodsId = params['id'].first;
    print('index detail_page  goodsId : ${goodsId}');

    return GoodsDetailsPage(goodsId);
  }
);