import 'package:flutter/material.dart';

class NestedScrollDemoPage extends StatelessWidget {
  final _tabs = <String>['TabA', 'TabB'];
  final colors = <Color>[Colors.red, Colors.green, Colors.blue, Colors.pink, Colors.yellow, Colors.deepPurple];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
          length: _tabs.length,
          child: NestedScrollView(
              headerSliverBuilder: (context, innerScrolled) => <Widget>[
                    SliverOverlapAbsorber(
                      // 传入 handle 值，直接通过 `sliverOverlapAbsorberHandleFor` 获取即可
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                      child: SliverAppBar(
                        pinned: true,
                        // // 设置该属性，当有下滑手势的时候，就会显示 AppBar
                        // floating: true,
                        // // 该属性只有在 floating 为 true 的情况下使用，不然会报错
                        // // 当上滑到一定的比例，会自动把 AppBar 收缩（不知道是不是 bug，当 AppBar 下面的部件没有被 AppBar 覆盖的时候，不会自动收缩）
                        // // 当下滑到一定比例，会自动把 AppBar 展开
                        // snap: true,
                        title: Text('NestedScroll',style: TextStyle(color: Colors.white)),
                        iconTheme: IconThemeData(color: Colors.white),
                        expandedHeight: 300.0,
                        automaticallyImplyLeading: true,
                        
                        flexibleSpace: FlexibleSpaceBar(
                          background: Image.network('http://qukufile2.qianqian.com/data2/pic/82f18658afb324539af546dab197d81f/612985429/612985429.jpg@s_2,w_1000,h_1000', fit: BoxFit.cover),
                          //背景折叠动画
                          collapseMode: CollapseMode.parallax,
                          ),
                        bottom: TabBar(
                          tabs: _tabs.map((tab) => Text(tab, style: TextStyle(fontSize: 18.0,color: Colors.white))).toList(),
                          indicatorColor: Colors.black,
                          ),
                        // 强制显示阴影
                        forceElevated: innerScrolled,
                      ),
                    )
                  ],
              body: TabBarView(
                  children: _tabs
                      // 这边需要通过 Builder 来创建 TabBarView 的内容，否则会报错
                      // NestedScrollView.sliverOverlapAbsorberHandleFor must be called with a context that contains a NestedScrollView.
                      .map((tab) => Builder(
                            builder: (context) => CustomScrollView(
                                  // key 保证唯一性
                                  key: PageStorageKey<String>(tab),
                                  slivers: <Widget>[
                                    // 将子部件同 `SliverAppBar` 重叠部分顶出来，否则会被遮挡
                                    SliverOverlapInjector(
                                        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
                                    SliverGrid(
                                        delegate: SliverChildBuilderDelegate(
                                            (_, index) => Image.network('http://wimg.spriteapp.cn/profile/large/2017/03/02/58b82b8a4b633_mini.jpg'),
                                            childCount: 4),
                                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 4, mainAxisSpacing: 10.0, crossAxisSpacing: 10.0)
                                            ),
                                    SliverFixedExtentList(
                                        delegate: SliverChildBuilderDelegate(
                                            (_, index) => Container(
                                                child: Text('$tab - item${index + 1}',
                                                    style: TextStyle(fontSize: 20.0, color: colors[index % 6])),
                                                alignment: Alignment.center),
                                            childCount: 15),
                                        itemExtent: 50.0)
                                  ],
                                ),
                          ))
                      .toList()
                  )
            )
        ),
    );
  }
}