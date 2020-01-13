import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

class WebSocketDemo extends StatefulWidget {
  WebSocketDemo();

  _WebSocketDemoState createState() => _WebSocketDemoState();
}

class _WebSocketDemoState extends State<WebSocketDemo> {
  IOWebSocketChannel channel;

  String _text = '';
  String _response = '';

  @override
  void initState() {
    channel = new IOWebSocketChannel.connect('ws://echo.websocket.org');
    listen();
    super.initState();
  }

  listen() {
    channel.stream.listen((m) {
      print('channel.stream --  $m');
      setState(() {
        _text = m;
      });
    });
  }

  _request() async {
    //建立连接
    var socket = await Socket.connect("baidu.com", 80);
    //根据http协议，发送请求头
    socket.writeln("GET / HTTP/1.1");
    socket.writeln("Host:baidu.com");
    socket.writeln("Connection:close");
    socket.writeln();
    await socket.flush(); //发送
    //读取返回内容
    // var _response =await socket.transform(utf8.decoder).join();
    print('r----- ${socket.transform(null)}');

    await socket.close();
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = new TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('web socket'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Form(
              child: TextFormField(
                controller: _controller,
                decoration: InputDecoration(labelText: 'send message '),
              ),
            ),
            // new StreamBuilder(
            //   stream: channel.stream,
            //   builder: (context, snapshot) {
            //     print('snapshot State --  ${snapshot.connectionState}');
            //     print('snapshot data  --  ${snapshot.data}');
            //     print('snapshot error --  ${snapshot.error}');
            //     //网络不正常
            //     if (snapshot.hasError) {
            //       setState(() {
            //         _text = '网络不正常...';
            //       });
            //     } else {
            //       _text = 'echo : ${snapshot.data}';
            //     }
            //     return Padding(
            //       padding: EdgeInsets.symmetric(vertical: 20.0),
            //       child: Text(_text),
            //     );
            //   },
            // ),
            Container(
              color: Colors.grey,
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: Text(
                _text,
                style: TextStyle(color: Colors.red),
              ),
            ),
            GestureDetector(
              onTap: () {
                _request();
              },
              child: Container(
                color: Colors.blue,
                height: 50,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_controller.text.isNotEmpty) {
            channel.sink.add(_controller.text);
          }
        },
        tooltip: 'send message',
        child: Icon(Icons.send),
      ),
    );
  }
}
