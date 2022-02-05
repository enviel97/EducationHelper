import 'package:education_helper/constants/constant.dart';
import 'package:education_helper/helpers/extensions/list_x.dart';
import 'package:education_helper/helpers/extensions/map_x.dart';
import 'package:education_helper/helpers/ultils/funtions.dart';
import 'package:education_helper/models/topic.model.dart';
import 'package:education_helper/roots/miragate/http.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'topic_state.dart';

class TopicBloc extends Cubit<TopicState> {
  late RestApi _restApi;
  final String _path = 'topics';
  List<Topic> _topics = [];

  TopicBloc() : super(TopicInitial()) {
    _restApi = RestApi();
  }

  Future<void> getAll() async {
    loading();
    return await _structure(() async {
      final result = await _restApi.get(_path).catchError((err) {
        emit(TopicFailure(Messenger(err['error'])));
        return null;
      });
      if (result == null) return;
      _topics = mapToList<Topic>(result, Topic.fromJson);
      notificationChange();
    });
  }

  Future<void> getOnce(String id) async {
    loading();
    return await _structure(() async {
      final result = await _restApi.get('$_path/$id').catchError((err) {
        emit(TopicFailure(Messenger(err['error'])));
        return null;
      });
      if (result == null) return;
      final _topic = Topic.fromJson(result);
      emit(TopicLoaded(_topic));
    });
  }

  Future<void> create({
    required String classroomId,
    required String examId,
    required DateTime expiredDate,
    String note = '',
  }) async {
    loading();
    return await _structure(() async {
      final result = await _restApi
          .post(
              '$_path/create',
              Topic.toRequest(
                  classroomId: classroomId,
                  examId: examId,
                  expiredDate: expiredDate,
                  note: note))
          .catchError((err) {
        emit(TopicFailure(Messenger(err['error'])));
        return null;
      });
      if (result == null) return;
      final _topic = Topic.fromJson(result);
      _topics.add(_topic);
      emit(TopicChanged(_topic));
      notificationChange();
    });
  }

  Future<void> delete(String id) async {
    return await _structure(() async {
      final result = await _restApi.delete('$_path/$id').catchError((err) {
        emit(TopicFailure(Messenger(err['error'])));
        return null;
      });
      if (result == null) return;
      final _topic = Topic.fromJson(result);
      _topics = _topics.where((c) => c.id != id).toList();
      emit(TopicChanged(_topic));
      notificationChange();
    });
  }

  Future<void> edit(
    String id, {
    DateTime? expiredDate,
    String? note,
  }) async {
    return await _structure(() async {
      if (expiredDate == null && note == null) return;
      loading();
      final result = await _restApi
          .post(
              '$_path/update/$id',
              Topic.toRequest(
                expiredDate: expiredDate,
                note: note,
              ))
          .catchError((err) {
        emit(TopicFailure(Messenger(err['error'])));
        return null;
      });
      if (result == null) return;
      final _topic = Topic.fromJson(result);
      emit(TopicChanged(_topic));
      final index = _topics.indexWhere((c) => c.id == _topic.id);
      if (index >= 0) {
        _topics[index] = Topic(
            classroom: _topic.classroom,
            exam: _topic.exam,
            expiredDate: expiredDate ?? _topic.expiredDate,
            createDate: _topic.createDate,
            note: note,
            answers: _topic.answers);
      }
      notificationChange();
    });
  }

  Future<void> loading() async {
    emit(TopicLoading());
  }

  Future<void> refresh() async {
    await getAll();
  }

  Future<void> search(String? query, DateTime? from, DateTime? to) async {
    if (query?.isEmpty ?? true && from == null && to == null) {
      return await getAll();
    }
    loading();
    return await _structure(() async {
      final result = await _restApi
          .get('$_path/search',
              parametter: {
                'query': query ?? '',
                'from': from?.toIso8601String(),
                'to': to?.toIso8601String()
              }.filterNull())
          .catchError((err) {
        emit(TopicFailure(Messenger(err['error'])));
        return null;
      });
      if (result == null) return;
      _topics = mapToList<Topic>(result, Topic.fromJson);
      notificationChange();
    });
  }

  void notificationChange() {
    emit(TopicsLoaded(_topics));
  }

  Future<void> _structure(Future<void> Function() handler) async {
    try {
      await handler();
    } catch (e) {
      debugPrint('[Exams]:\t$e');
      emit(const TopicFailure(Messenger('Error systems')));
    }
  }
}
