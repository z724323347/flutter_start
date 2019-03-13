import 'package:flutter/material.dart'; 
import 'package:flutter_pro/config/service_method.dart';
import 'dart:convert';

import 'package:flutter_pro/model/category.dart';

class CategoryPage extends StatefulWidget {

  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {

    getCategory();

    return Scaffold(
      appBar: AppBar(
        title: Text('Category'),
      ),
      body: Center(
        child: Text("Category Page"),
      ),
    );
  }

  void getCategory()async{
    await request('getCategory').then((val){
          var data = json.decode(val.toString());
          // print('OK ===  ${data}');
          CategoryBigListModel listModel =CategoryBigListModel.formJson(data['data']);
          listModel.data.forEach((item)=>print(item.mallCategoryName));
    });
  }
}

