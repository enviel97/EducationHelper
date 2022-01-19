import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:education_helper/roots/app_root.dart';
import 'package:education_helper/roots/parts/adapter.dart';
import 'package:education_helper/views/exam/exam.dart';
import 'package:education_helper/views/exam/pages/exam_create/exam_create.dart';
import 'package:education_helper/views/exam/pages/exams_detail/exam_detail.dart';
import 'package:flutter/material.dart';

class ExamAdapter extends IAdapter {
  static final ExamAdapter _ins = ExamAdapter._internal();

  factory ExamAdapter() {
    return _ins;
  }
  ExamAdapter._internal() {
    Root.ins.adapter.injectAdapter(examAdapter, this);
  }

  @override
  Widget layout({Map<String, dynamic>? params}) {
    return const Exams();
  }

  Future<void> gotoDetailExam(
    BuildContext context, {
    required String idExam,
  }) async {
    await context.goTo(ExamDetail(id: idExam));
  }

  Future<void> goToCreateExam(BuildContext context) async {
    await context.goTo(const ExamForm(title: 'CREATE EXAM'));
  }
}
