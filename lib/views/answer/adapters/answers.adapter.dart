import 'package:education_helper/roots/app_root.dart';
import 'package:education_helper/roots/parts/adapter.dart';
import 'package:education_helper/views/answer/answers.dart';
import 'package:flutter/cupertino.dart';

class AnswerAdapter extends IAdapter {
  static final AnswerAdapter _ins = AnswerAdapter._internal();

  AnswerAdapter._internal() {
    Root.ins.adapter.injectAdapter(answerAdapter, this);
  }

  factory AnswerAdapter() {
    return _ins;
  }

  @override
  Widget layout({Map<String, dynamic>? params}) {
    final String id = params!['id'];
    return Answers(id: id);
  }
}
