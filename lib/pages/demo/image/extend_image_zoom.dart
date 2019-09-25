import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pro/pages/demo/image/extend_photo_view.dart';
import 'package:flutter_pro/util/initScale.dart';

import '../../custom_route.dart';

class ZoomImageDemo extends StatefulWidget {
  @override
  _ZoomImageDemoState createState() => _ZoomImageDemoState();
}

class _ZoomImageDemoState extends State<ZoomImageDemo>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;
  Function animationListener;
  List<double> doubleTapScales = <double>[1.0, 2.5];
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 150), vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('ZoomImageDemo'),
            actions: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(CustomRoute(PhotoViewDemo()));
                },
                child: Center(
                  child: Text('Big Image'),
                ),
              )
            ],
          ),
          Expanded(
            flex: 1,
            child: LayoutBuilder(
              builder: (_, c) {
                Size size = Size(c.maxWidth, c.maxHeight);
                return ExtendedImage.network(
                  'https://photo.tuchong.com/4870004/f/298584322.jpg',
                  // 'images/appup/bg.png',
                  fit: BoxFit.contain,
                  mode: ExtendedImageMode.gesture,
                  initGestureConfigHandler: (state) {
                    double initialScale = 1.0;
                    if (state.extendedImageInfo != null &&
                        state.extendedImageInfo.image != null) {
                      initialScale = initScale(
                          size: size,
                          initialScale: initialScale,
                          imageSize: Size(
                              state.extendedImageInfo.image.width.toDouble(),
                              state.extendedImageInfo.image.height.toDouble()));
                    }
                    //eg.  缩放条件需满足 小于最小的缩放比例，大于最大的缩放比例
                    //minScale > animationMinScale  || maxScale < animationMaxScale
                    return GestureConfig(
                        minScale: 0.8,
                        animationMinScale: 0.7,
                        maxScale: 4.0,
                        animationMaxScale: 4.5,
                        speed: 1.0,
                        initialScale: initialScale,
                        inPageView: false);
                  },
                  onDoubleTap: (ExtendedImageGestureState state) {
                    ///you can use define pointerDownPosition as you can,
                    ///default value is double tap pointer down postion.
                    var pointerDownPosition = state.pointerDownPosition;
                    double begin = state.gestureDetails.totalScale;
                    double end;

                    //remove old
                    _animation?.removeListener(animationListener);

                    //stop pre
                    _animationController.stop();

                    //reset to use
                    _animationController.reset();

                    if (begin == doubleTapScales[0]) {
                      end = doubleTapScales[1];
                    } else {
                      end = doubleTapScales[0];
                    }

                    animationListener = () {
                      //print(_animation.value);
                      state.handleDoubleTap(
                          scale: _animation.value,
                          doubleTapPosition: pointerDownPosition);
                    };
                    _animation = _animationController
                        .drive(Tween<double>(begin: begin, end: end));

                    _animation.addListener(animationListener);

                    _animationController.forward();
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
