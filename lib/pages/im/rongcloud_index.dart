import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_pro/util/janalytics_utils.dart';
import 'package:flutter_pro/util/toast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rongcloud_im_plugin/rongcloud_im_plugin.dart';

class ImIndexPage extends StatefulWidget {
  ImIndexPage({Key key}) : super(key: key);

  _ImIndexPageState createState() => _ImIndexPageState();
}

class _ImIndexPageState extends State<ImIndexPage> {
  int time = 0;
  Timer timer;
  @override
  void initState() {
    timer = Timer.periodic( Duration(seconds: 1), (_){
      setState(() {
        time ++;
      });
    });
    RongcloudImPlugin.init('appkey');
    conn();
    super.initState();
  }

  @override
  void dispose() {
    print('time ++    $time');
    JanalyticsUtils.onBrowseEvent('news', '电竞视频直播', '电竞', time, '电竞', '电竞直播');
    timer.cancel();
    super.dispose();
  }

  void conn() async {
    int rc = await RongcloudImPlugin.connect('RongIMToken');
    print('connect result');
    print(rc);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text('IM'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            OutlineButton(
              onPressed: () {
                requestPermission();
              },
              child: Text('requestPermission'),
            ),
            OutlineButton(
              onPressed: () {
                openSetting();
              },
              child: Text('openSetting'),
            ),
            OutlineButton(
              onPressed: () {
                openRationale();
              },
              child: Text('openRationale'),
            ),
          ],
        ),
      ),
    );
  }

  // 权限申请和检测
  Future requestPermission() async {
    // 申请权限
    Map<PermissionGroup, PermissionStatus> permissions =
        await PermissionHandler().requestPermissions([PermissionGroup.storage]);

    // 申请结果
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.storage);

    if (permission == PermissionStatus.granted) {
      ToastUtil.showCenter('权限申请通过');
    } else {
      ToastUtil.showCenter('权限申请被拒绝');
    }
  }

  //打开设置页
  Future openSetting() async {
    bool isOpened = await PermissionHandler().openAppSettings();

    isOpened ? ToastUtil.showCenter('打开了设置页') : ToastUtil.showCenter('没打开');
  }

  //检测是否点击了禁止询问
  Future openRationale() async {
    //  shouldShowRequestPermissionRationale只有当用户同时点选了拒绝开启权限和不再提醒后才会true。
    bool isShown = await PermissionHandler()
        .shouldShowRequestPermissionRationale(PermissionGroup.storage);

    isShown
        ? ToastUtil.showCenter('isShown')
        : ToastUtil.showCenter(' no   isShown');
  }
}
