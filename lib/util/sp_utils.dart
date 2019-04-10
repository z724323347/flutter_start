import 'package:shared_preferences/shared_preferences.dart';

class SpUtil {
  static final SpUtil _instance = new SpUtil.internal();
  factory SpUtil() => _instance;
  static SharedPreferences _sp;
  SpUtil.internal();

  Future<SharedPreferences> get sp async {
    if (_sp !=null) {
      return _sp;
    }

    _sp =await initSP();

    return _sp;
  }

  initSP() async {
    var prefs= await SharedPreferences.getInstance();
    return prefs;
  }
}