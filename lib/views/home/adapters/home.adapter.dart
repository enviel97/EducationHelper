import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:education_helper/roots/app_root.dart';
import 'package:education_helper/roots/parts/adapter.dart';
import 'package:education_helper/views/classrooms/adapter/classroom.adapter.dart';
import 'package:education_helper/views/exam/adapter/exam.adapter.dart';
import 'package:education_helper/views/home/bloc/classrooms/classroom.bloc.dart';
import 'package:education_helper/views/home/bloc/exams/exam.bloc.dart';
import 'package:education_helper/views/home/bloc/topics/topic.bloc.dart';
import 'package:education_helper/views/topic/adapter/topic.adapter.dart';
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
  IAdapter get _topicAdapter => Root.ins.adapter.getAdapter(topicAdapter);

  @override
  Widget layout({Map<String, dynamic>? params}) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ExamsBloc()),
          BlocProvider(create: (context) => ClassroomsBloc()),
          BlocProvider(create: (context) => TopicBloc()),
        ],
        child: const Home(),
      );

  Future<void> goToLogin(BuildContext context) async {
    await context.replace(_authAdapter.layout());
  }

  Future<bool> goToClassroom(BuildContext context) async {
    final isNeedRefresh = await context.goTo(_classroomAdapter.layout());
    return isNeedRefresh;
  }

  Future<bool> goToClassroomDetail(
    BuildContext context, {
    required String uid,
    required int exams,
    required int members,
    required String classname,
  }) async {
    final adapter = _classroomAdapter.cast<ClassroomAdapter>();
    final isNeedChange = await adapter.goToMembers(context, uid: uid);
    return isNeedChange;
  }

  Future<bool> goToExams(BuildContext context) async {
    final isNeedRefresh = await context.goTo(_examAdapter.layout());
    return isNeedRefresh;
  }

  Future<void> goToExamDetail(BuildContext context, String idExam) async {
    final adapter = _examAdapter.cast<ExamAdapter>();
    adapter.gotoDetailExam(context, idExam: idExam);
  }

  Future<bool> goToTopics(BuildContext context) async {
    final adapter = _topicAdapter.cast<TopicAdapter>();
    final isNeedRefresh = await context.goTo<bool>(adapter.layout());
    return isNeedRefresh ?? false;
  }

  Future<bool> goToTopic(BuildContext context, {required String id}) async {
    final adapter = _topicAdapter.cast<TopicAdapter>();
    final isNeedRefresh = await adapter.goToTopicDetail(context, id);
    return isNeedRefresh;
  }
}
