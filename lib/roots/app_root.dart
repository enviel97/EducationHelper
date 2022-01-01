import 'package:education_helper/constants/constant.dart' as c;
import 'package:education_helper/roots/miragate/http.dart';
import 'package:education_helper/roots/miragate/injection.dart';
import 'package:education_helper/views/auth/adapter/auth.adapter.dart';
import 'package:education_helper/views/home/adapters/home.adapter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'miragate/local_storage.dart';

part './parts/name_adapter.dart';

// ignore: avoid_classes_with_only_static_members
class Root {
  static final Root _ins = Root._();
  static Root get ins => _ins;

  late LocalStorage localStorage;
  late AppAdapter adapter;

  Root._() {
    adapter = AppAdapter();
  }

  Future _initLocalStorage() async {
    final shared = await SharedPreferences.getInstance();
    localStorage = LocalStorage(shared);
  }

  Future _initFirebase() async {
    await Firebase.initializeApp();
  }

  List<Future> config() {
    final List<Future> asyncs = [];
    asyncs.add(_initLocalStorage());
    asyncs.add(_initFirebase());
    asyncs.add(_configRouteApp());
    return asyncs;
  }

  Future<Widget> getScreens() async {
    final token = await localStorage.read(c.token);
    RestApi().setHeaders(token == '' ? null : token);
    if (token.isEmpty || JwtDecoder.isExpired(token)) {
      return adapter.getAdapter(authAdapter).layout();
    }
    debugPrint(token);
    return adapter.getAdapter(homeAdapter).layout();
  }

  Future _configRouteApp() async {
    // inject here
    AuthAdpater();
    HomeAdapter();
  }
}
