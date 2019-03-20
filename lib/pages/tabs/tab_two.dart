import 'package:flutter/material.dart';

import 'package:http/http.dart' as client;
import 'package:flutter/services.dart';

import 'package:flutter_pro/util/toast.dart';

class TabViewTwoPage extends StatefulWidget {

  _TabViewTwoPageState createState() => _TabViewTwoPageState();
}

class _TabViewTwoPageState extends State<TabViewTwoPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // child: buildItem(context),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            OutlineButton(
                child: Text('GET as client cbk'),
                onPressed: (){
                  getHttp((data){
                    print('cbk : ' + data);
                    Toast.showCenter('cbk : $data');
                  });
                },
              ),
            OutlineButton(
                child: Text('GET as client Future'),
                onPressed: (){
                  getData().then((data){
                      print("Future  : " + data);
                      Toast.showCenter('Future  :  $data');
                  });
                },
              ),  
          ],
        ),
      ),
    );
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
}