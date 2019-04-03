import 'dart:async';

import 'package:flutter/cupertino.dart';
import './net_utils_dio.dart';

class LoginInvalidHandler {
  BuildContext currentContext;
  LoginInvalidHandler(this.currentContext);

  Future<Null> loginInvalidHandler(dynamic errorMsg) {
    if (errorMsg != null &&
        errorMsg is LogicError &&
        errorMsg.errorCode == 10000) {

        // eg. 登录信息认证失效， 执行对应的操作  
        // LocalStorage.clearLoginInfo();
        // Fluttertoast.showToast(
        //     msg: '您的登录已过期，请重新登录',
        //     gravity: ToastGravity.CENTER,
        //     timeInSecForIos: 3);
        // NavigatorUtils.goPwdLogin(currentContext);
      return Future.error(errorMsg);
    }
    return Future.error(errorMsg);
  }
}


Future<Null> nullFutureHandler(dynamic data){
  return Future.value(null);
}