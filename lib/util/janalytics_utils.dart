import 'package:flutter/material.dart';
import 'package:janalytics/janalytics.dart';

class JanalyticsUtils {
  static int eventIdIndex = 1;


  /// 登录事件
  /// 
  /// eventType       - 登录方式
  /// 
  /// isSuccess       - 是否登录成功
  /// 
  /// eventKey        - extraMap -key
  /// 
  /// eventValue      - extraMap -value
  static void onLoginEvent(
      String eventType, bool isSuccess, String eventKey, String eventValue) {
    Janalytics janalytics = Janalytics();
    //添加自己的Extra 信息
    Map<String, String> extraMap = new Map();
    extraMap[eventKey] = eventValue;
    janalytics.onLoginEvent(eventType, isSuccess, extMap: extraMap);
  }

  /// 注册事件
  /// 
  /// eventType       - 注册方式
  /// 
  /// isSuccess       - 是否注册成功
  /// 
  /// eventKey        - extraMap -key
  /// 
  /// eventValue      - extraMap -value
  static void onRegisterEvent(
      String eventType, bool isSuccess, String eventKey, String eventValue) {
    Janalytics janalytics = Janalytics();
    //添加自己的Extra 信息
    Map<String, String> extraMap = new Map();
    extraMap[eventKey] = eventValue;
    janalytics.onRegisterEvent(eventType, isSuccess, extMap: extraMap);
  }

  /// 商品购买事件
  static void onPurchaseEvent() {
    Janalytics janalytics = Janalytics();
    //添加自己的Extra 信息
    Map<String, String> extraMap = new Map();
    extraMap['key_purchase_event'] = "购买事件";
    janalytics.onPurchaseEvent(
        "test_purchaseGoodsID", //商品ID
        "篮球", //商品名称
        300, //商品价格
        true, //商品购买是否成功
        Currency.CNY, //货币类型
        "sport", //商品类型
        1, // 商品数量
        extMap: extraMap);
  }

  /// 浏览事件
  /// 
  /// browseId          - 设置浏览内容id
  /// 
  /// browseName        - 设置浏览的内容的名称
  /// 
  /// browseType        - 设置浏览的内容类型
  /// 
  /// browseDuration    - 设置浏览的内容时长,单位秒
  /// 
  /// eventKey          - extraMap -key
  /// 
  /// eventValue        - extraMap -value
  static void onBrowseEvent(
      String browseId,
      String browseName,
      String browseType,
      int browseDuration,
      String eventKey,
      String eventValue) {
    Janalytics janalytics = Janalytics();
    //添加自己的Extra 信息
    Map<String, String> extraMap = new Map();
    extraMap[eventKey] = eventValue;

    janalytics.onBrowseEvent(browseId, browseName, browseType, browseDuration,
        extMap: extraMap);
  }

  /// 计算事件
  /// 
  /// eventId       - 事件ID
  /// 
  /// value         - 事件对应的值
  /// 
  /// eventKey      - extraMap -key
  /// 
  /// eventValue    - extraMap -value
  static void onCalculateEvent(
      String eventId, double value, String eventKey, String eventValue) {
    Janalytics janalytics = Janalytics();
    //添加自己的Extra 信息
    //增加一个Map<String,String>
    Map<String, String> extraMap = new Map();
    extraMap[eventKey] = eventValue;
    janalytics.onCalculateEvent(eventId, value, extMap: extraMap);
  }

  /// 计数事件
  /// eventId       - 事件ID
  /// eventKey      - extraMap -key
  /// eventValue    - extraMap -value
  static void onCountEvent(String eventId, String eventKey, String eventValue) {
    Janalytics janalytics = Janalytics();
    //添加自己的Extra 信息
    Map<String, String> extraMap = new Map();
    extraMap[eventKey] = eventValue;
    janalytics.onCountEvent(eventId, extMap: extraMap);
  }

  /// 页面统计 进入页面
  /// onPageStart - onPageEnd 成对使用
  static void onPageStart(String pageName) {
    Janalytics janalytics = Janalytics();
    janalytics.onPageStart(pageName);
  }

  /// 页面统计 离开页面
  /// onPageStart - onPageEnd 成对使用
  static void onPageEnd(String pageName) {
    Janalytics janalytics = Janalytics();
    janalytics.onPageEnd(pageName);
  }
}
