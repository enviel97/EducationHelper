import 'package:education_helper/models/exam.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'exam_state.dart';

class ExamBloc extends Cubit<ExamState> {
  List<Exam> _exam = [];

  ExamBloc() : super(ExamInitial());
  Future<void> getAll() async {}
  Future<void> create() async {}
  Future<void> delete() async {}
  Future<void> edit() async {}

  Future<void> loading() async {
    emit(ExamLoadingState());
  }

  Future<void> refresh() async {
    await getAll();
  }

  void notificationChange() {
    emit(ExamLoadedState(_exam));
  }

  Future<void> _structure(Future<void> Function() handler) async {
    try {
      await handler();
    } catch (e) {
      debugPrint('[Exams]:\t$e');
      emit(const ExamFailureState('Error systems'));
    }
  }
}
