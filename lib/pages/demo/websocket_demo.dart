import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

class WebSocketDemo extends StatefulWidget {
  WebSocketDemo();

  _WebSocketDemoState createState() => _WebSocketDemoState();
}

class _WebSocketDemoState extends State<WebSocketDemo> {

  

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = new TextEditingController();
    IOWebSocketChannel channel;
    String _text = '';

    @override
    void initState() { 
      channel = new IOWebSocketChannel.connect('ws://echo.websocket.org');

    }

    @override
    dispose(){
      channel.sink.close();
      super.dispose();
    }

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
                decoration: InputDecoration(
                  labelText: 'send message '
                ),
              ),
            ),
            new StreamBuilder(
              stream: channel.stream,
              builder: (context,snapshot){
                //网络不正常
                if (snapshot.hasError) {
                  _text = '网络不正常...';
                } else {
                  _text = 'echo : ${snapshot.data}';
                }
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: Text(_text),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
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
