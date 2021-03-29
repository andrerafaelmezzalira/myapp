import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Storage {
  static read(final String key) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return json.decode(sharedPreferences.getString(key)!);
  }

  static write(final String key, final value) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(key, json.encode(value));
  }
}
