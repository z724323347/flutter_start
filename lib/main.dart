import 'package:flutter/material.dart';
import 'package:flutter_ijkplayer/flutter_ijkplayer.dart';
import 'package:flutter_pro/widget/toast/toast.dart';
// import 'package:janalytics/janalytics.dart';
import 'package:package_info/package_info.dart';
// import 'package:flutter_boost/flutter_boost.dart';
// import 'package:flutter_pro/pages/boost/first_boost_page.dart';
// import 'package:flutter_pro/pages/boost/second_boost_page.dart';
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

void main() async {
  var counter = Counter();
  var currentPageProvide = CurrentPageProvide();
  var categoryChild = CategoryProvide();
  var categoryGoodsList = CategoryGoodsListProvide();
  var detailsInfoProvide = DetailsInfoProvide();
  var cartGoodListProvder = CartGoodListProvide();
  var providers = Providers();

  // final router = Router();

  // init IJKPlayer
  IjkConfig.isLog = true;
  // IjkConfig.level = LogLevel.verbose;
  await IjkManager.initIJKPlayer();

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
  runApp(ProviderNode(child: MyApp(), providers: providers));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final JPush jpush = new JPush();
  String debugLable = 'Unknown';
  // final Janalytics janalytics = new Janalytics();
  @override
  void initState() {
    super.initState();
    initPlatformState();
    // print('jpush ::::::::  ${jpush.checkNotificationStatus()}');
    // FlutterBoost.singleton.registerPageBuilders({
    //   'boost://firstPage': (pageName, params, _) => FirstBoostPage(),
    //   'boost://secondPage': (pageName, params, _) => SecondBoostPage(),
    // });
    // FlutterBoost.handleOnStartPage();
  }

  Future<void> initPlatformState() async {
    jpush.getRegistrationID().then((rid) {
      setState(() {
        debugLable = "flutter getRegistrationID: $rid";
      });
    });

    jpush.setup(
      appKey: "a3600525db613641003d139a",
      channel: "developer-default",
      production: false,
      debug: true,
    );
    // janalytics.setup(
    //     appKey: "a3600525db613641003d139a",
    //     channel: "devloper-default"); // 初始化sdk
    // janalytics.setDebugMode(true); // 打开调试模式

    try {
      PackageInfo info = await PackageInfo.fromPlatform();
      String appInfo =
          '应用名: ${info.appName}\n包名:${info.packageName}\n版本:${info.version}';
      print('Jpush  ID--------- ${debugLable}');
      print('Janalytics  --------- ${appInfo}');
    } on Exception catch (e) {
      print('init error:$e');
    }

    try {
      jpush.addEventHandler(
        onReceiveNotification: (Map<String, dynamic> message) async {
          print("flutter onReceiveNotification: $message");
          setState(() {
            debugLable = "flutter onReceiveNotification: $message";
            jpush.sendLocalNotification(LocalNotification(
                content: message['alert'],
                fireTime: DateTime.now(),
                id: message['extras']['cn.jpush.android.NOTIFICATION_ID'],
                title: message['title']));
          });
        },
        onOpenNotification: (Map<String, dynamic> message) async {
          print("flutter onOpenNotification: $message");
          setState(() {
            debugLable = "flutter onOpenNotification: $message";
          });
        },
        onReceiveMessage: (Map<String, dynamic> message) async {
          print("flutter onReceiveMessage: $message");
          setState(() {
            debugLable = "flutter onReceiveMessage: $message";
          });
        },
      );
    } on Exception {}

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    final router = Router();
    Routes.configRoutes(router);
    Application.router = router;

    Toast.ctx = context;
    print('context ----$context');

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
            primarySwatch: Colors.lightBlue),
        // FlutterBoost 初始化
        // builder: FlutterBoost.init(),

        // 测试入口   定义底部导航栏
        home: NavbottomBar(),
        //项目入口
//        home: IndexPage(),
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    String now =
        ((DateTime.now().millisecondsSinceEpoch) / 1000).toStringAsFixed(0);
    if (state == AppLifecycleState.paused) {
      print('切换到了后台');
    }
    if (state == AppLifecycleState.resumed) {
      print('切换到了前台');
    }
  }
}
