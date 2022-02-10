import 'dart:io';

import 'package:education_helper/constants/constant.dart';
import 'package:education_helper/helpers/extensions/map_x.dart';
import 'package:education_helper/models/answer.model.dart';
import 'package:education_helper/models/members.model.dart';
import 'package:education_helper/roots/miragate/http.dart';
import 'package:education_helper/views/answer/bloc/answer_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnswerBloc extends Cubit<AnswerState> {
  late RestApi _api;

  final String _path = 'answers', id, topicId;
  final Member? member;
  final DateTime? expiredDate;
  final StatusAnswer status;

  AnswerBloc(
    this.id, {
    this.topicId = '',
    this.member,
    this.expiredDate,
    this.status = StatusAnswer.empty,
  }) : super(const AnswerInitial()) {
    _api = RestApi();
  }

  // loaded
  Future<void> getAnswer() async {
    return await _structure(() async {
      final result = await _api.get('$_path/$id').catchError((err) {
        emit(AnswerFailure(Messenger(err['error'])));
        return null;
      });
      if (result == null) return;
      final answer = Answer.fromJson(result);
      emit(AnswerLoaded(answer));
    });
  }

  // create
  Future<void> create(String note, File file) async {
    emit(const AnswerLoading());
    return await _structure(() async {
      final result = await _api.upload(
        '$_path/create',
        {
          'note': note,
          'memberId': member?.uid ?? '',
          'topicId': topicId,
          'creaetDate': DateTime.now().toIso8601String(),
        },
        {'content': file},
      ).catchError((err) {
        emit(AnswerFailure(Messenger(err['error'])));
        return null;
      });
      if (result == null) return;
      emit(AnswerChanged(result['id'] ?? result['_id'] ?? ''));
    });
  }

  // edit

  Future<void> edit({String? note, File? file}) async {
    emit(const AnswerLoading());
    return await _structure(() async {
      if (note == null && file == null) {
        return;
      }
      final result = await _api
          .upload(
        '$_path/update/$id',
        {
          'note': note,
          'createDate': DateTime.now().toIso8601String(),
        },
        file != null ? {'content': file} : null,
      )
          .catchError((err) {
        emit(AnswerFailure(Messenger(err['error'])));
        return null;
      });
      if (result == null) return;

      emit(AnswerChanged(result['id'] ?? result['_id'] ?? ''));
    });
  }

  // grade
  Future<void> grade({
    required double grade,
    String review = '',
    String name = '',
  }) async {
    final result = await _api
        .put(
      '$_path/grade/$id',
      {'grade': grade, 'review': review}.filterNull(),
    )
        .catchError((err) {
      emit(AnswerGradeFailure(Messenger(err['error'])));
      return null;
    });
    if (result == null) return;
    emit(AnswerChanged(result['id'] ?? result['_id'] ?? ''));
  }

  Future<void> _structure(Future<void> Function() handler) async {
    try {
      await handler();
    } catch (e) {
      debugPrint('[Answers Bloc]:\t$e');
      emit(const AnswerFailure(Messenger('Error systems')));
    }
  }
}
