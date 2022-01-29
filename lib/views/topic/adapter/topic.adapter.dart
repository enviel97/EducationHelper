import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:education_helper/roots/app_root.dart';
import 'package:education_helper/roots/parts/adapter.dart';
import 'package:education_helper/views/exam/adapter/exam.adapter.dart';
import 'package:education_helper/views/topic/pages/topic_form/topic_form.dart';
import 'package:education_helper/views/topic/topics.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget layout({Map<String, dynamic>? params}) {
    return const Topics();
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
}
