import 'package:fluttertoast/fluttertoast.dart';

class ToastUtil {
  static Fluttertoast fluttertoast = Fluttertoast();

  static show(String msg) {
    Fluttertoast.showToast(msg: msg);
  }

  static showCenter(String msg) {
    Fluttertoast.showToast(msg: msg, gravity: ToastGravity.CENTER);
  }
}
