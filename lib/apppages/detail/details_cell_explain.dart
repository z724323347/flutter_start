import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../provide/details_info_provide.dart';


class DetailsExplinCell extends StatelessWidget {

  DetailsExplinCell();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 8.0),
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.all(10.0),
      child: Text(
        '说明：> 急速送达 > 正品保证',
        style:TextStyle(color: Colors.red, fontSize: ScreenUtil().setSp(24))
      ),
    );
  }
  
}