import 'package:flutter/material.dart';


import 'package:provide/provide.dart';
import '../provide/counter.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Provide<Counter>(
        builder: (context, child, counter) {
          return Text(
            '${counter.value}',
            style: TextStyle(fontSize: 20),);
        },
      ),
      ),
    );
  }
}