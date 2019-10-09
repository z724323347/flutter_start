import 'package:flutter/material.dart';
import 'package:flutter_pro/pages/demo/dev/camera_page.dart';
import 'package:flutter_pro/pages/demo/dev/camera_test.dart';
import 'package:flutter_pro/pages/demo/drag/drag_deom.dart';
import 'package:flutter_pro/pages/demo/image/extend_image_zoom.dart';
import 'package:flutter_pro/pages/demo/image/extend_text_view.dart';
import 'package:flutter_pro/pages/demo/lottie/lottie_page.dart';
import 'package:flutter_pro/pages/im/rongcloud_index.dart';
import 'package:flutter_pro/pages/map/map_page.dart';
import 'package:flutter_pro/pages/video/video_index.dart';
import 'package:flutter_pro/util/janalytics_utils.dart';
import 'package:flutter_pro/widget/widget_check_box.dart';
import 'custom_route.dart';
import 'package:flutter_pro/widget/widget_formfield.dart';
import 'container.dart';
import 'package:flutter_pro/widget/widget_drawer.dart';

class ThreeScreen extends StatefulWidget {
  _ThreeScreenState createState() => _ThreeScreenState();
}

class _ThreeScreenState extends State<ThreeScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Widget'),
      ),
      drawer: Drawer(
        child: Padding(padding: const EdgeInsets.all(1.0), child: MyDrawer()),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  OutlineButton(
                    child: Text('VideoButton'),
                    onPressed: () {
                      Navigator.of(context).push(CustomRoute(VideoIndex()));
                    },
                  ),
                  OutlineButton(
                    child: Text('Map'),
                    onPressed: () {
                      JanalyticsUtils.onCountEvent();
                      Navigator.of(context).push(CustomRoute(MapIndexPage()));
                    },
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  OutlineButton(
                    child: Text('ZoomImageButton'),
                    onPressed: () {
                      Navigator.of(context).push(CustomRoute(ZoomImageDemo()));
                    },
                  ),
                  OutlineButton(
                    child: Text('SpecialTextButton'),
                    onPressed: () {
                      Navigator.of(context).push(CustomRoute(ExtendTextDemo()));
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  OutlineButton(
                    child: Text('Airbnb Lottie'),
                    onPressed: () {
                      Navigator.of(context)
                          .push(CustomRoute(AirbnbLottiePage()));
                    },
                  ),
                  OutlineButton(
                    child: Text('Map'),
                    onPressed: () {
                      Navigator.of(context).push(CustomRoute(MapIndexPage()));
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  OutlineButton(
                    child: Text('OutlineButton'),
                    onPressed: () {
                      Navigator.of(context).push(CustomRoute(DragDeom()));
                    },
                  ),
                  OutlineButton(
                    child: Text('IM'),
                    onPressed: () {
                      Navigator.of(context).push(CustomRoute(ImIndexPage()));
                    },
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  OutlineButton(
                    child: Text('Camera'),
                    onPressed: () {
                      Navigator.of(context).push(CustomRoute(CameraPage()));
                    },
                  ),
                  OutlineButton(
                    child: Text('CameraTestPage'),
                    onPressed: () {
                      Navigator.of(context).push(CustomRoute(CameraTestPage()));
                    },
                  ),
                ],
              ),

              IconButton(
                icon: Icon(Icons.thumb_up),
                onPressed: () {
                  JanalyticsUtils.onRegisterEvent();
                },
              ),

              RaisedButton(
                color: Colors.red,
                child: Text('容器--倾斜变换'),
                onPressed: () {
                  JanalyticsUtils.onLoginEvent();
                  Navigator.of(context).push(CustomRoute(TestContainer()));
                },
              ),

              RaisedButton(
                color: Colors.blue,
                highlightColor: Colors.blue[700],
                colorBrightness: Brightness.dark,
                splashColor: Colors.grey,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: Text('FlatButton with BorderRadius'),
                onPressed: () {
                  JanalyticsUtils.onPurchaseEvent();
                  Navigator.of(context).push(CustomRoute(FormTestRoute()));
                },
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.accessible,
                    color: Colors.green,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, top: 0.0, right: 20.0, bottom: 0.0),
                    child: Icon(
                      Icons.error,
                      color: Colors.green,
                    ),
                  ),
                  Icon(
                    Icons.fingerprint,
                    color: Colors.green,
                  ),
                ],
              ),

              //复选框
              SwitchAndCheckBoxTestRoute(),

              WrapAndFlow(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class WrapAndFlow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0, // 主轴(水平)方向间距
      runSpacing: 4.0, // 纵轴（垂直）方向间距
      alignment: WrapAlignment.center, //沿主轴方向居中
      children: <Widget>[
        new Chip(
          avatar:
              new CircleAvatar(backgroundColor: Colors.blue, child: Text('A')),
          label: new Text('Hamilton'),
        ),
        new Chip(
          avatar:
              new CircleAvatar(backgroundColor: Colors.blue, child: Text('B')),
          label: new Text('Lafayette'),
        ),
        new Chip(
          avatar:
              new CircleAvatar(backgroundColor: Colors.blue, child: Text('C')),
          label: new Text('Mulligan'),
        ),
        new Chip(
          avatar:
              new CircleAvatar(backgroundColor: Colors.blue, child: Text('Z')),
          label: new Text('Laurens'),
        ),
        new Chip(
          avatar:
              new CircleAvatar(backgroundColor: Colors.blue, child: Text('Z')),
          label: new Text('Laurens'),
        ),
        new Chip(
          avatar:
              new CircleAvatar(backgroundColor: Colors.blue, child: Text('Z')),
          label: new Text('Laurens'),
        ),
        new Chip(
          avatar:
              new CircleAvatar(backgroundColor: Colors.blue, child: Text('Z')),
          label: new Text('Laurens'),
        ),
        new Chip(
          avatar:
              new CircleAvatar(backgroundColor: Colors.blue, child: Text('Z')),
          label: new Text('Laurens'),
        ),
      ],
    );
  }
}
