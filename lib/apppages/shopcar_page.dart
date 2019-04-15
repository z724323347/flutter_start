import 'package:flutter/material.dart';

import 'package:provide/provide.dart';
import '../provide/cart_goodslist_provide.dart';
import './cart/cart_item.dart';
import './cart/cart_bottom.dart';

import '../util/sp_utils.dart';

import '../provide/counter.dart';



class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CartShopping'),
      ),
      body: FutureBuilder(
        future: _getCartInfo(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List cartList = Provide.value<CartGoodListProvide>(context).cartInfoList;

            return Stack(
              children: <Widget>[
                ListView.builder(
                  itemCount: cartList.length,
                  itemBuilder: (context, index){
                    return CartItem(cartList[index]);
                  },
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: CartBottomCell(),
                )
              ],
            );
            // return ListView.builder(
            //   itemCount: cartList.length,
            //   itemBuilder: (context, index){
            //     return CartItem(cartList[index]);
            //     // return ListTile(
            //     //   title: Text(cartList[index].goodsName),
            //     // );
            //   },
            // );
          }else {
            return Text('正在加载');

          }
          
        },
      ),
    );
  }

  Future<String> _getCartInfo(BuildContext context) async{
    await Provide.value<CartGoodListProvide>(context).getCartGoodsInfo();
    return 'end';
  }
}






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

// class CartPage extends StatefulWidget {
//   CartPage();

//   _CartPageState createState() => _CartPageState();
// }

// class _CartPageState extends State<CartPage> {

//   List<String> textList = [];
//   String tempText = '';

//   @override
//   Widget build(BuildContext context) {
//     _show();
//     return Container(
//       child: Column(
//         children: <Widget>[
//           Container(
//             height: 500,
//             child: ListView.builder(
//               itemCount: textList.length,
//               itemBuilder: (context,index) {
//                 return ListTile(
//                   title: Text(
//                     // textList[index]
//                     tempText
//                   ),
//                 );
//               },
//             ),
//           ),

//           RaisedButton(
//             onPressed: (){
//               _add();
//             },
//             child: Text('add'),
//           ),

//           RaisedButton(
//             onPressed: (){
//               _clear();
//             },
//             child: Text('clear'),
//           ),
//         ],
//       ),
//     );
//   }

//   //add
//   void _add() async {
//     var sp = await SpUtil().init;

//     String temp = 'SharedPreferences demo ~!';
//     textList.add(temp);
//     sp.setStringList('key1', textList);
//     _show();
//   }

//   //_clear
//   void _clear() async {
//     var sp = await SpUtil().init ;
//     sp.remove('key1');
//     // sp.clear();
//     setState(() {
//      textList = []; 
//     });

//   }

//   //_show
//   void _show() async {
//     var sp = await SpUtil().init ;
//     // if (sp.getStringList('key1') != null) {
//     //   setState(() {
//     //    textList = sp.getStringList('key1');
//     //   });
//     // }
//     if(sp.getString('cartInfo') != null) {
//       setState(() {
//        tempText = sp.getString('cartInfo'); 
//       });
//     }
//   }

// }


