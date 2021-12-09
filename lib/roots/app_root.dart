import 'package:education_helper/constants/constant.dart' as c;
import 'package:education_helper/roots/miragate/http.dart';
import 'package:education_helper/roots/miragate/injection.dart';
import 'package:education_helper/views/auth/adapter/auth.adapter.dart';
import 'package:education_helper/views/auth/auth.dart';
import 'package:education_helper/views/auth/bloc/auth_bloc.dart';
import 'package:education_helper/views/home/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'miragate/local_storage.dart';

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
    asyncs.add(_configRoutApp());
    return asyncs;
  }

  Future<Widget> getScreens() async {
    final token = await localStorage.read(c.token);
    if (token.isEmpty) return _authRoute();
    RestApi().setHeaders(token);
    return _homeRoute();
  }

  Widget _authRoute() {
    final AuthBloc authBloc = AuthBloc(localStorage);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => authBloc),
      ],
      child: const Auth(),
    );
  }

  Widget _homeRoute() => const Home();

  Future _configRoutApp() async {
    // inject here
    AuthAdpater();
  }
}
