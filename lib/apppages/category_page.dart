import 'package:flutter/material.dart'; 
import 'package:flutter_pro/config/service_method.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_pro/model/category.dart';
import 'package:flutter_pro/model/category_model.dart';
import 'package:flutter_pro/util/toast.dart';

class CategoryPage extends StatefulWidget {

  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
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
          ],
        ),
      ),
    );
  }

  
}

//左侧导航
class LeftCategoryNav extends StatefulWidget {

  _LeftCategoryNavState createState() => _LeftCategoryNavState();
}

class _LeftCategoryNavState extends State<LeftCategoryNav> {

  List list=[];

  @override
  void initState() {
    getCategory();
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
    return InkWell(
      onTap: () {
        // toast
        Toast.showCenter(list[index].mallCategoryName);
      },
      child: Container(
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only(left: 10, top: 20),
        decoration: BoxDecoration(
          color: Colors.white,
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
          list.forEach((item) => print('item => ${item.mallCategoryName}}'));
          
    });
  }
  
}

