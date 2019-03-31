import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

import './route_handler.dart';
class Routes {

  static String root = '/';
  static String detailsPage = '/detail';

  static void configRoutes(Router router) {
    router.notFoundHandler = new Handler(
      handlerFunc: (BuildContext context, Map<String,List<String>> parmas) {
        print('找不到 >>>>> 指定 router');
      }
    );

    router.define(detailsPage,handler: detailsGoodsHandler);

  }
  
}