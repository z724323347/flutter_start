import 'package:flutter/material.dart';
import 'package:flutter_pro/pages/demo/image/extend_crop_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PhotoViewDemo extends StatefulWidget {
  @override
  _PhotoViewDemoState createState() => _PhotoViewDemoState();
}

class _PhotoViewDemoState extends State<PhotoViewDemo> {
  @override
  Widget build(BuildContext context) {
    // final double margin = ScreenUtil.instance.setWidth(22);
    // return Material(
    //     child: Column(
    //   children: <Widget>[
    //     AppBar(
    //       title: Text('PhotoViewDemo'),
    //     ),
    //     Expanded(
    //         flex: 1,
    //         child: Column(
    //           children: <Widget>[
    //             Container(
    //               color: Colors.black12,
    //               width: 400,
    //               height: 300,
    //               child: CropImageItem(
    //                   imageUrl:
    //                       'https://photo.tuchong.com/4870004/f/298584322.jpg',
    //                   knowImageSize: false,
    //                   margin: 2.0),
    //             ),
    //           ],
    //         )),
    //   ],
    // ));

    return Material(
      child: Container(
        color: Colors.black12,
        width: 300,
        height: 400,
        child: CropImageItem(
            imageUrl: 'https://photo.tuchong.com/4870004/f/298584322.jpg',
            knowImageSize: false,
            margin: 2.0),
      ),
    );
  }
}
