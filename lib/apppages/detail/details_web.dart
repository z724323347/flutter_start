import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../provide/details_info_provide.dart';

class DetailsWebCell extends StatelessWidget {

  DetailsWebCell();

  @override
  Widget build(BuildContext context) {

    var goodsDetails = Provide.value<DetailsInfoProvide>(context).goodsInfo.data.goodInfo.goodsDetail;

    return Provide<DetailsInfoProvide>(
      builder: (context,child,val){
        var isLeft = Provide.value<DetailsInfoProvide>(context).isLeft;
        if (isLeft) {
          return Container(
            
            // child: Text('$goodsDetails'),
            // Html ios未知原因暂无法加载，Android 正常加载
            child: Html(
              data: goodsDetails,
            ),
          );
        } else {
          return Container(
            width: ScreenUtil().setWidth(750),
            padding: EdgeInsets.all(10.0),
            alignment: Alignment.center,
            child: Text('暂无数据'),
          );
        }
      },
    );
    // Container(
    //   child: Text('$goodsDetails'),
    //   // child: Html(
    //   //   data: goodsDetails,
    //   // ),
    // );
  }
}
