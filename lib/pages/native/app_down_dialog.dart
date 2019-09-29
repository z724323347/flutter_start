import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_download/flutter_download.dart';
import 'package:flutter_pro/util/toast.dart';

class AppUpDataPage extends StatefulWidget {
  @override
  _AppUpDataPageState createState() => _AppUpDataPageState();
}

class _AppUpDataPageState extends State<AppUpDataPage> {
  bool isDownApp = false;
  double progress;
  String version;
  static const platform = const MethodChannel("native.flutter.io/up");
  static const eventChannel = const EventChannel('event.native.flutter.io/up');

  Future<Null> _getEventUpdata() async {
    try {
      print('进入  platform - EventChannel');
      Map<String, dynamic> map = {
        'url': 'https://qd.myapp.com/myapp/qqteam/QQ_JS/qqlite_4.0.0.1025_537062065.apk',
        'name':'test.apk',
        'msg': 'updata message'
      };
      eventChannel
          .receiveBroadcastStream(map)
          .listen(_onEvent, onError: _onError);
    } on PlatformException catch (e) {
      ToastUtil.showCenter('更新出错 ${e.message}');
    }
  }

  void _onEvent(Object event) {
    Map map = event;
    setState(() {
      progress = map['progress'] / map['max'];
    });
  }

  void _onError(Object error) {
    setState(() {
      ToastUtil.showCenter('下载出错 ${error.toString()}');
    });
  }

  @override
  void initState() {
    super.initState();

    progress = 0.0;
    isDownApp = false;
  }

  Future<void> _getPulignTest() async {
    Map map = {
      'url':"https://qd.myapp.com/myapp/qqteam/QQ_JS/qqlite_4.0.0.1025_537062065.apk",
    };
    FlutterDownload.flutterDownload(map);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.0,
      height: 410.5,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
              'images/appup/bg.png',
            ),
            fit: BoxFit.fitWidth,
            alignment: Alignment.bottomCenter),
      ),
      child: new Column(
        children: <Widget>[
          //关闭按钮
          new Container(
            alignment: Alignment.topRight,
            child: new GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: new Image.asset(
                'images/appup/close.png',
                width: 23.0,
                height: 37.5,
              ),
            ),
          ),

          //版本号
          new Container(
            margin: EdgeInsets.only(
              top: 18.0,
            ),
            child: new Text(
              'android_version',
              style: TextStyle(fontSize: 19.5, color: Colors.white),
            ),
          ),

          //title
          new Container(
            margin: EdgeInsets.symmetric(
              vertical: 5.0,
            ),
            child: new Text(
              '发现新版本',
              style: TextStyle(
                fontSize: 24.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          //版本大小
          new Container(
            margin: EdgeInsets.only(
              top: 5.0,
            ),
            child: new Text(
              '新版本大小: updata.android_size',
              style: TextStyle(fontSize: 12.0, color: Colors.white),
            ),
          ),

          //更新内容详情
          new Expanded(
            flex: 1,
            child: new Container(
              margin: EdgeInsets.only(
                top: 70.0,
                left: 24.0,
              ),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //tit
                  new Container(
                    height: 18,
                    padding: EdgeInsets.only(
                      left: 22.0,
                    ),
                    margin: EdgeInsets.only(bottom: 15.0),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            'images/appup/rocket.png',
                          ),
                          alignment: Alignment.centerLeft,
                          fit: BoxFit.fitHeight),
                    ),
                    alignment: Alignment.centerLeft,
                    child: new Text(
                      '更新内容',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Color(0xFF333333),
                      ),
                    ),
                  ),

                  Container(
                    //list
                    height: 100,
                    child: Container(
                      child: Center(
                        child: Text('下载地址 QQ为例(可更改）：https://qd.myapp.com/myapp/qqteam/QQ_JS/qqlite_4.0.0.1025_537062065.apk'),
                      ),
                    ),
                    // child: updata.tips.length != 0
                    //     ? ListView.builder(
                    //         itemCount: updata.tips.length,
                    //         itemBuilder: (BuildContext context, int index) {
                    //           return new Text(
                    //             '${index + 1}. ${updata.tips[index]}',
                    //             style: TextStyle(
                    //               fontSize: 12.0,
                    //               color: Color(0xFF666666),
                    //               height: 1.2,
                    //             ),
                    //           );
                    //         },
                    //       )
                    //     : Container(
                    //         child: Center(
                    //           child: Text('暂无更新内容'),
                    //         ),
                    //       ),
                  ),
                ],
              ),
            ),
          ),

          !isDownApp
              ? Container(
                  child: Offstage(
                  offstage: isDownApp,
                  child: RaisedButton(
                    color: Color(0xFFff4a4a),
                    onPressed: () {
                      setState(() {
                        isDownApp = true;
                        _getEventUpdata();
                        // _getPulignTest();
                      });
                    },
                    child: Text(
                      '立即升级',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ))
              : Container(
                  width: 272.5,
                  height: 9.5,
                  margin: EdgeInsets.only(bottom: 21.5),
                  decoration: BoxDecoration(
                      color: Color(0xFFDBDBDE),
                      borderRadius: BorderRadius.circular(9.5)),
                  alignment: Alignment.centerLeft,
                  child: new Container(
                    width: 272.5 * progress,
                    //注：进度条前进改变width值 ，最大值为272.5
                    height: 9.5,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color(0xFFff4a4a),
                              Color(0xFFffbd4a),
                            ]),
                        borderRadius: BorderRadius.circular(9.5)),
                  ),
                ),

          SizedBox(height: 10)
        ],
      ),
    );
  }
}
