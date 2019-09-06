import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../util/toast.dart';
import '../routers/application.dart';

//商品推荐，横着的ListView
class Recommend extends StatelessWidget {
  final List recommendList;
  Recommend({this.recommendList});

  Widget _buildTitle() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10.0, 2.0, 0, 5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 0.5, color: Colors.black12)
        )
      ),
      child: Text(
        '商品推荐',
        style:TextStyle(color:Colors.pink)
      ),
    );
  }

  Widget _buildItem(context,index ) {
    return InkWell(
      onTap: (){
        ToastUtil.showCenter("/detail?id=${recommendList[index]['goodsId']}");
        Application.router.navigateTo(context, '/detail?id=${recommendList[index]['goodsId']}');
      },
      child: Container(
        height: ScreenUtil().setHeight(330) ,
        width:  ScreenUtil().setWidth(250) ,
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(width: 5.0, color: Colors.black12)
          )
        ),
        child: Column(
          children: <Widget>[
            Image.network(recommendList[index]['image']),
            Text('￥${recommendList[index]['mallPrice']}'),
            Text(
              '￥${recommendList[index]['price']}',
              style: TextStyle(
              decoration: TextDecoration.lineThrough,
                color:Colors.grey
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(420),
      margin: EdgeInsets.fromLTRB(0, 10.0, 0, 0),
      child:Column(
        children: <Widget>[
          _buildTitle(),
          Container(
            height:ScreenUtil().setHeight(360) ,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount:recommendList.length ,
              itemBuilder: (context,index){
                return _buildItem(context,index);
              },
            ) ,
          ),
         
        ],
      ),
      
    );
  }
}

