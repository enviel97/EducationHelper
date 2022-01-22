import 'dart:io';

import 'package:education_helper/constants/constant.dart';
import 'package:education_helper/helpers/ultils/funtions.dart';
import 'package:education_helper/models/exam.model.dart';
import 'package:education_helper/roots/miragate/http.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'exam_state.dart';

class ExamBloc extends Cubit<ExamState> {
  List<Exam> _exam = [];
  late RestApi _restApi;
  final String _path = 'exams';

  ExamBloc() : super(ExamInitial()) {
    _restApi = RestApi();
  }

  Future<void> getAll() async {
    loading();
    return await _structure(() async {
      final sort = Helper(sorted: 'content.originName', direction: 'desc');
      final result = await _restApi
          .get(_path, parametter: sort.toJson())
          .catchError((err) {
        emit(ExamFailureState(Messenger(err['error'])));
        return null;
      });
      if (result == null) return;
      _exam = mapToList<Exam>(result, Exam.fromJson);
      emit(ExamLoadedState(_exam));
    });
  }

  Future<void> getOnce(String id) async {
    loading();
    return await _structure(() async {
      final result = await _restApi.get('$_path/$id').catchError((err) {
        emit(ExamFailureState(Messenger(err['error'])));
        return null;
      });
      if (result == null) return;
      final exam = Exam.fromJson(result);
      emit(ExamGetState(exam));
    });
  }

  Future<void> create(String subject, File file) async {
    loading();
    return await _structure(() async {
      final result = await _restApi.upload(
        '$_path/create',
        {'subject': subject},
        {'content': file},
      ).catchError((err) {
        emit(ExamFailureState(Messenger(err['error'])));
        return null;
      });
      if (result == null) return;
      final exam = Exam.fromJson(result);
      _exam.add(exam);
      emit(ExamCreateState(exam));
      emit(ExamLoadedState(_exam));
    });
  }

  Future<void> delete(String id) async {
    return await _structure(() async {
      final result = await _restApi.delete('$_path/$id').catchError((err) {
        emit(ExamFailureState(Messenger(err['error'])));
        return null;
      });
      if (result == null) return;
      final exam = Exam.fromJson(result);
      _exam = _exam.where((c) => c.id != id).toList();
      emit(ExamDeleteState(exam));
      emit(ExamLoadedState(_exam));
    });
  }

  Future<void> edit(String id, String? subject, File? file) async {
    loading();
    return await _structure(() async {
      if (subject == null && file == null) {
        return;
      }
      final result = await _restApi
          .upload(
        '$_path/update/$id',
        {'subject': subject},
        file != null ? {'content': file} : null,
      )
          .catchError((err) {
        emit(ExamFailureState(Messenger(err['error'])));
        return null;
      });
      if (result == null) return;
      final exam = Exam.fromJson(result);
      emit(ExamUdateState(exam));
      final index = _exam.indexWhere((c) => c.id == exam.id);
      if (index >= 0) _exam[index] = exam;
      emit(ExamLoadedState(_exam));
    });
  }

  Future<void> loading() async {
    emit(ExamLoadingState());
  }

  Future<void> refresh() async {
    await getAll();
  }

  Future<void> search(String value) async {
    if (value.isEmpty) {
      return await getAll();
    }
    loading();
    return await _structure(() async {
      final sort = Helper(sorted: 'subject', direction: 'desc', query: value);

      final result = await _restApi
          .get('$_path/search', parametter: sort.toJson())
          .catchError((err) {
        emit(ExamFailureState(Messenger(err['error'])));
        return null;
      });
      if (result == null) return;
      _exam = mapToList<Exam>(result, Exam.fromJson);
      emit(ExamLoadedState(_exam));
    });
  }

  void notificationChange() {
    emit(ExamLoadedState(_exam));
  }

  Future<void> _structure(Future<void> Function() handler) async {
    try {
      await handler();
    } catch (e) {
      debugPrint('[Exams]:\t$e');
      emit(const ExamFailureState(Messenger('Error systems')));
    }
  }
}
