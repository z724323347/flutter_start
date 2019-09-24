import 'dart:async';
import 'dart:math';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pro/util/initScale.dart';

/**
 * 大图预览
 */
class BigImagePreviewPage extends StatefulWidget {
  @override
  _BigImagePreviewPageState createState() => _BigImagePreviewPageState();
}

class _BigImagePreviewPageState extends State<BigImagePreviewPage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;
  Function animationListener;
  List<double> doubleTapScales = <double>[1.0, 2.0];
  GlobalKey<ExtendedImageSlidePageState> slidePagekey =
      GlobalKey<ExtendedImageSlidePageState>();

  bool _showSwiper = true;
  // var rebuildIndex = StreamController<int>.broadcast();
  var rebuildSwiper = StreamController<bool>.broadcast();

  @override
  void initState() {
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 150), vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    Widget result = Material(
      color: Colors.transparent,
      shadowColor: Colors.transparent,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          ExtendedImage.network(
            'url',
            fit: BoxFit.contain,
            enableSlideOutPage: true,
            mode: ExtendedImageMode.gesture,
            heroBuilderForSlidingPage: (_result) {
              return Hero(
                tag: '',
                child: _result,
                flightShuttleBuilder: (BuildContext flightContext,
                    Animation<double> animation,
                    HeroFlightDirection flightDirection,
                    BuildContext fromHeroContext,
                    BuildContext toHeroContext) {
                  final Hero hero = flightDirection == HeroFlightDirection.pop
                      ? fromHeroContext.widget
                      : toHeroContext.widget;
                  return hero.child;
                },
              );
            },
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
              return GestureConfig(
                inPageView: false,
                initialScale: initialScale,
                maxScale: max(initialScale, 0.5),
                animationMaxScale: max(initialScale, 0.5),
                cacheGesture: false,
              );
            },
            // 图片双击事件处理
            onDoubleTap: (ExtendedImageGestureState state) {
              var pointerDownPosition = state.pointerDownPosition;
              double begin = state.gestureDetails.totalScale;
              double end;

              _animation?.removeListener(animationListener);
              _animationController.stop();
              _animationController.reset();

              if (begin == doubleTapScales[0]) {
                end = doubleTapScales[1];
              } else {
                end = doubleTapScales[0];
              }
              animationListener = () {
                state.handleDoubleTap(
                    scale: _animation.value,
                    doubleTapPosition: pointerDownPosition);
              };
              _animation = _animationController
                  .drive(Tween<double>(begin: begin, end: end));
              _animation.addListener(animationListener);
              _animationController.forward();
            },
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            // child: result,
          ),
        ],
      ),
    );

    result = ExtendedImageSlidePage(
      key: slidePagekey,
      child: result,
      slideAxis: SlideAxis.both,
      slideType: SlideType.onlyImage,
      onSlidingPage: (state) {
        var showSwiper = !state.isSliding;
        if (showSwiper != _showSwiper) {
          _showSwiper = showSwiper;
          rebuildSwiper.add(_showSwiper);
        }
      },
    );

    return result;
  }
}
