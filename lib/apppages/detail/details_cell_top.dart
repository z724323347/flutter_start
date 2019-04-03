import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../provide/details_info_provide.dart';

class DetailsTopCell extends StatelessWidget {
  final Widget child;

  DetailsTopCell({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provide<DetailsInfoProvide>(
      builder: (context,child,val){
        var goodsInfo = Provide.value<DetailsInfoProvide>(context).goodsInfo.data.goodInfo;
        
        if(goodsInfo != null) {
          return Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                _buildImage(goodsInfo.image1),
                _buildName(goodsInfo.goodsName),
                _buildNumber(goodsInfo.goodsSerialNumber)
              ],
            ),
          );
        } else {
          return Text('正在加载中~~~~~~~');
        }
      },
    );
  }

  Widget _buildImage(url) {
    return Image.network(
      url,
      width: ScreenUtil().setWidth(740),
      );
  }

  Widget _buildName(name) {
    return Container(
      width:ScreenUtil().setWidth(740),
      padding: EdgeInsets.only(left: 10.0),
      child: Text(
        name,
        style:TextStyle(
          fontSize: ScreenUtil().setSp(24)
        )
      ),
    );
  }

  Widget _buildNumber(number) {
    return Container(
      width: ScreenUtil().setWidth(730),
      padding: EdgeInsets.only(left: 10.0),
      margin: EdgeInsets.only(top: 8.0),
      child: Text(
        '编号: ${number}',
        style:TextStyle(
          color:Colors.black12
        )
      ),
    );
  }

  Widget _buildPrice(price,oldPrice) {
    return Container(
      width: ScreenUtil().setWidth(730),
      padding: EdgeInsets.only(left: 10.0),
      margin: EdgeInsets.only(top: 8.0),
      child: Row(
        children: <Widget>[
          Text('data: ${price}')
        ],
      ),
    );
  }



}