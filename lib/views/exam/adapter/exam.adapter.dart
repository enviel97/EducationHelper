import 'package:education_helper/roots/parts/adapter.dart';
import 'package:education_helper/views/exam/exam.dart';
import 'package:flutter/material.dart';

class ExamAdapter extends IAdapter {
  @override
  Widget layout({Map<String, dynamic>? params}) {
    return Exam();
  }
}
