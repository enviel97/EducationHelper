import 'package:education_helper/helpers/widgets/router_animation.dart';
import 'package:education_helper/roots/app_root.dart';
import 'package:education_helper/roots/miragate/injection.dart';
import 'package:education_helper/roots/parts/adapter.dart';
import 'package:flutter/cupertino.dart';

import '../home.dart';

class HomeAdapter extends IAdapter {
  HomeAdapter() {
    Root.ins.adapter.injectAdapter(homeAdapter, this);
  }

  IAdapter get _authAdapter => AppAdapter().getAdapter(authAdapter);

  @override
  Widget layout() {
    return const Home();
  }

  Future<void> goToLogin(BuildContext context) async {
    await Navigator.of(context).pushReplacement(
      RouterAnimation(child: _authAdapter.layout()),
    );
  }
}
