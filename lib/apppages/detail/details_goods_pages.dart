import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_pro/provide/details_info_provide.dart';
import './details_cell_top.dart';
import './details_cell_explain.dart';
import './details_cell_tabbar.dart';
import './details_web.dart';


class GoodsDetailsPage extends StatelessWidget {
  final String goodsId;

  GoodsDetailsPage(this.goodsId);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(

      body: new CustomScrollView(
        slivers: <Widget>[
          new SliverAppBar(
            leading: GestureDetector(
              child: Icon(Icons.arrow_back),
              onTap: () => Navigator.pop(context),
            ), //左侧按钮
            
            automaticallyImplyLeading: true,
            // title: Text('大标题'), //标题
            centerTitle: true, //标题是否居中
            // actions: [Icon(Icons.archive)], //右侧的内容和点击事件啥的
            elevation: 4, //阴影的高度
            forceElevated: false, //是否显示阴影
            // backgroundColor: Colors.white, //背景颜色
            brightness: Brightness.dark, //黑底白字，lignt 白底黑字
            iconTheme: IconThemeData(
                color: Colors.white,
                size: 30,
                opacity: 1), //所有的icon的样式,不仅仅是左侧的，右侧的也会改变
            textTheme: TextTheme(), //字体样式
            primary: true, // appbar是否显示在屏幕的最上面，为false是显示在最上面，为true就显示在状态栏的下面
            titleSpacing: 16, //标题两边的空白区域
            expandedHeight: 120.0, //默认高度是状态栏和导航栏的高度，如果有滚动视差的话，要大于前两者的高度
            floating: false, //滑动到最上面，再滑动是否隐藏导航栏的文字和标题等的具体内容，为true是隐藏，为false是不隐藏
            pinned: true, //是否固定导航栏，为true是固定，为false是不固定，往上滑，导航栏可以隐藏
            snap:
                false, //只跟floating相对应，如果为true，floating必须为true，也就是向下滑动一点儿，整个大背景就会动画显示全部，网上滑动整个导航栏的内容就会消失
            flexibleSpace: new FlexibleSpaceBar(
              title: new Text("商品详情"),
              background: Image.network('http://qukufile2.qianqian.com/data2/pic/82f18658afb324539af546dab197d81f/612985429/612985429.jpg@s_2,w_1000,h_1000', fit: BoxFit.cover),
              //背景折叠动画
              collapseMode: CollapseMode.parallax,
              centerTitle: true,
            ),
          ),

          // Container(
          //   child: Center(
          //     child: Text('goodsId : ${goodsId}'),
          //   ),
          // ),

          new SliverFixedExtentList(
            itemExtent: 1600.0,
            delegate:
              SliverChildBuilderDelegate((content ,index) {
                return FutureBuilder(
                  future: getBackInfo(context),
                  builder: (context,snapshot){
                    if(snapshot.hasData){
                      return Container(
                        child: ListView(
                          children: <Widget>[
                            DetailsTopCell(),
                            DetailsExplinCell(),
                            DetailsTabBarCell(),
                            DetailsWebCell(),
                            Container(
                              width: ScreenUtil().setWidth(750),
                              padding: EdgeInsets.all(10.0),
                              alignment: Alignment.center,
                              child: Text('完成加载 这是底线: ${snapshot.data}'),
                            )
                            
                          ],
                        ),
                      );
                    } else {
                      return Container(
                        child: Center(
                          child: Text('加载失败 : ${goodsId}'),
                        ),
                      );
                    }
                  },

                );

                // return Container(
                //   alignment: Alignment.center,
                //   child: InkWell(
                //     onTap: (){

                //     },
                //     child: Column(
                //       children: <Widget>[
                //         Padding(
                //           padding: const EdgeInsets.all(0.0),
                //           child: Text('goodsId : ${goodsId}'),
                //         )
                //       ],
                //     ),
                //   ),
                // );
        
              },childCount: 1),
              
          ),
        ],
      ),
      
      
    );
  }

  Future getBackInfo(BuildContext context) async{
    await Provide.value<DetailsInfoProvide>(context).getGoodsInfo(goodsId);
    // return 'responseData : {code: 0, message: success, data: {data:datas}';
    return 'ok';
  }
}