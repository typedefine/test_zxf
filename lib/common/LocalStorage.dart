import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static save(String key, value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(key, value);
  }

  static get(String key) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.get(key);
  }

  static remove(String key) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove(key);
  }

}