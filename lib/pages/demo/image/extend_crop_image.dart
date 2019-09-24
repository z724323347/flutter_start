import 'dart:math';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pro/pages/custom_route.dart';
import 'dart:ui' as ui show Image;

import 'package:flutter_pro/pages/demo/image/extend_image_big.dart';

class CropImageItem extends StatefulWidget {
  final String imageUrl;
  final double margin;
  final bool knowImageSize;
  CropImageItem({this.imageUrl, this.knowImageSize, this.margin});
  @override
  _CropImageItemState createState() => _CropImageItemState(
      imageUrl: imageUrl, margin: margin, knowImageSize: knowImageSize);
}

class _CropImageItemState extends State<CropImageItem> {
  final String imageUrl;
  final double margin;
  final bool knowImageSize;
  _CropImageItemState({this.imageUrl, this.knowImageSize, this.margin});
  @override
  Widget build(BuildContext context) {
    print('imageUrl-----------$imageUrl');
    if (imageUrl == null && imageUrl == '') return Container();

    final double num300 = 300;
    final double num400 = 400;
    double height = num300;
    double width = num400;

    // if (knowImageSize) {
      var n = height / width;
      if (n >= 4 / 3) {
        width = num300;
        height = num400;
      } else if (4 / 3 > n && n > 3 / 4) {
        var maxValue = max(width, height);
        height = num400 * height / maxValue;
        width = num400 * width / maxValue;
      } else if (n <= 3 / 4) {
        width = num400;
        height = num300;
      }
    // }

    return Padding(
      padding: EdgeInsets.all(margin),
      child: ExtendedImage.network(
        imageUrl,
        fit: BoxFit.fill,
        width: width,
        height: height,
        loadStateChanged: (ExtendedImageState state) {
          Widget widget;
          switch (state.extendedImageLoadState) {
            case LoadState.loading:
              widget = Container(
                color: Colors.grey,
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  strokeWidth: 2.0,
                  valueColor:
                      AlwaysStoppedAnimation(Theme.of(context).primaryColor),
                ),
              );
              break;
            case LoadState.completed:
              state.returnLoadStateChangedWidget = !knowImageSize;
              widget = Hero(
                tag: imageUrl,
                child:
                    buildImage(state.extendedImageInfo.image, num300, num400),
              );
              break;
            case LoadState.failed:
              widget = GestureDetector(
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Image.asset(
                      'images/appup/close.png',
                      fit: BoxFit.fill,
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Text("load image failed, click to reload",
                          textAlign: TextAlign.center),
                    ),
                  ],
                ),
                onTap: () {
                  state.reLoadImage();
                },
              );
              break;
          }

          widget = GestureDetector(
            child: widget,
            onTap: () {
              Navigator.of(context).push(CustomRoute(BigImagePreviewPage()));
            },
          );
          return widget;
        },
      ),
    );
  }

  Widget buildImage(ui.Image image, double num300, double num400) {
    var n = image.height / image.width;
    if (n >= 4 / 3) {
      Widget imageWidget = ExtendedRawImage(
        image: image,
        width: num300,
        height: num400,
        fit: BoxFit.fill,
        soucreRect: Rect.fromLTWH(
            0.0, 0.0, image.width.toDouble(), 4 * image.width / 3),
      );
      if (n > 4) {
        imageWidget = Container(
          width: num300,
          height: num400,
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: imageWidget,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(2.0),
                  color: Colors.grey,
                  child: Text('long image',
                      style: TextStyle(color: Colors.white, fontSize: 10.0)),
                ),
              )
            ],
          ),
        );
      }
      return imageWidget;
    } else if (4 / 3 > n && n > 3 / 4) {
      var maxValue = max(image.width, image.height);
      var height = num400 * image.height / maxValue;
      var width = num400 * image.width / maxValue;
      return ExtendedRawImage(
        height: height,
        width: width,
        image: image,
        fit: BoxFit.fill,
      );
    } else if (n <= 3 / 4) {
      var width = 4 * image.width / 3;
      Widget imageWidget = ExtendedRawImage(
        image: image,
        width: num400,
        height: num300,
        fit: BoxFit.fill,
        soucreRect: Rect.fromLTWH(
            (image.width - width) / 2.0, 0.0, width, image.height.toDouble()),
      );

      if (n <= 1 / 4) {
        imageWidget = Container(
          width: num400,
          height: num300,
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 0,
                right: 0,
                left: 0,
                bottom: 0,
                child: imageWidget,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(2.0),
                  color: Colors.grey,
                  child: Text('long image',
                      style: TextStyle(color: Colors.white, fontSize: 10.0)),
                ),
              )
            ],
          ),
        );
      }
    }
    return Container();
  }
}
