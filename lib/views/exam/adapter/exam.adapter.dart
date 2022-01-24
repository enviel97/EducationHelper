import 'dart:io';
import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:education_helper/roots/app_root.dart';
import 'package:education_helper/roots/parts/adapter.dart';
import 'package:education_helper/views/exam/bloc/exam_bloc.dart';
import 'package:education_helper/views/exam/exam.dart';
import 'package:education_helper/views/exam/pages/exam_form/exam_form.dart';
import 'package:education_helper/views/exam/pages/exams_detail/exam_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return BlocProvider(
      create: (context) => ExamBloc(),
      child: const Exams(),
    );
  }

  Future<void> gotoDetailExam(
    BuildContext context, {
    required String idExam,
  }) async {
    await context.goTo(
      BlocProvider(
        create: (context) => ExamBloc(),
        child: ExamDetail(id: idExam),
      ),
    );
  }

  Future<void> goToCreateExam(BuildContext context) async {
    await context.goTo(const ExamForm());
  }

  Future<void> goToEditExam(
    BuildContext context, {
    required String id,
    required String subject,
    required File file,
  }) async {
    await context.goTo(ExamForm(
      id: id,
      subject: subject,
      file: file,
    ));
  }
}
