import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';


import '../provide/current_page_provide.dart';
import 'home_page.dart';
import 'category_page.dart';
import 'shopcar_page.dart';
import 'profile_page.dart';


class IndexPage extends StatelessWidget {
  final List<BottomNavigationBarItem> itemTabs = [
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.home),
      title: Text('首页')
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.search),
      title: Text('分类')
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.shopping_cart),
      title: Text('购物')
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.profile_circled),
      title: Text('会员')
    ),
  ];

  final List<Widget> tabBodies = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);

    return Provide<CurrentPageProvide>(
      builder: (context,child, val){
        int currentIndex =Provide.value<CurrentPageProvide>(context).currentIndex;
        return Scaffold(
          backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: currentIndex,
            items: itemTabs,
            onTap: (index){
              Provide.value<CurrentPageProvide>(context).changIndex(index);
            },
          ),
          body: IndexedStack(
            index: currentIndex,
            children: tabBodies,
          ),
        );
      },
    );

   
  
  }
}

// class IndexPage extends StatefulWidget {
//   _IndexPageState createState() => _IndexPageState();
// }

// class _IndexPageState extends State<IndexPage> {

//   final List<BottomNavigationBarItem> itemTabs = [
//     BottomNavigationBarItem(
//       icon: Icon(CupertinoIcons.home),
//       title: Text('首页')
//     ),
//     BottomNavigationBarItem(
//       icon: Icon(CupertinoIcons.search),
//       title: Text('分类')
//     ),
//     BottomNavigationBarItem(
//       icon: Icon(CupertinoIcons.shopping_cart),
//       title: Text('购物')
//     ),
//     BottomNavigationBarItem(
//       icon: Icon(CupertinoIcons.profile_circled),
//       title: Text('会员')
//     ),
//   ];

//   final List<Widget> tabBodies = [
//     HomePage(),
//     CategoryPage(),
//     CartPage(),
//     ProfilePage()
//   ];

//   int currentIndex = 0;

//   var currentPage ;

//   @override
//   void initState() {
//     // TODO: implement initState
//     currentPage = tabBodies[currentIndex];
//     super.initState();
//   }



//   @override
//   Widget build(BuildContext context) {

//     ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);

//     return Scaffold(
//       backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         currentIndex: currentIndex,
//         items: itemTabs,
//         onTap: (index){
//           setState(() {
//            currentIndex =index;
//            currentPage =tabBodies[index]; 
//           });

//         },
//       ),
//       body: IndexedStack(
//         index: currentIndex,
//         children: tabBodies,
//       ),
//     );
//   }
// }