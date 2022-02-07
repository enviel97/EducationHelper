import 'package:education_helper/helpers/widgets/error_authenticate.dart';
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
      final String id = params?['id'] ?? '';
      if (id.isEmpty) {
        return _goToCreate(
          params!['member'] as Member,
          params['idTopic'] as String,
        );
      }
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
      create: (context) => AnswerBloc(),
      child: AnswerGrade(id: id),
    );
  }

  Widget _goToCreate(Member member, String idTopic) {
    return AnswerCreate(
      member: member,
      idTopic: idTopic,
    );
  }
}
