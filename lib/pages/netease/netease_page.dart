import 'package:flutter/material.dart';
import 'dart:ui';

import './anim/needle_anim.dart';
import './anim/record_anim.dart';
import './player_page.dart';


const String coverArt =
        'http://hiphotos.qianqian.com/ting/pic/item/a2cc7cd98d1001e92b3c4768bb0e7bec54e79750.jpg',
    mp3Url = 'http://music.163.com/song/media/outer/url?id=451703096.mp3';

final GlobalKey<PlayerState> musicPlayerKey =new GlobalKey();

class MusicPlayerExample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _MusicPlayerExampleState();
  }
}

class _MusicPlayerExampleState extends State<MusicPlayerExample>
    with TickerProviderStateMixin {
  AnimationController controller_record;
  Animation<double> animation_record;
  Animation<double> animation_needle;
  AnimationController controller_needle;
  final _rotateTween = new Tween<double>(begin: -0.15, end: 0.0);
  final _commonTween = new Tween<double>(begin: 0.0, end: 1.0);

  @override
  void initState() {
    super.initState();
    controller_record = new AnimationController(
        duration: const Duration(milliseconds: 50000), vsync: this);
    animation_record =
        new CurvedAnimation(parent: controller_record, curve: Curves.linear);

    controller_needle = new AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    animation_needle =
        new CurvedAnimation(parent: controller_needle, curve: Curves.linear);

    animation_record.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller_record.repeat();
      } else if (status == AnimationStatus.dismissed) {
        controller_record.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        new Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new NetworkImage(coverArt),
              fit: BoxFit.cover,
              colorFilter: new ColorFilter.mode(
                Colors.white,
                BlendMode.overlay,
              ),
            ),
          ),
        ),
        new Container(
            child: new BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Opacity(
            opacity: 0.6,
            child: new Container(
              decoration: new BoxDecoration(
                color: Colors.white,
              ),
            ),
          ),
        )),
        new Scaffold(
          backgroundColor: Colors.transparent,
          appBar: new AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            title: Container(
              child: Text(
                'Shape of You - Ed Sheeran',
                style: new TextStyle(fontSize: 16.0),
              ),
            ),
            iconTheme: IconThemeData(
                color: Colors.black
                
            ),
          ),
          body: new Stack(
            alignment: const FractionalOffset(0.5, 0.0),
            children: <Widget>[
              new Stack(
                alignment: const FractionalOffset(0.7, 0.1),
                children: <Widget>[
                  new Container(
                    child: RotatrRecord(
                        animation: _commonTween.animate(controller_record)),
                    margin: EdgeInsets.only(top: 100.0),
                  ),
                  new Container(
                    child: new PivotTransition(
                      turns: _rotateTween.animate(controller_needle),
                      alignment: FractionalOffset.topLeft,
                      child: new Container(
                        width: 100.0,
                        child: new Image.asset("images/play_needle.png"),
                      ),
                    ),
                  ),
                ],
              ),
              new Padding(
                padding: const EdgeInsets.only(bottom: 50.0),
                child: new Player(
                  onError: (e) {
                    Scaffold.of(context).showSnackBar(
                      new SnackBar(
                        content: new Text(e),
                      ),
                    );
                  },
                  onPrevious: () {},
                  onNext: () {},
                  onCompleted: () {},
                  onPlaying: (isPlaying) {
                    if (isPlaying) {
                      controller_record.forward();
                      controller_needle.forward();
                    } else {
                      controller_record.stop(canceled: false);
                      controller_needle.reverse();
                    }
                  },
                  key: musicPlayerKey,
                  color: Colors.white,
                  audioUrl: mp3Url,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    controller_record.dispose();
    controller_needle.dispose();
    super.dispose();
  }
}