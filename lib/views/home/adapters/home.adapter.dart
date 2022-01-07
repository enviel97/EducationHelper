import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:education_helper/roots/app_root.dart';
import 'package:education_helper/roots/miragate/injection.dart';
import 'package:education_helper/roots/parts/adapter.dart';
import 'package:flutter/cupertino.dart';

import '../home.dart';

class HomeAdapter extends IAdapter {
  static final HomeAdapter _ins = HomeAdapter._internal();

  factory HomeAdapter() {
    return _ins;
  }
  HomeAdapter._internal() {
    Root.ins.adapter.injectAdapter(homeAdapter, this);
  }

  IAdapter get _authAdapter => AppAdapter().getAdapter(authAdapter);
  IAdapter get _classroomAdapter => AppAdapter().getAdapter(classroomAdpater);

  @override
  Widget layout() {
    return const Home();
  }

  Future<void> goToLogin(BuildContext context) async {
    await context.replace(_authAdapter.layout());
  }

  Future<void> goToClassroom(BuildContext context) async {
    await context.goTo(_classroomAdapter.layout());
  }
}
