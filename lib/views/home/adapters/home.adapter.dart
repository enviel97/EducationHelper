import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:education_helper/roots/app_root.dart';
import 'package:education_helper/roots/parts/adapter.dart';
import 'package:education_helper/views/classrooms/adapter/classroom.adapter.dart';
import 'package:education_helper/views/exam/adapter/exam.adapter.dart';
import 'package:education_helper/views/home/bloc/classrooms/classroom.bloc.dart';
import 'package:education_helper/views/home/bloc/exams/exam.bloc.dart';
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

  IAdapter get _authAdapter => Root.ins.adapter.getAdapter(authAdapter);
  IAdapter get _classroomAdapter =>
      Root.ins.adapter.getAdapter(classroomAdpater);
  IAdapter get _examAdapter => Root.ins.adapter.getAdapter(examAdapter);

  @override
  Widget layout({Map<String, dynamic>? params}) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ExamsBloc()),
          BlocProvider(create: (context) => ClassroomsBloc()),
        ],
        child: const Home(),
      );

  Future<void> goToLogin(BuildContext context) async {
    await context.replace(_authAdapter.layout());
  }

  Future<void> goToClassroom(BuildContext context) async {
    await context.goTo(
      BlocProvider.value(
        value: BlocProvider.of<ClassroomsBloc>(context),
        child: _classroomAdapter.layout(),
      ),
    );
  }

  Future<void> goToClassroomDetail(
    BuildContext context, {
    required String uid,
    required int exams,
    required int members,
    required String classname,
  }) async {
    final adapter = _classroomAdapter.cast<ClassroomAdapter>();
    adapter.goToMembers(
      context,
      uid: uid,
      exams: exams,
      members: members,
      classname: classname,
      refresh: BlocProvider.of<ClassroomsBloc>(context).refresh,
    );
  }

  Future<void> goToExams(BuildContext context) async {
    context.goTo(
      BlocProvider.value(
        value: BlocProvider.of<ExamsBloc>(context),
        child: _examAdapter.layout(),
      ),
    );
  }

  Future<void> goToExamDetail(BuildContext context, String idExam) async {
    final adapter = _examAdapter.cast<ExamAdapter>();
    adapter.gotoDetailExam(context, idExam: idExam);
  }
}
