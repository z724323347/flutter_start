import 'package:flutter/material.dart';
import 'package:flutter_ijkplayer/flutter_ijkplayer.dart';
import 'package:flutter_pro/pages/custom_route.dart';
import 'package:flutter_pro/pages/video/video.dart';
import 'package:flutter_pro/util/toast.dart';

class VideoIndex extends StatefulWidget {
  @override
  _VideoIndexState createState() => _VideoIndexState();
}

class _VideoIndexState extends State<VideoIndex> {
  IjkMediaController controller = IjkMediaController();

  VideoInfo videoInfo;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.white70,
        child: Column(
          children: <Widget>[
            OutlineButton(
              onPressed: () {
                showIJKDialog();
              },
              child: Text('showIJKDialog'),
            ),
            OutlineButton(
              onPressed: () {},
              child: Text('showIJKFullScreen'),
            ),
            OutlineButton(
              onPressed: () {
                Navigator.of(context).push(
                  CustomRoute(VideoInfoPage()),
                );
              },
              child: Text('VideoInfoPage'),
            ),
          ],
        ),
      ),
    );
  }

  void showIJKDialog() async {
    await controller.setDataSource(DataSource.network(
        'https://www.apple.com/105/media/us/iphone-x/2017/01df5b43-28e4-4848-bf20-490c34a926a7/films/feature/iphone-x-feature-tpl-cc-us-20170912_1280x720h.mp4'));

    videoInfo = await controller.getVideoInfo();

    await controller.play();

    await showDialog(
      context: context,
      builder: (_) => DialogIJKPlayer(controller: controller),
    );
    controller.pause();
  }
}

class DialogIJKPlayer extends StatefulWidget {
  final IjkMediaController controller;
  DialogIJKPlayer({this.controller});
  @override
  _DialogIJKPlayerState createState() =>
      _DialogIJKPlayerState(controller: controller);
}

class _DialogIJKPlayerState extends State<DialogIJKPlayer> {
  final IjkMediaController controller;
  _DialogIJKPlayerState({this.controller});

  Orientation get orientation => MediaQuery.of(context).orientation;

  double progressValue = 0.0;

  VideoInfo videoInfo;

  @override
  void initState() {
    super.initState();
    getInfo();
  }

  @override
  void dispose() {
    controller?.dispose();
    videoInfo = null;
    super.dispose();
  }

  getInfo() async {
    videoInfo = await controller.getVideoInfo();
    setState(() {
      videoInfo == null
          ? videoInfo.currentPosition = 0.0
          : videoInfo.currentPosition = progressValue;
    });
    print('videoInfo  ------ ${videoInfo.toString()}');
  }

  @override
  Widget build(BuildContext context) {
    getInfo();
    return Stack(
      children: <Widget>[
        IjkPlayer(
          mediaController: controller,
          // controllerWidgetBuilder 自定义 播放控制菜单 ... 不写则是调用默认的播放控制菜单
          controllerWidgetBuilder: (ctrl) {
            return Stack(
              children: <Widget>[
                Positioned(
                  bottom: 10,
                  child: Container(
                    margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    width: MediaQuery.of(context).size.width,
                    height: 30,
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 20, right: 10),
                          child: InkWell(
                            onTap: () {
                              if (videoInfo != null) {
                                ctrl.ijkStatus == IjkStatus.playing
                                    ? ctrl.pause()
                                    : ctrl.play();
                              }
                            },
                            child: Icon(
                              ctrl.ijkStatus == IjkStatus.playing
                                  ? Icons.pause
                                  : Icons.play_arrow,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        new Text(
                          videoInfo == null
                              ? '0.0'
                              : videoInfo.currentPosition.toStringAsFixed(1),
                          style: TextStyle(color: Colors.white),
                        ),
                        Expanded(
                          flex: 1,
                          child: Slider(
                            value: progressValue,
                            max: 100.0,
                            min: 0.0,
                            activeColor: Colors.blue,
                            onChanged: (double val) {
                              ToastUtil.show('${val}');
                              setState(() {
                                controller.seekToProgress(val / 100);
                                progressValue = val;
                              });
                            },
                          ),
                        ),
                        new Text(
                          videoInfo == null
                              ? '0.0'
                              : videoInfo.duration.toStringAsFixed(0),
                          style: TextStyle(color: Colors.white),
                        ),
                        Container(
                          width: 10,
                        )
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        ),
        Positioned(
          top: 10,
          left: 10,
          child: GestureDetector(
            onTap: () async {
              if (orientation == Orientation.landscape) {
                await IjkManager.setPortrait();
              } else {
                await IjkManager.setLandScape();
              }
              VideoInfo info = await controller.getVideoInfo();
              print('getVideoInfo ----- ${info.toString()}');
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: orientation == Orientation.landscape
                  ? Colors.red
                  : Colors.white,
            ),
          ),
        )
      ],
    );
  }
}
