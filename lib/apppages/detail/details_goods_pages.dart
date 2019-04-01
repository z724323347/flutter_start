import 'package:flutter/material.dart';
import 'package:provide/provide.dart';

import 'package:flutter_pro/provide/details_info_provide.dart';


class GoodsDetailsPage extends StatelessWidget {
  final String goodsId;

  GoodsDetailsPage(this.goodsId);

  @override
  Widget build(BuildContext context) {
    getBackInfo(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '详情'
        ),
      ),
      body: Container(
        child: Center(
          child: Text(
            'goodsId : ${goodsId}'
          ),
        ),
      ),
    );
  }

  void getBackInfo(BuildContext context) async{
    await Provide.value<DetailsInfoProvide>(context).getGoodsInfo(goodsId);
    print('加载完成......');
  }
}