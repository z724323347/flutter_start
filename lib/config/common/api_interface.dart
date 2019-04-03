
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart';
import './net_utils_dio.dart';

// 所有接口请求

class ApiInterface {
  
  //eg.  例子，获取短信验证码
  static final String API_SMS_CODE = 'user/';
  static Future<Map<String, dynamic>> getSmsCode(
    String flag, String phone, String vefifyCode) async {
      return NetUtilsDio.postJson(API_SMS_CODE, {
        'flagId': flag,
        'phone':phone,
        'vefifyCode':vefifyCode
        });
    }

   
}
