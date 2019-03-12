import 'package:flutter/material.dart';
import 'package:http/http.dart' as client;
import 'package:flutter/services.dart';

class FourScreen extends StatefulWidget {
  _FourScreenState createState() => _FourScreenState();
}

class _FourScreenState extends State<FourScreen> with SingleTickerProviderStateMixin{

  TabController _tabController; //需要定义一个Controller
  List tabs = ["新闻", "历史", "图片"];

  void initState() { 
    super.initState();
    // 创建Controller  
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TabBar(
          controller: _tabController,
            tabs: tabs.map((e) => Tab(text: e)).toList()),
        ),
      body: Test(),
    );
  }
}

class Test extends StatelessWidget {
  String str;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            OutlineButton(
                child: Text('GET as client cbk'),
                onPressed: (){
                  getHttp((data){
                    print('cbk : ' + data);
                    str =data;
                  });
                },
              ),
            OutlineButton(
                child: Text('GET as client Future'),
                onPressed: (){
                  getData().then((data){
                      print("Future  : " + data);
                  });
                },
              ),  

          ],
        ),
      ),
    );
  }

}

  getHttp(cbk) async{
    var api = 'https://api.apiopen.top/musicBroadcasting';
    try {
      final response =await client.get(api);
      if (response.statusCode == 200) {
        cbk(response.body);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<String> getData() async{
    try {
      final response =await client.get('https://api.apiopen.top/musicBroadcasting');
      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      print(e);
    }
  }