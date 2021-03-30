import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Storage {
  static read(final String key) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    var value = sharedPreferences.getString(key);
    if (value == null) {
      value = '[]';
    }
    return json.decode(value);
  }

  static write(final String key, final value) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(key, json.encode(value));
  }
}
