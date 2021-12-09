import 'package:education_helper/helpers/widgets/router_animation.dart';
import 'package:education_helper/roots/app_root.dart';
import 'package:education_helper/views/home/home.dart';
import 'package:flutter/cupertino.dart';

const authAdapter = 'AuthAdapter';

class AuthAdpater {
  static final AuthAdpater _ins = AuthAdpater._();

  static get ins => _ins;

  AuthAdpater._() {
    Root.ins.adapter.injectAdapter(authAdapter, this);
  }

  factory AuthAdpater() {
    return _ins;
  }

  Future<void> goToHome(BuildContext context) async {
    Navigator.of(context).pushReplacement(
      RouterAnimation(child: const Home()),
    );
  }
}
