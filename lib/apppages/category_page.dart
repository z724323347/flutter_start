import 'package:flutter/material.dart';

import 'part_hot_goods.dart';
class CategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Category'),
      ),
      body: Center(
        // child: Text("Category Page"),
        child: HotGoods(),
      ),
    );
  }
}