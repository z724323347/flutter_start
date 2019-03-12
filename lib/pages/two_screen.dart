import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_pro/widget/widget_drawer.dart';

class TwoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dart 语法'),
        leading: Builder( builder: (context){
          return IconButton(
            icon: Icon(Icons.dashboard,color: Colors.white),//自定义图标
            onPressed: (){// 打开抽屉菜单 
               Scaffold.of(context).openDrawer(); 
            },
          );
        },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text('Future'),
              onPressed: (){
                //Future
                Future.wait([
                  // 2秒后返回结果
                  Future.delayed(Duration(seconds:2),(){
                    return 'Future.delayed , 2s ';
                  }),
                  // 3秒后返回结果
                  Future.delayed(Duration(seconds:3),(){
                    return ',3 秒';
                  }),
                ]).then((results){
                  print(results[0] + results[1]);
                }).catchError((onError){
                  print(onError);
                });
              },
            ),

            RaisedButton(
              child: Text('Stream'),
              onPressed: (){
                //Stream
                Stream.fromFutures([
                  // 1秒后返回结果
                  Future.delayed(Duration(seconds:1),(){
                    return 'Stream.fromFutures, 1s 后返回结果 ';
                  }),
                  // 2秒后手动抛出一个异常
                  Future.delayed(Duration(seconds:2),(){
                    throw AssertionError('Error');
                  }),
                  // 3 秒后返回结果
                  Future.delayed(Duration(seconds:3),(){
                    return '3 秒后，返回结果';
                  }),
                ]).listen((data){
                  print(data);
                },onError: (e){
                  print(e);
                },onDone: (){}
                );
              },
            ),

            RaisedButton(
              child: Text('debugDumpApp'),
              onPressed: (){
                debugDumpApp();
              },
            ),

            RaisedButton(
              child: Text('debugDumpRenderTree'),
              onPressed: (){
                debugDumpRenderTree();
              },
            ),

            RaisedButton(
              child: Text('debugDumpLayerTree'),
              onPressed: (){
                debugDumpLayerTree();
              },
            ),

            RaisedButton(
              child: Text('debugDumpSemanticsTree'),
              onPressed: (){
                debugPaintSizeEnabled: true;
              },
            ),
          ],
        ),
      ),
    );
  }
}