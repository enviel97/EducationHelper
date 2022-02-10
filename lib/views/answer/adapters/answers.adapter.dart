import 'package:education_helper/models/answer.model.dart';
import 'package:education_helper/models/members.model.dart';
import 'package:education_helper/roots/app_root.dart';
import 'package:education_helper/roots/parts/adapter.dart';
import 'package:education_helper/views/answer/answer_create/answer_create.dart';
import 'package:education_helper/views/answer/answer_grade/answers.dart';
import 'package:education_helper/views/answer/bloc/answer_bloc.dart';
import 'package:education_helper/views/widgets/button/custom_go_back.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    try {
      final String type = params?['type'] ?? '';
      if (type == 'submited') {
        return _goToCreate(
          member: params!['member'] as Member,
          expiredDate: params['expiredDate'] as DateTime,
          topicId: params['idTopic'] as String,
          status: params['status'] as StatusAnswer,
          id: (params['id'] as String?) ?? '',
        );
      }
      final String id = params?['id'] ?? '';
      return _goToGrade(id);
    } catch (e) {
      debugPrint('[Adpater Ansswer error]: $e');
      return const Center(
        child: KGoBack(),
      );
    }
  }

  Widget _goToGrade(String id) {
    return BlocProvider(
      create: (context) => AnswerBloc(id),
      child: const AnswerGrade(),
    );
  }

  Widget _goToCreate({
    required Member member,
    required DateTime expiredDate,
    required String topicId,
    required StatusAnswer status,
    required String id,
  }) {
    return BlocProvider(
      create: (context) => AnswerBloc(
        id,
        member: member,
        topicId: topicId,
        expiredDate: expiredDate,
        status: status,
      ),
      child: const AnswerCreate(),
    );
  }
}
