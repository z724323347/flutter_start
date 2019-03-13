import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_pro/config/service_method.dart';
import 'package:flutter_pro/util/toast.dart';

class HotGoods extends StatefulWidget {
  _HotGoodsState createState() => _HotGoodsState();

  static void getHotGoods() {}
}


class _HotGoodsState extends State<HotGoods> {
  
   void initState() { 
     super.initState();
      getHomePageBeloConten().then((val){
         print(val);
         Toast.showCenter(val);
      });

      getHotGoods();
      
   }

  @override
  Widget build(BuildContext context) {
    return Container(
       child:Column(
            children: <Widget>[
              hotTitle,
              wrapList(),
            ],
          )
    );
  }

  int page = 1;
  List<Map> hotGoodsList=[];
  //热门商品接口
  void getHotGoods() {

     var formPage={'page': page};
     request('homePageBelowConten',formData:formPage).then((val){
       var data=json.decode(val.toString());
       List<Map> newGoodsList = (data['data'] as List ).cast();
       setState(() {
         hotGoodsList.addAll(newGoodsList);
         page++; 
       });
     });
  }

  //热门专区标题
  Widget hotTitle= Container(
        margin: EdgeInsets.only(top: 10.0),
        padding:EdgeInsets.all(5.0),
        alignment:Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          border:Border(
            bottom: BorderSide(width:0.5 ,color:Colors.black12)
          )
        ),
        child: Text('火爆专区'),
   );


   //热门专区子项
  Widget wrapList(){
    if(hotGoodsList.length!=0){
       List<Widget> listWidget = hotGoodsList.map((val){
          return InkWell(
            onTap:(){Toast.showCenter('点击了热门商品');},
            child: 
            Container(
              width: ScreenUtil().setWidth(372),
              color:Colors.white,
              padding: EdgeInsets.all(5.0),
              margin:EdgeInsets.only(bottom:3.0),
              child: Column(
                children: <Widget>[
                  Image.network(val['image'],width: ScreenUtil().setWidth(375),),
                  Text(
                    val['name'],
                    maxLines: 1,
                    overflow:TextOverflow.ellipsis ,
                    style: TextStyle(color:Colors.pink,fontSize: ScreenUtil().setSp(26)),
                  ),
                  Row(
                    children: <Widget>[
                      Text('￥${val['mallPrice']}'),
                      Text(
                        '￥${val['price']}',
                        style: TextStyle(color:Colors.black26,decoration: TextDecoration.lineThrough),
                      )
                    ],
                  )
                ],
              ), 
            )
          );
      }).toList();
      return Wrap(
        spacing: 2,
        children: listWidget,
      );
    }else{
      return Text(' ');
    }
  }

}

  

  