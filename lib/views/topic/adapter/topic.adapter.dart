import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:education_helper/models/exam.model.dart';
import 'package:education_helper/roots/app_root.dart';
import 'package:education_helper/roots/parts/adapter.dart';
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

  @override
  Widget layout({Map<String, dynamic>? params}) {
    return const Topics();
  }

  void gotoAddForm(BuildContext context) {
    context.goTo(const TopicForm());
  }

  Future<Exam?> selectedExam(BuildContext context) async {
    final exam = await context.goTo<Exam>(
      _examAdapter.layout(
        params: {'goToDetail': () {}},
      ),
    );

    return exam;
  }
}
