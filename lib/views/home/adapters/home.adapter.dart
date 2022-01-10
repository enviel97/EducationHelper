import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:education_helper/roots/app_root.dart';
import 'package:education_helper/roots/miragate/injection.dart';
import 'package:education_helper/roots/parts/adapter.dart';
import 'package:education_helper/views/classrooms/adapter/classroom.adapter.dart';
import 'package:education_helper/views/home/bloc/home_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => HomeBloc())],
      child: const Home(),
    );
  }

  Future<void> goToLogin(BuildContext context) async {
    await context.replace(_authAdapter.layout());
  }

  Future<void> goToClassroom(BuildContext context) async {
    await context.goTo(BlocProvider.value(
      value: BlocProvider.of<HomeBloc>(context),
      child: _classroomAdapter.layout(),
    ));
  }

  Future<void> goToClassroomDetail(BuildContext context, String id) async {
    await _classroomAdapter
        .as<ClassroomAdapter>()
        .goToClassroomDetail(context, id);
  }
}
