import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:education_helper/roots/app_root.dart';
import 'package:education_helper/roots/parts/adapter.dart';
import 'package:education_helper/views/classrooms/adapter/classroom.adapter.dart';
import 'package:education_helper/views/exam/adapter/exam.adapter.dart';
import 'package:education_helper/views/topic/blocs/member/topic_members_bloc.dart';
import 'package:education_helper/views/topic/blocs/topic/topic_bloc.dart';
import 'package:education_helper/views/topic/pages/topic_detail/topic_detail.dart';
import 'package:education_helper/views/topic/pages/topic_form/topic_form.dart';
import 'package:education_helper/views/topic/topics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopicAdapter extends IAdapter {
  static final TopicAdapter _ins = TopicAdapter._internal();

  factory TopicAdapter() {
    return _ins;
  }

  TopicAdapter._internal() {
    Root.ins.adapter.injectAdapter(topicAdapter, this);
  }

  IAdapter get _examAdapter => Root.ins.adapter.getAdapter(examAdapter);
  IAdapter get _classroomAdapter =>
      Root.ins.adapter.getAdapter(classroomAdpater);
  IAdapter get _answerAdapter => Root.ins.adapter.getAdapter(answerAdapter);

  @override
  Widget layout({Map<String, dynamic>? params}) {
    return BlocProvider(
      create: (context) => TopicBloc(),
      child: const Topics(),
    );
  }

  void gotoAddForm(BuildContext context) {
    context.goTo(const TopicForm());
  }

  Future<bool> gotoExams(BuildContext context) async {
    try {
      final isNeedReload = await context.goTo<bool>(_examAdapter.layout());
      return isNeedReload ?? false;
    } catch (_) {
      debugPrint(_.toString());
      return false;
    }
  }

  Future<void> gotoExam(BuildContext context, String idExam) async {
    final adapter = _examAdapter.cast<ExamAdapter>();
    await adapter.gotoDetailExam(context, idExam: idExam);
  }

  Future<bool> goToClassrooms(BuildContext context) async {
    try {
      final isNeedReload = await context.goTo<bool>(_classroomAdapter.layout());
      return isNeedReload ?? false;
    } catch (_) {
      debugPrint(_.toString());
      return false;
    }
  }

  Future<bool> goToClassroom(BuildContext context, String idClassroom) async {
    final adapter = _classroomAdapter.cast<ClassroomAdapter>();
    final isNeedRefresh = await adapter.goToMembers(context, uid: idClassroom);
    return isNeedRefresh;
  }

  Future<bool> goToTopicDetail(
    BuildContext context,
    String idTopic,
  ) async {
    final isNeedRefresh = await context.goTo<bool?>(
      MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => TopicBloc()),
          BlocProvider(create: (context) => TopicMembersBloc()),
        ],
        child: TopicDetail(id: idTopic),
      ),
    );

    return isNeedRefresh ?? false;
  }

  Future<bool> goToAnswer(BuildContext context, String id) async {
    try {
      final isNeedRefresh = await context.goTo<bool>(
        _answerAdapter.layout(params: {'id': id}),
      );
      return isNeedRefresh ?? false;
    } catch (_) {
      debugPrint(_.toString());
      return false;
    }
  }
}
