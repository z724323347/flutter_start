import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import 'package:camera/camera.dart';

import 'custom_route.dart';
import 'package:flutter_pro/web/web_view_more.dart';
import 'package:flutter_pro/web/web_view_plugin.dart';

class OneScreen extends StatefulWidget {

  String title;
  OneScreen({Key key,this.title}) : super(key:key);
  _OneScreenState createState() => _OneScreenState();
}

class _OneScreenState extends State<OneScreen> {

  static const nativePlugin = const MethodChannel('native.plugin');
  static const platform = const MethodChannel("native.flutter.io/battery");
  String _batteryLevel = "Unknown battery level.";

  //相机调用
  List<CameraDescription> cameras;
  CameraController controller;



  Future<Null> _getBatteryLevel() async {
  String batteryLevel;
  try{
      print('dart-_getBatteryLevel');
       // 在通道上调用此方法 与native通信
       final int result = await platform.invokeMethod('getBatteryLevel');
       batteryLevel = 'Battery level at $result % .';
    }on PlatformException catch(e){
      batteryLevel = "Failed to get battery level: '${e.message}'.";
  }

    setState(() {
     _batteryLevel = batteryLevel; 
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            child: Text('启动native页面'),
            onPressed: (){
              nativePlugin.invokeMethod('interaction');
              print("启动native页面");
            },
          ),
        
          RaisedButton(
             onPressed: (){
              _getBatteryLevel();
            },
            child: Text('Get battery level,获取native method电池电量'),
          ),
          Text('当前电量:$_batteryLevel'),

          RaisedButton(
            child: Text('flutter webview demo'),
            onPressed: (){
              print('web');
               Navigator.of(context).push(
                CustomRoute(WebViewDemo('webview title','http://www.baidu.com/')
                ),
            );
            },
          ),
          RaisedButton(
            child: Text('flutter webview more !!'),
            onPressed: (){
              print('web');
               Navigator.of(context).push(
                CustomRoute(WebPage('webview title','https://www.qq.com/')
                ),
            );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: DecoratedBox(
                 decoration: BoxDecoration(
                    gradient:  LinearGradient(colors:[Colors.red,Colors.orange[700]]), //背景渐变
                    borderRadius: BorderRadius.circular(5.0), //5像素圆角
                    boxShadow: [ //阴影
                      BoxShadow(
                        color: Colors.black54,
                        offset: Offset(2.0, 2.0),
                        blurRadius: 4.0
                        )
                      ]
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 18.0),
                    child: Text("Login", style: TextStyle(color: Colors.white),),
                    ),
            ),
          ),

          RaisedButton(
            child: Text('打开相机!'),
            onPressed: (){
                // open();
            },
          ),
          // AspectRatio(
          //   aspectRatio:
          //   controller.value.aspectRatio,
          //   child: CameraPreview(controller)
          //   ),
          
        ],
      ),
      ),
    );
  }


  
  Future<void> open() async {
    cameras = await availableCameras();
  }
  //  @override
  // void initState() {
  //   super.initState();
  //   controller = CameraController(cameras[0], ResolutionPreset.medium);
  //   controller.initialize().then((_) {
  //     if (!mounted) {
  //       return;
  //     }
  //     setState(() {});
  //   });
  // }

  // @override
  // void dispose() {
  //   controller?.dispose();
  //   super.dispose();
  // }




}

