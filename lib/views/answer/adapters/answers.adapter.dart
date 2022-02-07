import 'package:education_helper/models/members.model.dart';
import 'package:education_helper/roots/app_root.dart';
import 'package:education_helper/roots/parts/adapter.dart';
import 'package:education_helper/views/answer/answer_create/answer_create.dart';
import 'package:education_helper/views/answer/answer_grade/answers.dart';
import 'package:flutter/cupertino.dart';

class AnswerAdapter extends IAdapter {
  static final AnswerAdapter _ins = AnswerAdapter._internal();
  late String token = '';
  AnswerAdapter._internal() {
    Root.ins.adapter.injectAdapter(answerAdapter, this);
  }

  factory AnswerAdapter() {
    return _ins;
  }

  @override
  Widget layout({Map<String, dynamic>? params}) {
    final String id = params?['id'] ?? '';
    if (id.isEmpty) {
      final member = params!['member'] as Member;
      final idTopic = params['idTopic'] as String;
      return AnswerCreate(
        member: member,
        idTopic: idTopic,
      );
    }
    return Answers(id: id);
  }
}
