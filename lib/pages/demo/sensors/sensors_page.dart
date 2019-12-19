import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_pro/pages/demo/sensors/snake.dart';
import 'package:flutter_pro/pages/native/setting_page.dart';
import 'package:sensors/sensors.dart';

import 'dart:math' as math;

import '../../custom_route.dart';

class SensorsPage extends StatefulWidget {
  @override
  _SensorsPageState createState() => _SensorsPageState();
}

class _SensorsPageState extends State<SensorsPage> {
  static const int _snakeRows = 20;
  static const int _snakeColumns = 20;
  static const double _snakeCellSize = 10.0;

  List<double> _accelerometerValues;
  List<double> _userAccelerometerValues;
  List<double> _gyroscopeValues;
  List<StreamSubscription<dynamic>> _streamSubscriptions =
      <StreamSubscription<dynamic>>[];

  double lastX = 0.0;
  double lastY = 0.0;
  double lastZ = 0.0;

  int count = 0;
  // 上次检测时间
  num lastUpdateTime = 0;
  // 两次检测的时间间隔
  int UPTATE_INTERVAL_TIME = 200;
  // 速度阈值，当摇晃速度达到这值后产生作用
  final int SPEED_SHRESHOLD = 200;

  @override
  void initState() {
    super.initState();
    _streamSubscriptions
        .add(accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        _accelerometerValues = <double>[event.x, event.y, event.z];

        // print('event.x  --${event.x.toStringAsFixed(1)}');
        // print('event.y  --${event.y.toStringAsFixed(1)}');
        // print('event.z  --${event.z.toStringAsFixed(1)}');
        // print('--------------------------------------------');
      });
    }));
    _streamSubscriptions.add(gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        _gyroscopeValues = <double>[event.x, event.y, event.z];
      });
    }));
    _streamSubscriptions
        .add(userAccelerometerEvents.listen((UserAccelerometerEvent event) {
      setState(() {
        _userAccelerometerValues = <double>[event.x, event.y, event.z];
      });
    }));
  }

  @override
  void dispose() {
    super.dispose();
    for (StreamSubscription<dynamic> subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }

  void checked(context) {
    // 现在检测时间
    num currentUpdateTime = DateTime.now().millisecondsSinceEpoch;

    // 两次检测的时间间隔
    num timeInterval = currentUpdateTime - lastUpdateTime;

    print('timeInterval --- ${timeInterval}');

    // 判断是否达到了检测时间间隔
    if (timeInterval < UPTATE_INTERVAL_TIME) return;
    // 现在的时间变成last时间
    lastUpdateTime = currentUpdateTime;

    // 获得x,y,z坐标
    double x = _accelerometerValues?.map((double v) => v)?.toList()[0];
    double y = _accelerometerValues?.map((double v) => v)?.toList()[1];
    double z = _accelerometerValues?.map((double v) => v)?.toList()[2];

    // 获得x,y,z的变化值
    double deltaX = (x - lastX).toDouble();
    double deltaY = (y - lastY).toDouble();
    double deltaZ = (z - lastZ.toDouble());

    // 将现在的坐标变成last坐标
    lastX = x;
    lastY = y;
    lastZ = z;

    double speed =
        math.sqrt(deltaX * deltaX + deltaY * deltaY + deltaZ * deltaZ) /
            1000 *
            10000;
    print('speed -----------  $speed');
    // 达到速度阀值，发出提示
    if (int.parse(speed.toStringAsFixed(0)) >= SPEED_SHRESHOLD) {
      print('检查到了');
      count++;
      if (count > 2) {
        Navigator.pop(context);
        // Navigator.of(context).push(MaterialPageRoute(builder: (_) => SettingPage()));
        for (StreamSubscription<dynamic> subscription in _streamSubscriptions) {
          subscription.cancel();
        }
        count = 0;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<String> accelerometer =
        _accelerometerValues?.map((double v) => v.toStringAsFixed(1))?.toList();
    final List<String> gyroscope =
        _gyroscopeValues?.map((double v) => v.toStringAsFixed(1))?.toList();
    final List<String> userAccelerometer = _userAccelerometerValues
        ?.map((double v) => v.toStringAsFixed(1))
        ?.toList();
    checked(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sensor Example'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          OutlineButton(
            onPressed: () {
              Navigator.of(context).push(
                CustomRoute(SettingPage()),
              );
            },
            child: Text('start'),
          ),
          Center(
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(width: 1.0, color: Colors.black38),
              ),
              child: SizedBox(
                height: _snakeRows * _snakeCellSize,
                width: _snakeColumns * _snakeCellSize,
                child: Snake(
                  rows: _snakeRows,
                  columns: _snakeColumns,
                  cellSize: _snakeCellSize,
                ),
              ),
            ),
          ),
          Padding(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Accelerometer: $accelerometer'),
              ],
            ),
            padding: const EdgeInsets.all(16.0),
          ),
          Padding(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('UserAccelerometer: $userAccelerometer'),
              ],
            ),
            padding: const EdgeInsets.all(16.0),
          ),
          Padding(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Gyroscope: $gyroscope'),
              ],
            ),
            padding: const EdgeInsets.all(16.0),
          ),
        ],
      ),
    );
  }
}
