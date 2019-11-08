import 'package:flotter_view/flotter.dart';
import 'package:flutter/material.dart';

class FlotterViewPlugin extends StatefulWidget {
  @override
  _FlotterViewPluginState createState() => _FlotterViewPluginState();
}

class _FlotterViewPluginState extends State<FlotterViewPlugin> {
  FlotterAnimationController controller1 =
      FlotterAnimationController('images/animations/done.json', 'done1');
  FlotterAnimationController controller2 =
      FlotterAnimationController('images/animations/done.json', 'done2');
  FlotterAnimationController controller3 = FlotterAnimationController(
      'images/animations/test.json', 'done3',
      loopMode: FlotterLoopMode.loop);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FlotterViewPlugin'),
      ),
      body: Center(
        child: Column(children: <Widget>[
          Container(
            width: 100.0,
            height: 100.0,
            child: FlotterView(controller1),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                  child: Text('start()'),
                  onPressed: () {
                    controller1.playFrom(0, 1.0, FlotterLoopMode.playOnce);
                  }),
              FlatButton(
                  child: Text('pause()'),
                  onPressed: () {
                    controller1.pause();
                  }),
              FlatButton(
                  child: Text('stop()'),
                  onPressed: () {
                    controller1.stop();
                  }),
            ],
          ),
          Container(
            width: 50.0,
            height: 50.0,
            child: FlotterView(controller2),
          ),
          FlatButton(
              child: Text('reverse()'),
              onPressed: () {
                controller2.reverse();
              }),
          Container(
            width: 150.0,
            height: 150.0,
            child: FlotterView(controller3),
          ),
          Text('LOOP MODE'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                  child: Text('start()'),
                  onPressed: () {
                    controller3.play();
                  }),
              FlatButton(
                  child: Text('pause()'),
                  onPressed: () {
                    controller3.pause();
                  }),
              FlatButton(
                  child: Text('stop()'),
                  onPressed: () {
                    controller3.stop();
                  }),
            ],
          ),
        ]),
      ),
    );
  }
}
