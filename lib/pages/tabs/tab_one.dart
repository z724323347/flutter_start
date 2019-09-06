import 'package:flutter/material.dart';

import 'package:flutter_pro/util/toast.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class TabViewOnePage extends StatefulWidget {

  _TabViewOnePageState createState() => _TabViewOnePageState();
}

class _TabViewOnePageState extends State<TabViewOnePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: buildItem()
    );
  }

  Widget buildItem() {

    return StaggeredGridView.countBuilder(
    crossAxisCount: 4,
    itemCount: 10,
    itemBuilder: (BuildContext context, int index) => new Container(
        color: Colors.green,
        child: InkWell(
          onTap: (){
            ToastUtil.showCenter(' 点击 =>  $index');
          },
          child: new Center(
            child: new CircleAvatar(
              backgroundColor: Colors.white,
              child: new Text('$index'),
            ),
          ),
        )
        ),
    staggeredTileBuilder: (int index) =>
        new StaggeredTile.count(2, index.isEven ? 2 : 1),
    mainAxisSpacing: 4.0,
    crossAxisSpacing: 4.0,
    );
  }
}




  