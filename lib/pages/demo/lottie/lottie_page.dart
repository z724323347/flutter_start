import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_lottie/flutter_lottie.dart';
import 'package:flutter_pro/pages/demo/lottie/page_dragger.dart';
import 'package:flutter_pro/util/janalytics_utils.dart';

class AirbnbLottiePage extends StatefulWidget {
  @override
  _AirbnbLottiePageState createState() => _AirbnbLottiePageState();
}

class _AirbnbLottiePageState extends State<AirbnbLottiePage> {
  LottieController controller;
  StreamController<double> newProgressStream = new StreamController<double>();
  double newProgress =0.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Airbnb Lottie'),
      ),
      body: PageDragger(
        stream: newProgressStream,
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                width: 150,
                height: 150,
                // child: LottieView.fromURL(
                //   url: "https://assets1.lottiefiles.com/datafiles/WFKIUGAVvLl1azi/data.json",
                //   autoPlay: true,
                //   loop: true,
                //   reverse: true,
                //   onViewCreated: onViewCreated,
                // )
              ),
              FlatButton(
                child: Text("Play"),
                onPressed: () async {
                  controller.play();
                  controller.setAnimationSpeed(0.4);
                  double l = await controller.getAnimationSpeed();
                  print('${l}');
                },
              ),
              FlatButton(
                child: Text("Stop"),
                onPressed: () {
                  controller.stop();
                },
              ),
              FlatButton(
                child: Text("Pause"),
                onPressed: () {
                  controller.pause();
                },
              ),
              FlatButton(
                child: Text("Resume"),
                onPressed: () {
                  controller.resume();
                },
              ),
              Text("From File"),
              Container(
                child: SizedBox(
                  width: 250,
                  height: 250,
                  child: LottieView.fromFile(
                    filePath: "images/animations/done.json",
                    autoPlay: true,
                    loop: true,
                    reverse: true,
                    onViewCreated: onViewCreatedFile,
                  ),
                ),
              ),
              FlatButton(
                child: Text("Change Color"),
                onPressed: () {
                  // Set Color of KeyPath
                  this.controller.setValue(
                      value: LOTColorValue.fromColor(
                          color: Color.fromRGBO(0, 0, 255, 1)),
                      keyPath: "body Konturen.Gruppe 1.Fläche 1");
                  // Set Opacity of KeyPath
                  this.controller.setValue(
                      value: LOTOpacityValue(opacity: 0.1),
                      keyPath: "body Konturen.Gruppe 1.Fläche 1");
                },
              ),
              Text("Drag anywhere to change animation progress  + ${newProgress}"),
            ],
          ),
        ),
      ),
    );
  }

  void onViewCreated(LottieController controller) {
    this.controller = controller;

    // Listen for when the playback completes
    this.controller.onPlayFinished.listen((bool animationFinished) {
      print("Playback complete. Was Animation Finished? " +
          animationFinished.toString());
    });
  }

  Future<double> getV (LottieController controller) async {
    this.controller = controller;
    controller.getAnimationProgress().asStream().toString();
    return  controller.getAnimationProgress();
  }


  void onViewCreatedFile(LottieController controller) {
    this.controller = controller;
    newProgressStream.stream.listen((double progress) {
      this.controller.setAnimationProgress(progress);
      setState(() {
        newProgress = progress;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    newProgressStream.close();
  }

}
