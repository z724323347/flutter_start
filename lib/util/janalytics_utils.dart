import 'package:flutter/material.dart';
import 'package:janalytics/janalytics.dart';

class JanalyticsUtils{
  static int eventIdIndex = 1;

  static Widget createButton(String text,@required VoidCallback onPressed){
    return new SizedBox(
      width: double.infinity,
      child: new FlatButton(
        onPressed: onPressed,
        child: new Text(text),
        color: Color(0xff585858),
        highlightColor: Color(0xff888888),
        splashColor: Color(0xff888888),
        textColor: Colors.white,
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      ),
    );
  }

  /// 登录事件
  static void onLoginEvent() {
    Janalytics janalytics = Janalytics();
    //添加自己的Extra 信息
    //增加一个Map<String,String>
    Map<String,String> extraMap = new Map();
    extraMap['key_login'] = "登录事件";
    janalytics.onLoginEvent(
        "testLoginMethod", // 登录方式
        true,// 是否登录成功
        extMap: extraMap
    );
  }

  /// 注册事件
  static void onRegisterEvent(){
    Janalytics janalytics = Janalytics();
    //添加自己的Extra 信息
    //增加一个Map<String,String>
    Map<String,String> extraMap = new Map();
    extraMap['key_register'] = "注册事件";
    janalytics.onRegisterEvent(
        "testRegisterMethod", // 注册方式
        true,// 是否注册成功
        extMap: extraMap
    );
  }

  /// 商品购买事件
  static void onPurchaseEvent(){
    Janalytics janalytics = Janalytics();

    //添加自己的Extra 信息
    //增加一个Map<String,String>
    Map<String,String> extraMap = new Map();
    extraMap['key_purchase_event'] = "购买事件";
    janalytics.onPurchaseEvent(
        "test_purchaseGoodsID", //商品ID
        "篮球", //商品名称
        300, //商品价格
        true, //商品购买是否成功
        Currency.CNY, //货币类型
        "sport",//商品类型
        1, // 商品数量
        extMap: extraMap);
  }

  /// 浏览事件
  static void onBrowseEvent(int browseDuration){
    Janalytics janalytics = Janalytics();
    //添加自己的Extra 信息
    //增加一个Map<String,String>
    Map<String,String> extraMap = new Map();
    extraMap['key_browse_event'] = "浏览事件";

    janalytics.onBrowseEvent("test_browseID",//设置浏览内容id
        "热点新闻",//设置浏览的内容的名称
        "sport", //设置浏览的内容类型
        browseDuration,//设置浏览的内容时长,单位秒)
        extMap: extraMap
    );
  }

  /// 计算事件
  static void onCalculateEvent(){
    Janalytics janalytics  = Janalytics();
    //添加自己的Extra 信息
    //增加一个Map<String,String>
    Map<String,String> extraMap = new Map();
    extraMap['key_calculate_event'] = "计算事件";
    janalytics.onCalculateEvent(
        "test_calculateID$eventIdIndex",  // 事件ID
        1,   // 事件对应的值
        extMap: extraMap
    );
    eventIdIndex++;
  }

  /// 计数事件
  static void onCountEvent(){
    Janalytics janalytics  = Janalytics();
    //添加自己的Extra 信息
    //增加一个Map<String,String>
    Map<String,String> extraMap = new Map();
    extraMap['key_count_event'] = "计数事件";
    janalytics.onCountEvent(
        "Event_countID_Map",  // 事件ID
        extMap: extraMap
    );
    eventIdIndex++;
  }

  /// 页面统计 进入页面  onPageStart - onPageEnd 成对使用
  static void onPageStart(String pageName){
     Janalytics janalytics  = Janalytics();
     janalytics.onPageStart(pageName);
  }
  /// 页面统计 离开页面  onPageStart - onPageEnd 成对使用
  static void onPageEnd(String pageName){
     Janalytics janalytics  = Janalytics();
     janalytics.onPageEnd(pageName);
  }


  static void showToast(BuildContext context,String msg){
    final snackbar = SnackBar(
      content: Text(msg),
      backgroundColor: Colors.grey,
      duration: Duration(seconds: 2),
    );
    Scaffold.of(context).showSnackBar(snackbar);
  }

}

