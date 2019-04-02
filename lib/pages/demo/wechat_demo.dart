import 'package:flutter/material.dart';

import 'package:fluwx/fluwx.dart' as fluwx;

class WechatDemoPage extends StatelessWidget {
  WechatDemoPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wechat Demo'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(30.0),
            ),
            InkWell(
              onTap: () {
                getWecaht();
              },
              child: Column(
                children: <Widget>[
                  Icon(Icons.web_asset,color: Colors.green,size: 48),
                  Text('Wechat Login')
                ],
              )
            ),
          ],
        ),
      ),
    );
  }

  void getWecaht() {
    fluwx.register(appId:"wxd930ea5d5a258f4f",doOnAndroid: null);
  }
}