import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';


import 'package:flutter_pro/config/service_method.dart';
import 'package:flutter_pro/util/toast.dart';
import 'package:flutter_pro/model/category_goodslist_model.dart';
import '../provide/category_goodslist_provide.dart';
import '../provide/category_provide.dart';


//商品列表
class CategoryGoodsList extends StatefulWidget {
  @override
  _CategoryGoodsListState createState() => _CategoryGoodsListState();
}


class _CategoryGoodsListState extends State<CategoryGoodsList> {
  // List list = [];

  GlobalKey<RefreshFooterState> _globalKey = new GlobalKey<RefreshFooterState>();

  var scorllController = new ScrollController();
   @override
  void initState() {
    // _getGoodList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provide<CategoryGoodsListProvide>(
      builder: (context, child, data) {

        try {
          if (Provide.value<CategoryProvide>(context).page == 1){
            //列表位置位于最顶上
            scorllController.jumpTo(0.0);
          }
        } catch (e) {
          print('进入页面第一次初始化 ： ${e.toString()}');
        }

        if(data.goodsList.length >0) {
          return Expanded(
            child: Container(
              width: ScreenUtil().setWidth(570),
              child: EasyRefresh(
                //上拉加载
                refreshFooter: ClassicsFooter(
                  key: _globalKey,
                  bgColor:Colors.white,
                  textColor: Colors.pink,
                  moreInfoColor: Colors.pink,
                  showMore: true,
                  noMoreText: Provide.value<CategoryProvide>(context).noMoreText,
                  moreInfo: '加载中',
                  loadReadyText:'上拉加载....'
                ),
                child: ListView.builder(
                  controller: scorllController,
                  itemCount: data.goodsList.length,
                  itemBuilder: (context,index) {
                    return buildItem(data.goodsList ,index);
                    },
                ),
                loadMore: ()async {
                  Toast.showCenter('上拉加载更多...');
                  _getMoreList();
                },

              )
              
              
            ),
          );
        } else {
          return Center(
            child: Text('暂无产品数据'),
          );
        }
      },

    );
    
    
  }

void _getMoreList() async {
  Provide.value<CategoryProvide>(context).addPage();
    var data = {
      'categoryId':Provide.value<CategoryProvide>(context).categoryId,
      'categorySubId':Provide.value<CategoryProvide>(context).subId,
      'page':Provide.value<CategoryProvide>(context).page,
    };

    await request('getMallGoods',formData:data).then((val){
      var data = json.decode(val.toString());

      CategoryGoodsListModel goodsList =  CategoryGoodsListModel.fromJson(data);

      if (goodsList.data == null) {
        Provide.value<CategoryProvide>(context).changeLoadingText('没有更多数据');
      } else {
        Provide.value<CategoryGoodsListProvide>(context).getMoreGoodsList(goodsList.data);
      }
    });
  }


  Widget buildImage(List newList , int index) {
    return Container(
      width: ScreenUtil().setWidth(200),
      child: Image.network(newList[index].image),
    );
  }

  Widget buildName(List newList ,int index) {
    return Container(
      padding: EdgeInsets.all(5.0),
      width: ScreenUtil().setWidth(350),
      child: Text(
        newList[index].goodsName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style:TextStyle(fontSize: ScreenUtil().setSp(24))
      ),
    );
  }

  Widget buildPrice(List newList ,int index) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      width: ScreenUtil().setWidth(350),
      child: Row(
        children: <Widget>[
          Text(
            '价格￥ ${newList[index].presentPrice}',
            style: TextStyle(color: Colors.pink, fontSize: ScreenUtil().setSp(26)),
          ),
          Text(
            '价格￥ ${newList[index].oriPrice}',
            style: TextStyle(color: Colors.black12, decoration: TextDecoration.lineThrough, fontSize: ScreenUtil().setSp(20)),
          ),
        ],
      ),
    );
  }

  Widget buildItem(List newList ,int index) {
    return InkWell(
      onTap: () {
        Toast.showCenter('onTap :  ${index}');
      },
      child: Container(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(width: 1, color: Colors.black12)
          )
        ),
        child: Row(
          children: <Widget>[
            buildImage(newList,index),
            Column(
              children: <Widget>[
                buildName(newList,index),
                buildPrice(newList,index)
              ],
            )
          ],
        ),
      ),
    );
  }


}