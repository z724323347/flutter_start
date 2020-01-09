import 'package:flutter/material.dart';
import 'package:flutter_pro/global/global.dart';


class CommonFun{
  static BuildContext context = GlobalNavigator.navigatorKey.currentState.overlay.context;
  static OverlayState overlayState = GlobalNavigator.navigatorKey.currentState.overlay;

  static toast(String message, {int time ,ToastPosition position}){
    // Toast.show(overlayState, message, time ,position);
    Toast.show( message,time: time,position: position);
  }
}

//Toast 显示位置控制
enum ToastPosition {
  top,
  center,
  bottom,
}

class Toast {
  static ToastView preToast;
  // 显示位置
  static ToastPosition _p;
  static show( String msg,
      {int time, ToastPosition position}) {
    preToast?.dismiss();
    preToast = null;
    _p = position != null ? position : ToastPosition.bottom;
    OverlayState overlayState =  GlobalNavigator.navigatorKey.currentState.overlay;

    var controllerShowAnim = new AnimationController(
      vsync: overlayState,
      duration: Duration(milliseconds: 250),
    );
    var controllerShowOffset = new AnimationController(
      vsync: overlayState,
      duration: Duration(milliseconds: 350),
    );
    var controllerHide = new AnimationController(
      vsync: overlayState,
      duration: Duration(milliseconds: 250),
    );
    var opacityAnim1 =
        new Tween(begin: 0.0, end: 1.0).animate(controllerShowAnim);
    var controllerCurvedShowOffset = new CurvedAnimation(
        parent: controllerShowOffset, curve: _BounceOutCurve._());
    var offsetAnim =
        new Tween(begin: 30.0, end: 0.0).animate(controllerCurvedShowOffset);
    var opacityAnim2 = new Tween(begin: 1.0, end: 0.0).animate(controllerHide);

    OverlayEntry overlayEntry;
    overlayEntry = new OverlayEntry(builder: (context) {
      return ToastWidget(
        opacityAnim1: opacityAnim1,
        opacityAnim2: opacityAnim2,
        offsetAnim: offsetAnim,
        child: buildToastLayout(msg, _p),
      );
    });
    var toastView = ToastView();
    toastView.overlayEntry = overlayEntry;
    toastView.controllerShowAnim = controllerShowAnim;
    toastView.controllerShowOffset = controllerShowOffset;
    toastView.controllerHide = controllerHide;
    toastView.overlayState = overlayState;
    preToast = toastView;
    toastView._show(time);
  }

  static LayoutBuilder buildToastLayout(String msg, ToastPosition p) {
    return LayoutBuilder(builder: (context, constraints) {
      return IgnorePointer(
        ignoring: true,
        child: Container(
          child: Material(
            color: Colors.white.withOpacity(0),
            child: Container(
              child: Container(
                child: Text(
                  "${msg.toString()}",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              ),
              margin: EdgeInsets.only(
                top: p == ToastPosition.top
                    ? constraints.biggest.height * 0.15
                    : 0,
                bottom: constraints.biggest.height * 0.15,
                left: constraints.biggest.width * 0.2,
                right: constraints.biggest.width * 0.2,
              ),
            ),
          ),
          alignment: setAlignment(p),
        ),
      );
    });
  }

  /// 设置toast位置
  static AlignmentGeometry setAlignment(ToastPosition postion) {
    if (postion == ToastPosition.top) {
      return Alignment.topCenter;
    } else if (postion == ToastPosition.center) {
      return Alignment.center;
    } else {
      return Alignment.bottomCenter;
    }
  }
}

class ToastView {
  OverlayEntry overlayEntry;
  AnimationController controllerShowAnim;
  AnimationController controllerShowOffset;
  AnimationController controllerHide;
  OverlayState overlayState;
  bool dismissed = false;

  _show([time]) async {
    overlayState.insert(overlayEntry);
    controllerShowAnim.forward();
    controllerShowOffset.forward();
    await Future.delayed(Duration(milliseconds: time == null ? 2000 : time));
    this.dismiss();
  }

  dismiss() async {
    if (dismissed) {
      return;
    }
    this.dismissed = true;
    controllerHide.forward();
    await Future.delayed(Duration(milliseconds: 250));
    overlayEntry?.remove();
  }
}

class ToastWidget extends StatelessWidget {
  final Widget child;
  final Animation<double> opacityAnim1;
  final Animation<double> opacityAnim2;
  final Animation<double> offsetAnim;

  ToastWidget(
      {this.child, this.offsetAnim, this.opacityAnim1, this.opacityAnim2});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: opacityAnim1,
      child: child,
      builder: (context, child_to_build) {
        return Opacity(
          opacity: opacityAnim1.value,
          child: AnimatedBuilder(
            animation: offsetAnim,
            builder: (context, _) {
              return Transform.translate(
                offset: Offset(0, offsetAnim.value),
                child: AnimatedBuilder(
                  animation: opacityAnim2,
                  builder: (context, _) {
                    return Opacity(
                      opacity: opacityAnim2.value,
                      child: child_to_build,
                    );
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class _BounceOutCurve extends Curve {
  const _BounceOutCurve._();

  @override
  double transform(double t) {
    t -= 1.0;
    return t * t * ((2 + 1) * t + 2) + 1.0;
  }
}
