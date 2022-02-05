import 'package:education_helper/constants/constant.dart';
import 'package:education_helper/helpers/ultils/funtions.dart';
import 'package:education_helper/models/classroom.model.dart';
import 'package:education_helper/models/topic.model.dart';
import 'package:education_helper/roots/miragate/http.dart';
import 'package:education_helper/views/topic/blocs/member/topic_members_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopicMembersBloc extends Cubit<TopicMembersState> {
  late RestApi _restApi;
  final String _path = 'topics';

  TopicMembersBloc() : super(TopicMembersInitial()) {
    _restApi = RestApi();
  }

  Future<void> refreshMembers(String id) async {
    return getMembers(id);
  }

  Future<void> getMembers(String id) async {
    emit(TopicMembersLoading());
    return await _structure(() async {
      final result = await _restApi.get('$_path/$id/members').catchError((err) {
        emit(TopicMembersFailure(Messenger(err['error'])));
        return null;
      });
      if (result == null) return;

      final classroom = Classroom.fromJson(result['classroom']);
      final answers = mapToList<Answer>(result['answers'], Answer.fromJson);

      emit(TopicMembersLoaded(classroom, answers));
    });
  }

  Future<void> _structure(Future<void> Function() handler) async {
    try {
      await handler();
    } catch (e) {
      debugPrint('[Exams]:\t$e');
      emit(const TopicMembersFailure(Messenger('Error systems')));
    }
  }
}
