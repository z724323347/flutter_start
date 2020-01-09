import 'package:extended_text/extended_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pro/pages/demo/special_text/my_extended_text_selection_controls.dart';
import 'package:flutter_pro/pages/demo/special_text/my_special_text_span_builder.dart';
import 'package:url_launcher/url_launcher.dart';

class ExtendTextDemo extends StatefulWidget {
  @override
  _ExtendTextDemoState createState() => _ExtendTextDemoState();
}

class _ExtendTextDemoState extends State<ExtendTextDemo> {
  MyExtendedMaterialTextSelectionControls
      _myExtendedMaterialTextSelectionControls;
  final String _attachContent =
      "[love]Extended text help you to build rich text quickly. any special text you will have with extended text.It's my pleasure to invite you to join \$web_browser\$ if you want to improve flutter .[love] if you meet any problem, please let me konw @email .[sun_glasses]";

  @override
  void initState() {
    _myExtendedMaterialTextSelectionControls = MyExtendedMaterialTextSelectionControls();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ExtendTextDemo'),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.grey[300],
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: ExtendedText(
                _attachContent,
                onSpecialTextTap: (dynamic parameter) {
                  if (parameter.startsWith("\$")) {
                    launch("https://github.com/z724323347/flutter_start.");
                  } else if (parameter.startsWith("@")) {
                    launch("mailto:724323347@qq.com");
                  }
                },
                specialTextSpanBuilder: MySpecialTextSpanBuilder(),
                style: TextStyle(fontSize: 14, color: Colors.grey),
                maxLines: 10,
                overflow: TextOverflow.ellipsis,
                selectionEnabled: true,
                // textSelectionControls: _myExtendedMaterialTextSelectionControls,
              ),
            )
          ],
        ),
      ),
    );
  }
}
