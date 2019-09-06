import 'package:flutter/material.dart';
import 'package:flutter_ijkplayer/flutter_ijkplayer.dart';

class VideoInfoPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => VideoInfoState();
}

class VideoInfoState extends State<VideoInfoPage> {

  String selectPlayUrl = '';

  // 定义控制器
  IjkMediaController controller = IjkMediaController();


  VideoInfo videoInfo;

  @override
  void initState() {
    super.initState();
    getVideoInfo();
  }

  @override
  void dispose() {
    // 重要，一定要在销毁页面时销毁播放器，否则会出现后台仍在播放有声音的问题
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // appBar: AppBar(
      //   title: Text('影片信息'),
      // ),
      appBar: AppBar(
        title: const Text('Plugin example app'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.videocam),
            // onPressed: _pickVideo,
            onPressed: () async {
              String playUrl = 'http://s3.bytecdn.cn/aweme/resource/web/static/image/index/new-tvc_889b57b.mp4';
              // setState(() {
              //   selectPlayUrl = playUrl;
              // });
              // 这个方法调用后,会释放所有原生资源,但重新设置dataSource依然可用
              await controller.reset(); 
              // 重新设置播放地址
              controller.setNetworkDataSource(
                playUrl,
                autoPlay: false
              );
            },
          ),
        ],
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0.0,
              right: 0.0,
              height: MediaQuery.of(context).size.width / 16 * 9,
              child: Container(
                // 自定义播放器高度
                height: MediaQuery.of(context).size.width / 16 * 9,
                child: IjkPlayer(mediaController: controller),
              ),
            ),
            // ... 其它信息
          ]
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.play_arrow),
        onPressed: () async {
            String playUrl = 'http://s3.bytecdn.cn/aweme/resource/web/static/image/index/new-tvc_889b57b.mp4';
            // setState(() {
            //   selectPlayUrl = playUrl;
            // });
            // 这个方法调用后,会释放所有原生资源,但重新设置dataSource依然可用
            await controller.reset(); 
            // 重新设置播放地址
            controller.setNetworkDataSource(
              playUrl,
              autoPlay: false
            );
        },
      ),
    );
  }

  getVideoInfo() async {
    // String palyUrl = 'https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4';
    // String palyUrl = 'https://a.qdpony.com/live/p46stream2667718.m3u8?txSecret=eda71d03eb187fa0365862739097b8cb&txTime=5d5a7381';
    // String palyUrl = 'https://a.qdpony.com/live/p46stream2667718.flv?txSecret=eda71d03eb187fa0365862739097b8cb&txTime=5d5a7381';
    // String palyUrl = 'https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4';
    // String palyUrl = 'http://s3.bytecdn.cn/aweme/resource/web/static/image/index/new-tvc_889b57b.mp4';
    String palyUrl = 'https://a.qdpony.com/live/p46stream2735049.flv?txSecret=441be04d2122b59767a5503e4933c63a&txTime=5d5ca2b4';
    // String palyUrl = 'https://a.qdpony.com/live/p46stream2667718.m3u8?txSecret=eda71d03eb187fa0365862739097b8cb&txTime=5d5a7381';
    // String palyUrl = 'https://www.sample-videos.com/video123/flv/720/big_buck_bunny_720p_10mb.flv';
    // String palyUrl = 'https://a.qdpony.com/live/p46stream2727902.flv?txSecret=69b7bf41ab052ca3f1599a1aa3757e89&txTime=5d5b4a1e';
    // String palyUrl = 'https://a.qdpony.com/live/p46stream2728759.flv?txSecret=9ad7f52f1ed0c569911ad7a53049ef69&txTime=5d5b4aa6';
     // 'rtmp://172.16.100.245/live1',
              // 'https://www.sample-videos.com/video123/flv/720/big_buck_bunny_720p_10mb.flv',
//              "https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4",
              // 'http://184.72.239.149/vod/smil:BigBuckBunny.smil/playlist.m3u8',
              // "file:///sdcard/Download/Sample1.mp4",
    // setState(() {
    //   selectPlayUrl = palyUrl;
    // });

    await controller.setNetworkDataSource(
      palyUrl,
      autoPlay: false  //自动播放
    );


    videoInfo = await controller.getVideoInfo();
    print('videoInfo  ------ ${videoInfo.toString()}');
  }
}