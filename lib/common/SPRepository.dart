import 'package:flutter_app_1/common/ToastCompat.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SPRepository {
  static SPRepository _instance;

  SPRepository._internal() {
    _prefs = SharedPreferences.getInstance();
  }

  factory SPRepository.getInstance() => _getInstance();

  static _getInstance() {
    if (_instance == null) {
      _instance = SPRepository._internal();
    }
    return _instance;
  }

  Future<SharedPreferences> _prefs;

  dynamic get(String key, [dynamic defaultValue]) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.get(key) ?? defaultValue;
  }

  dynamic set(String key, dynamic value) async {
    final SharedPreferences prefs = await _prefs;
    Type type = value.runtimeType;
    switch (type) {
      case bool:
        prefs.setBool(key, value);
        ToastCompat.showToast("here  is  bool "+ type.toString());
        break;
      case String:
        prefs.setString(key, value);
        break;
      case int:
        prefs.setInt(key, value);
        break;
      case List:
        prefs.setStringList(key, value);
        break;
    }
  }
}
