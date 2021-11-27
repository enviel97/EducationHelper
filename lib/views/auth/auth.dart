import 'package:education_helper/views/auth/pages/siginin.dart';
import 'package:flutter/material.dart';

class Auth extends StatefulWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  _AuthController createState() => _AuthController();
}

class _AuthController extends State<Auth> {
  int counter = 0;

  @override
  Widget build(BuildContext context) => _AuthView(this);

  void onLogin() {
    debugPrint('Login');
  }
}

class _AuthView extends StatelessWidget {
  final _AuthController state;
  const _AuthView(this.state, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignInPage(
        onSigin: state.onLogin,
      ),
    );
  }
}
