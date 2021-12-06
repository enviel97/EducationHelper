import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'miragate/local_storage.dart';

// ignore: avoid_classes_with_only_static_members
class Root {
  static final Root _ins = Root._();
  static Root get ins => _ins;
  Root._();

  late LocalStorage localStorage;
  late FirebaseAuth ggAuth;

  Future<void> config() async {
    try {
      await SharedPreferences.getInstance().then((value) {
        localStorage = LocalStorage(value);
      });
      await Firebase.initializeApp()
          .then((value) => ggAuth = FirebaseAuth.instanceFor(app: value));
    } catch (error) {
      debugPrint('[Error] : $error');
      // ignore: invalid_use_of_visible_for_testing_member
      SharedPreferences.setMockInitialValues({'token': ''});
      await SharedPreferences.getInstance();
    }
  }
}
