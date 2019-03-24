import 'package:flutter/material.dart';

import 'package:provide/provide.dart';
import '../provide/counter.dart';


class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Number(),
            ButtonAdd()
          ],
        ),
      ),
    );
  }
}


class Number extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 200),
      child: Provide<Counter>(
        builder: (context, child, counter) {
          return Text(
            '${counter.value}',
            style: TextStyle(fontSize: 20),);
        },
      ),
    );
  }
}

class ButtonAdd extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        onPressed: () {
          //修改状态管理
          Provide.value<Counter>(context).increment();
        },
        child: Text('Provide 状态管理'),
      ),
    );
  }
}