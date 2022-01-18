import 'package:education_helper/constants/constant.dart' as c;
import 'package:education_helper/roots/miragate/http.dart';
import 'package:education_helper/roots/parts/adapter.dart';
import 'package:education_helper/views/auth/adapter/auth.adapter.dart';
import 'package:education_helper/views/classrooms/adapter/classroom.adapter.dart';
import 'package:education_helper/views/exam/adapter/exam.adapter.dart';
import 'package:education_helper/views/home/adapters/home.adapter.dart';
import 'package:education_helper/views/member/adapter/member.adapter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'miragate/local_storage.dart';

part './parts/name_adapter.dart';
part './parts/injection.dart';

// ignore: avoid_classes_with_only_static_members
class Root {
  static final Root _ins = Root._();
  static Root get ins => _ins;

  late LocalStorage localStorage;
  late _AppAdapter adapter;

  Root._() {
    adapter = _AppAdapter();
  }
  final List<Future<String>> _asyncs = [];

  Future<String> _initLocalStorage() async {
    final shared = await SharedPreferences.getInstance();
    localStorage = LocalStorage(shared);
    return 'Done';
  }

  Future<String> _initFirebase() async {
    await Firebase.initializeApp();
    return 'Done';
  }

  List<Future<String>> config() {
    if (_asyncs.isEmpty) {
      _asyncs.add(_initLocalStorage());
      _asyncs.add(_initFirebase());
      _asyncs.add(_configRouteApp());
    }
    return _asyncs;
  }

  Future<Widget> getScreens() async {
    final token = await localStorage.readAsync(c.token);
    RestApi().setHeaders(token == '' ? null : token);
    if (token.isEmpty || JwtDecoder.isExpired(token)) {
      return adapter.getAdapter(authAdapter).layout();
    }
    debugPrint(token);
    return adapter.getAdapter(homeAdapter).layout();
  }

  Future<String> _configRouteApp() async {
    // inject here
    AuthAdpater();
    HomeAdapter();
    ClassroomAdapter();
    MemberAdapter();
    ExamAdapter();
    return 'Done';
  }
}
