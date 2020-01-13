import 'package:flutter/material.dart';
import 'package:flutter_pro/pages/custom_route.dart';
import 'package:flutter_pro/pages/demo/paint/signature_page.dart';
import 'package:flutter_pro/util/sp_utils.dart';

class TestImageExpened extends StatefulWidget {
  @override
  _TestImageExpenedState createState() => _TestImageExpenedState();
}

class _TestImageExpenedState extends State<TestImageExpened> {
  double _width = 200.0; //通过修改图片宽度来达到缩放效果
  List s;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          Container(
            height: 300,
            child: Column(
              children: <Widget>[
                OutlineButton(
                  onPressed: () {
                    Set _s = SpUtil.getKeys();
                    setState(() {
                      s = _s.toList();
                    });
                    // SpUtil.putString('key_1', 'value');
                    print('object  ${SpUtil.getString('key_2')}');
                  },
                  child: Text('data'),
                ),
                Text('${s}'),
                RaisedButton(
                  child: Text('打开SignaturePainter!'),
                  onPressed: () {
                    Navigator.of(context).push(
                      CustomRoute(SignaturePage()),
                    );
                  },
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: GestureDetector(
              //指定宽度，高度自适应
              child: Image.asset("images/img/test_image.png", width: _width),
              onScaleUpdate: (ScaleUpdateDetails details) {
                setState(() {
                  //缩放倍数在0.8到10倍之间
                  _width = 200 * details.scale.clamp(.5, 10.0);
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
