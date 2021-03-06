import 'package:flutter/material.dart'; 
import 'package:flutter_pro/config/service_method.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provide/provide.dart';
import '../provide/category_provide.dart';
import '../provide/category_goodslist_provide.dart';

import 'package:flutter_pro/model/category.dart';
import 'package:flutter_pro/model/category_model.dart';
import 'package:flutter_pro/model/category_goodslist_model.dart';
import 'package:flutter_pro/util/toast.dart';
import './part_category_goodslist.dart';

class CategoryPage extends StatefulWidget {

  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> with AutomaticKeepAliveClientMixin{
  String strData  = '正在加载...';

 

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Category'),
      ),
      body: Container(
        child: Row(
          children: <Widget>[
            LeftCategoryNav(),
            Column(
              children: <Widget>[
                TopCategoryNav(),
                CategoryGoodsList()
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  
}

//左侧导航
class LeftCategoryNav extends StatefulWidget {

  _LeftCategoryNavState createState() => _LeftCategoryNavState();
}

class _LeftCategoryNavState extends State<LeftCategoryNav> {

  List list=[];
  var listIndex = 0; //添加当前索引

  @override
  void initState() {
    getCategory();
    _getGoodList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(180),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(width: 1,color: Colors.black12)
        )
      ),
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return leftInkWell(index);
        },
      ),
    );
  }

  Widget leftInkWell(int index) {

    bool isClick = false;
    isClick = (index ==listIndex) ? true :false;

    return InkWell(
      onTap: () {

        setState(() {
          listIndex =index;
        });

        // toast
        ToastUtil.showCenter(list[index].mallCategoryName);
        //点击 topnav 改变状态
        var childList = list[index].bxMallSubDto;
        var categoryId =list[index].mallCategoryId;
        Provide.value<CategoryProvide>(context).getChildCategory(childList,categoryId);

        // 可选参数传递 需key
        _getGoodList(categoryId: categoryId);
      },
      child: Container(
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only(left: 10, top: 20),
        decoration: BoxDecoration(
          // color: isClick ?  Colors.black12 :  Colors.white,
          color: isClick ? Color.fromRGBO(240, 240, 240, 1.0) :Colors.white,
          border: Border(
            bottom: BorderSide(width: 1,color: Colors.black12)
          ),
        ),
        child: Text(list[index].mallCategoryName,style: TextStyle(fontSize: ScreenUtil().setSp(28))),
      ),
    );
  }

  //数据请求
  void getCategory() async{
    await request('getCategory').then((val){
          var data = json.decode(val.toString());
          print('OK ===  ${data}');
          // CategoryBigListModel listModel =CategoryBigListModel.formJson(data['data']);
          // listModel.data.forEach((item)=>print(item.mallCategoryName));
          CategoryModel category =CategoryModel.fromJson(data);
          setState(() {
           list =category.data; 
          });
          //
          list.forEach((item) => print('item => ${item.mallCategoryName}'));

          //优化首次加载第一项数据不显示问题
          Provide.value<CategoryProvide>(context).getChildCategory(list[0].bxMallSubDto,list[0].mallCategoryId);
          
          
    });
  }

   void _getGoodList({String categoryId}) async {
    var data = {
      'categoryId':categoryId == null ? '4' : categoryId,
      'categorySubId':"",
      'page':1
    };

    await request('getMallGoods',formData:data).then((val){
      var data = json.decode(val.toString());

      CategoryGoodsListModel goodsList =  CategoryGoodsListModel.fromJson(data);

      ToastUtil.showCenter('------------------- ${goodsList.data[0].goodsName}');

      Provide.value<CategoryGoodsListProvide>(context).getGoodsList(goodsList.data);

      // setState(() {
      //  list =goodsList.data; 
      // });

      // print('分类商品列表：>>>>>>>>>>>>>>>>>> ${data}');
      // Toast.showCenter('分类商品列表：\n${data}');
    });
  }
  
}


//右侧顶部nav
class TopCategoryNav extends StatefulWidget {

  _TopCategoryNavState createState() => _TopCategoryNavState();
}

class _TopCategoryNavState extends State<TopCategoryNav> {

  // List list = ['全部','  1--','2---','3----','4---','5--','6-----'];
  
  @override
  Widget build(BuildContext context) {
    return Provide<CategoryProvide>(
      builder: (context, child, childCategory){
        return  Container(
            height: ScreenUtil().setHeight(80),
            width: ScreenUtil().setWidth(560),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(width: 1, color: Colors.black12)
              )
            ),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: childCategory.childList.length,
              itemBuilder: (context, index){
                return itemInkWell(index, childCategory.childList[index]);
              }
            ),
          );
      },
    );
    
  }

  Widget itemInkWell(int index , BxMallSubDto item) {

    bool isClick = false;

    isClick = (index == Provide.value<CategoryProvide>(context).childIndex ) ? true : false;
    return InkWell(
      onTap: (){
        Provide.value<CategoryProvide>(context).changeChildIndex(index,item.mallSubId);
        _getSubGoodList(item.mallSubId);
       ToastUtil.showCenter('sub item: ${item.mallSubName}');
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
        child: Text(
          item.mallSubName,
          style:TextStyle(
              fontSize:ScreenUtil().setSp(24),
              color: isClick? Colors.pink : Colors.black45
          )
        ),
      ),
    );
  }

  void _getSubGoodList(String categorySubId) async {
    var data = {
      'categoryId':Provide.value<CategoryProvide>(context).categoryId,
      'categorySubId':categorySubId,
      'page':1
    };

    await request('getMallGoods',formData:data).then((val){
      var data = json.decode(val.toString());

      CategoryGoodsListModel goodsList =  CategoryGoodsListModel.fromJson(data);

      if (goodsList.data == null) {
        Provide.value<CategoryGoodsListProvide>(context).getGoodsList([]);
      } else {
        Provide.value<CategoryGoodsListProvide>(context).getGoodsList(goodsList.data);
      }
    });
  }

}
