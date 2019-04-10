import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:provide/provide.dart';
import '../provide/counter.dart';
import '../util/sp_utils.dart';


// class CartPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Cart'),
//       ),
//       body: Center(
//         child: Column(
//           children: <Widget>[
//             Number(),
//             ButtonAdd()
//           ],
//         ),
//       ),
//     );
//   }
// }

// class Number extends StatelessWidget {

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(top: 200),
//       child: Provide<Counter>(
//         builder: (context, child, counter) {
//           return Text(
//             '${counter.value}',
//             style: TextStyle(fontSize: 20),);
//         },
//       ),
//     );
//   }
// }

// class ButtonAdd extends StatelessWidget {

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: RaisedButton(
//         onPressed: () {
//           //修改状态管理
//           Provide.value<Counter>(context).increment();
//         },
//         child: Text('Provide 状态管理'),
//       ),
//     );
//   }
// }

class CartPage extends StatefulWidget {
  CartPage();

  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  List<String> textList = [];
  SharedPreferences sp;

  @override
  Widget build(BuildContext context) {
    _show();
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: 500,
            child: ListView.builder(
              itemCount: textList.length,
              itemBuilder: (context,index) {
                return ListTile(
                  title: Text(
                    textList[index]
                  ),
                );
              },
            ),
          ),

          RaisedButton(
            onPressed: (){
              _add();
            },
            child: Text('add'),
          ),

          RaisedButton(
            onPressed: (){
              _clear();
            },
            child: Text('clear'),
          ),
        ],
      ),
    );
  }

  //add
  void _add() async {
    sp = await SpUtil().sp;

    String temp = 'SharedPreferences demo ~!';
    textList.add(temp);
    sp.setStringList('key1', textList);
    _show();
  }

  //_clear
  void _clear() async {
    sp = await SpUtil().sp ;
    sp.remove('key1');
    // sp.clear();
    setState(() {
     textList = []; 
    });

  }

  //_show
  void _show() async {
    sp = await SpUtil().sp ;
    if (sp.getStringList('key1') != null) {
      setState(() {
       textList = sp.getStringList('key1');
      });
    }
  }

}


