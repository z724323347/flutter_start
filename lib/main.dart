import 'package:flutter/material.dart';
import 'apppages/index_page.dart';

import 'package:provide/provide.dart';
import 'package:fluro/fluro.dart';

import './routers/application.dart';
import './routers/routes.dart';
import 'package:jpush_flutter/jpush_flutter.dart';

import './provide/counter.dart';
import './provide/category_provide.dart';
import './provide/category_goodslist_provide.dart';
import './provide/details_info_provide.dart';
import './provide/cart_goodslist_provide.dart';
import './provide/current_page_provide.dart';


import 'package:flutter_pro/pages/navbottombar.dart';

void main() {

  var counter = Counter();
  var currentPageProvide = CurrentPageProvide();
  var categoryChild = CategoryProvide();
  var categoryGoodsList =CategoryGoodsListProvide();
  var detailsInfoProvide =DetailsInfoProvide();
  var cartGoodListProvder = CartGoodListProvide();
  var providers = Providers();

  // final router = Router();

  providers
  ..provide(Provider<Counter>.value(counter))
  ..provide(Provider<CurrentPageProvide>.value(currentPageProvide))
  ..provide(Provider<CategoryProvide>.value(categoryChild))
  ..provide(Provider<CategoryGoodsListProvide>.value(categoryGoodsList))
  ..provide(Provider<CartGoodListProvide>.value(cartGoodListProvder))
  ..provide(Provider<DetailsInfoProvide>.value(detailsInfoProvide));

  //provide 多个状态的管理， .. 函数添加其它状态 exp.
  // ..provide(Provider<Other>.value(other));


  // runApp(MyApp());
  runApp(ProviderNode(child:MyApp(), providers:providers));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final JPush jpush = new JPush();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('jpush ::::::::  ${jpush.checkNotificationStatus()}');
  }


  @override
  Widget build(BuildContext context) {

    final router = Router();
    Routes.configRoutes(router);
    Application.router = router;


    return Container(
      child: MaterialApp(

        title: "Material",
        // 去掉右上角debug 图标 ， 默认 true显示
        debugShowCheckedModeBanner: false,
        // flutter 路由配置
        onGenerateRoute: Application.router.generator,

        theme: ThemeData(
          // IOS 侧边滑动返回上一页
          platform: TargetPlatform.iOS,
          primarySwatch: Colors.lightBlue
        ),

        // 测试入口   定义底部导航栏
         home: NavbottomBar(),
        //项目入口
//        home: IndexPage(),
      ),
    );
  }
}