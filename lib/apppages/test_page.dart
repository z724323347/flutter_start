import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../config/http_header.dart';

class HomePage extends StatefulWidget {
  final Widget child;

  HomePage({Key key, this.child}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String text = '没有请求数据';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AppBar'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              RaisedButton(
                onPressed: (){
                  onClilk();
                },
                child: Text('http 请求'),
              ),

              Text(text),
            ],
          ),
        ),
      )
    );
  }

  void onClilk() {
    print('------------------------');
    getHttp().then((val){
      setState(() {
       text = val['data'].toString(); 
      });
    });

  }

  Future getHttp() async {
    try {
      Response response ;
      Dio dio =new Dio();
      dio.options.headers= httpHeaders;
      response =await dio.get('https://time.geekbang.org/serv/v1/column/newAll');
      print(response);
      return response.data;
      
    } catch (e) {
      print(e.toString());
    }
  }
}