import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class CameraTestPage extends StatefulWidget {
  @override
  _CameraTestPageState createState() => _CameraTestPageState();
}

class _CameraTestPageState extends State<CameraTestPage> {
  var _image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('showImagePicker'),
      ),
      body: Column(
        children: <Widget>[
          CupertinoActionSheetAction(
              onPressed: () {
                showImagePicker(1);
              },
              child: Text('相机')),
          CupertinoActionSheetAction(
              onPressed: () {
                _showDialog(context);
              },
              child: Text('Images Dialog')),
          Expanded(
            flex: 1,
            child: _image == null ? Container() : Image.file(_image),
          )
        ],
      ),
    );
  }

  void _showDialog(BuildContext cxt) {
    showCupertinoModalPopup<int>(
        context: cxt,
        builder: (cxt) {
          var dialog = CupertinoActionSheet(
            title: Text("请选择"),
            cancelButton: CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.pop(cxt, 0);
                },
                child: Text("取消")),
            actions: <Widget>[
              CupertinoActionSheetAction(
                  onPressed: () {
                    showImagePicker(1);
                    Navigator.pop(cxt, 1);
                  },
                  child: Text('相机')),
              CupertinoActionSheetAction(
                  onPressed: () {
                    showImagePicker(2);
                    Navigator.pop(cxt, 2);
                  },
                  child: Text('相册')),
            ],
          );
          return dialog;
        });
  }

  Future showImagePicker(type) async {
    var image = await ImagePicker.pickImage(
        source: type == 1 ? ImageSource.camera : ImageSource.gallery);
    setState(() {
      print('image :  $image');
      _image = image;
      print(image);
    });
  }
}
