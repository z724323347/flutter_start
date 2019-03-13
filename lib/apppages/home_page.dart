import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

import '../config/http_header.dart';
import '../config/service_method.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import '../util/toast.dart';
import 'part_lead_phone.dart';
import 'part_recommend.dart';
import 'part_floor.dart';
import 'part_hot_goods.dart';

class HomePage extends StatefulWidget {
  final Widget child;

  HomePage({Key key, this.child}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin{

  String homePageContent = '正在请求数据  ...';

  @override
  void initState() {
    // TODO: implement initState
    getHomePageContent().then((val){
      setState(() {
       homePageContent =val.toString();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AppBar'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getHomePageContent(),
        builder: (context,snapshot){
          if (snapshot.hasData) {
            var data=json.decode(snapshot.data.toString());
            List<Map> swiperDataList = (data['data']['slides'] as List).cast(); // 顶部轮播组件数
            List<Map> navigatorList = (data['data']['category'] as List).cast(); // item gridview
            String advertesPicture = data['data']['advertesPicture']['PICTURE_ADDRESS']; //广告图片
            String  leaderImage= data['data']['shopInfo']['leaderImage'];  //店长图片
            String  leaderPhone = data['data']['shopInfo']['leaderPhone']; //店长电话 
            List<Map> recommendList = (data['data']['recommend'] as List).cast(); // 商品推荐

            String floor1Title =data['data']['floor1Pic']['PICTURE_ADDRESS'];//楼层1的标题图片
            String floor2Title =data['data']['floor2Pic']['PICTURE_ADDRESS'];//楼层1的标题图片
            String floor3Title =data['data']['floor3Pic']['PICTURE_ADDRESS'];//楼层1的标题图片
            List<Map> floor1 = (data['data']['floor1'] as List).cast(); //楼层1商品和图片 
            List<Map> floor2 = (data['data']['floor2'] as List).cast(); //楼层1商品和图片 
            List<Map> floor3 = (data['data']['floor3'] as List).cast(); //楼层1商品和图片

            // return SingleChildScrollView(
            //   child: Column(
            //     children: <Widget>[
            //        SwiperDiy(swiperDataList:swiperDataList ),   //页面顶部轮播组件
            //        TopNavigator(navigatorList: navigatorList),  // item gridview
            //        AdBanner(advertesPicture:advertesPicture),   //广告组件  
            //        LeaderPhone(leaderImage:leaderImage,leaderPhone: leaderPhone),  //广告组件 
            //        Recommend(recommendList:recommendList),     //商品推荐 
            //        //
            //        FloorTitle(picture_address:floor1Title),
            //        FloorContent(floorGoodsList:floor1),
            //        FloorTitle(picture_address:floor2Title),
            //        FloorContent(floorGoodsList:floor2),
            //        FloorTitle(picture_address:floor3Title),
            //        FloorContent(floorGoodsList:floor3),
            //        HotGoods(),
            //     ]
            //   ),
            // );
            return EasyRefresh(
              child: ListView(
                   children: <Widget>[
                   SwiperDiy(swiperDataList:swiperDataList ),   //页面顶部轮播组件
                   TopNavigator(navigatorList: navigatorList),  // item gridview
                   AdBanner(advertesPicture:advertesPicture),   //广告组件  
                   LeaderPhone(leaderImage:leaderImage,leaderPhone: leaderPhone),  //广告组件 
                   Recommend(recommendList:recommendList),     //商品推荐 
                   //
                   FloorTitle(picture_address:floor1Title),
                   FloorContent(floorGoodsList:floor1),
                   FloorTitle(picture_address:floor2Title),
                   FloorContent(floorGoodsList:floor2),
                   FloorTitle(picture_address:floor3Title),
                   FloorContent(floorGoodsList:floor3),
                   HotGoods(),
                ]
              ),
              loadMore: () async {
                print('开始加载更多');
                HotGoods.getHotGoods();
              },
              refreshFooter: ClassicsFooter(
                key: GlobalKey(),
                bgColor:Colors.white,
                textColor: Colors.pink,
                moreInfoColor: Colors.pink,
                showMore: true,
                noMoreText: '',
                moreInfo: '加载中',
                loadReadyText:'上拉加载....'
              ),
            );
          } else {
            return Center(
              child: Text('加载中'),
            );
          }
        },
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  
}

class _footerKey {
}

// 首页轮播组件编写
class SwiperDiy extends StatelessWidget {

  final List swiperDataList;
  SwiperDiy({Key key,this.swiperDataList}):super(key:key);

  @override
  Widget build(BuildContext context) {

    return Container(
      height: ScreenUtil().setHeight(333),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        itemBuilder: (BuildContext context,int index){
          return Image.network("${swiperDataList[index]['image']}",fit:BoxFit.fill);
        },
        itemCount: swiperDataList.length,
        pagination: new SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}

// Navigator
class TopNavigator extends StatelessWidget {
  final List navigatorList;

  TopNavigator({Key key, this.navigatorList}) : super(key: key);

  Widget _gridViewItem(BuildContext context, item) {
    return InkWell(
      onTap: () {
        Toast.showCenter(item['mallCategoryName']);
      },
      child: Column(
        children: <Widget>[
          Image.network(item['image'], width:ScreenUtil().setWidth(80)),
          Text(item['mallCategoryName']),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (navigatorList.length > 10) {
      navigatorList.removeRange(10, navigatorList.length);
    }
    return Container(
      height: ScreenUtil().setHeight(320),
      padding: EdgeInsets.all(3.0),
      child: GridView.count(
        crossAxisCount: 5,
        padding: EdgeInsets.all(5.0),
        children: navigatorList.map((item) => _gridViewItem(context, item)).toList(),
      ),
    );
  }
}

//广告图片
class AdBanner extends StatelessWidget {
  final String advertesPicture;
  AdBanner({Key key, this.advertesPicture}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(advertesPicture),
    );
  }
}