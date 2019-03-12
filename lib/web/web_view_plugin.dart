import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebViewDemo extends StatelessWidget {

  String title;
  String url;
  BuildContext context;
  WebViewDemo(String title,String url){
    this.title=title;
    this.url=url;
  }

  Future<bool> _requestPop() {
    // Navigator.of(context).pop(100);///弹出页面并传回int值100，用于上一个界面的回调
    // _showDialog();
    print('返回键监听。。。。');
    return Future.value(true);
  }

  _showDialog() {
    showDialog<Null>(
      context: context,
      child: AlertDialog(
        content: Text('退出当前 webview'),
        actions: <Widget>[
            FlatButton(
              onPressed: (){
                Navigator.of(context);
                Navigator.of(context).pop();
              },
              child: Text('ok'),
            )
        ]),
      
    );
  }

  @override
  Widget build(BuildContext context){
    this.context = context;
    return WillPopScope(
      child: WebviewScaffold(
        url: url,
        appBar: AppBar(
          title: Text(title),
          iconTheme: IconThemeData(
                color: Colors.white
            ),
            backgroundColor: Color.fromARGB(255, 41, 58, 144),
        ),
        withJavascript: true,
      ),
      onWillPop:_requestPop,
    );
  }


}