import 'package:flutter/material.dart';
import 'one_screen.dart';
import 'two_screen.dart';
import 'three_screen.dart';
import 'four_screen.dart';


class NavbottomBar extends StatefulWidget {
  _NavbottomBarState createState() => _NavbottomBarState();
}

class _NavbottomBarState extends State<NavbottomBar> {

  final _NavBarColor = Colors.blue;
  int _currentIndex = 0;
  List<Widget> pages = List();

  @override
  void initState() {
    // TODO: implement initState
    pages
      ..add(OneScreen(title: 'Native Method Deom'))
      ..add(TwoScreen())
      ..add(ThreeScreen())
      ..add(FourScreen());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: _NavBarColor
            ),
            title: Text(
              'home',
              style:TextStyle(color:_NavBarColor)
            )
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shop,
              color: _NavBarColor
            ),
            title: Text(
              'shop',
              style:TextStyle(color:_NavBarColor)
            )
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.sim_card,
              color: _NavBarColor
            ),
            title: Text(
              'card',
              style:TextStyle(color:_NavBarColor)
            )
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.multiline_chart,
              color: _NavBarColor
            ),
            title: Text(
              'chart',
              style:TextStyle(color:_NavBarColor)
            )
          ),
        ],
        currentIndex: _currentIndex,
        onTap: (int index){
          setState(() {
           _currentIndex = index; 
          });
        },
      ),
    );
  }
}