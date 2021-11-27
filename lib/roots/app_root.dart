import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'manage/local_storage.dart';

// ignore: avoid_classes_with_only_static_members
class Root {
  static late SharedPreferences _prefs;
  static late LocalStorage localStorage;
  static late Client client;

  static Future<void> config() async {
    try {
      _prefs = await SharedPreferences.getInstance();
      await Future.delayed(const Duration(milliseconds: 400));
      localStorage = LocalStorage(_prefs);
      client = Client();
    } catch (error) {
      debugPrint('[Error] : $error');
      // ignore: invalid_use_of_visible_for_testing_member
      SharedPreferences.setMockInitialValues({'token': ''});
      _prefs = await SharedPreferences.getInstance();
    }
  }
}
