import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as client;
import 'package:flutter/services.dart';
import 'package:device_info/device_info.dart';

import 'package:flutter_pro/util/toast.dart';
import 'package:flutter_pro/pages/custom_route.dart';
import '../demo/qr_scan_demo.dart';
import '../demo/qr_scaning_demo.dart';


class TabViewTwoPage extends StatefulWidget {

  _TabViewTwoPageState createState() => _TabViewTwoPageState();
}

class _TabViewTwoPageState extends State<TabViewTwoPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // child: buildItem(context),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            OutlineButton(
                child: Text('GET as client cbk'),
                onPressed: (){
                  getHttp((data){
                    print('cbk : ' + data);
                    Toast.showCenter('cbk : $data');
                  });
                },
              ),
            OutlineButton(
                child: Text('GET as client Future'),
                onPressed: (){
                  getData().then((data){
                      print("Future  : " + data);
                      Toast.showCenter('Future  :  $data');
                  });
                },
              ),  

              RaisedButton(
                onPressed: () {
                  _getDevInfo();
                },
                child: Text('获取设备信息'),
              ),

              RaisedButton(
              child: Text('QR Code 生成!'),
              onPressed: (){
                  Navigator.of(context).push(
                    CustomRoute(QrScanPage())
                  );
                },
              ),

              RaisedButton(
              child: Text('QR Code 扫描!'),
              onPressed: (){
                  Navigator.of(context).push(
                    CustomRoute(QrScaningPage())
                  );
                },
              ),

          ],
        ),
      ),
    );
  }

  getHttp(cbk) async{
    var api = 'https://api.apiopen.top/musicBroadcasting';
    try {
      final response =await client.get(api);
      if (response.statusCode == 200) {
        cbk(response.body);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<String> getData() async{
    try {
      final response =await client.get('https://api.apiopen.top/musicBroadcasting');
      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      print(e);
    }
  }

  //查看多平台设备信息参数
  _getDevInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if(Platform.isIOS){
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        // print('Running on ${iosInfo.utsname.machine}');  // e.g. "iPod7,1"
        Toast.showCenter('Running on ${iosInfo.utsname.machine}');
    } else if(Platform.isAndroid){
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        Toast.showCenter('Running on ${androidInfo.model}');
    }
   
  }
}