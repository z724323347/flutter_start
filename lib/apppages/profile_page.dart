import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provide/provide.dart';
import '../provide/counter.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: ListView(
        children: <Widget>[
          _topNavgater(),
          _orderBuild(),
          _orderType(),
          
          _itemListBuild(),
        ],
      ),
    );
  }

  Widget _topNavgater() {
    return Container(
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.all(20.0),
      color: Colors.blueAccent,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 30.0),
            width: ScreenUtil().setWidth(160),
            child: ClipOval(
              child: Image.network('https://avatars2.githubusercontent.com/u/10286107?s=460&v=4'),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20.0),
            child: Text(
              'name',
              style:TextStyle(
                fontSize:20,
                color:Colors.black54
              )),
          ),
        ],
      ),
    );
  }

  Widget _orderBuild() {
    return Container(
      margin: EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 1.0, color: Colors.black12)
        )
      ),
      
      child: ListTile(
        leading: Icon(Icons.list),
        title: Text('我的订单'),
        trailing: Icon(Icons.arrow_right),
      ),
    );
  }
  
  Widget _orderType() {
    return Container(
      margin: EdgeInsets.only(top: 8),
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(150),
      padding: EdgeInsets.only(top: 20),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(187),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.perm_media,
                  size: 30,
                ),
                Text('代付款')
              ],
            ),
          ),
          //
          Container(
            width: ScreenUtil().setWidth(187),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.query_builder,
                  size: 30,
                ),
                Text('代发货')
              ],
            ),
          ),
          //
          Container(
            width: ScreenUtil().setWidth(187),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.directions_car,
                  size: 30,
                ),
                Text('代收货')
              ],
            ),
          ),
          //
          Container(
            width: ScreenUtil().setWidth(187),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.crop_portrait,
                  size: 30,
                ),
                Text('代评价')
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _itemListBuild() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
          _itemList('title'),
          _itemList('title2'),
          _itemList('title3'),
          _itemList('title4'),
          _itemList('title5'),
          _itemList('title6'),
          _itemList('title7'),
          _itemList('title8'),
        ],
      ),
    );
  }

  Widget _itemList(String title) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 1.0, color: Colors.black12)
        )
      ),
      child: ListTile(
        leading: Icon(Icons.ac_unit),
        title: Text(title),
        trailing: Icon(Icons.arrow_right),
      ),
    );
  }

}