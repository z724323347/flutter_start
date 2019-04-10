import 'package:shared_preferences/shared_preferences.dart';

class SpUtil {
  static final SpUtil _instance = new SpUtil.internal();
  factory SpUtil() => _instance;
  static SharedPreferences _sp;
  SpUtil.internal();

  Future<SharedPreferences> get init async {
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


  Future<List> getStringList(String key) async {
    var prefs = await init;
    return prefs.getStringList(key);
  }

  Future<String> getString(String key) async {
    var prefs = await init;
    return prefs.getString(key);
  } 

  Future<int> getInt(String key) async {
    var prefs = await init;
    return prefs.getInt(key);
  }
  Future<double> getDouble(String key) async {
    var prefs = await init;
    return prefs.getDouble(key);
  }

  Future<bool> getBool(String key) async {
    var prefs = await init;
    return prefs.getBool(key);
  }

  void remove(String key) async {
    var prefs = await init;
    prefs.remove(key);
  }

  void getKey() async {
    var prefs = await init;
    prefs.getKeys();
  }


  // getStringList(String key) async {
  //   var spClient = await sp;
  //   return spClient.getStringList(key);
  // }
}