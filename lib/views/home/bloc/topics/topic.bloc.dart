import 'package:education_helper/constants/constant.dart';
import 'package:education_helper/models/topic.model.dart';
import 'package:education_helper/roots/miragate/http.dart';
import 'package:education_helper/views/home/bloc/topics/topic.state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopicBloc extends Cubit<TopicState> {
  late RestApi _restApi;
  TopicBloc() : super(const TopicInitialState()) {
    _restApi = RestApi();
  }

  Future<void> refresh() async {
    await getTopicCollection();
  }

  Future<void> getTopicCollection() async {
    emit(const TopicLoadingState());
    try {
      final result = await _restApi.get('topics/top').catchError((err) {
        emit(TopicFailState(Messenger(err['error'] ?? err.toString())));
        return null;
      });
      if (result == null) return;
      final List<Topic> topics;
      if ((result?.length ?? 0) == 0) {
        topics = [];
      } else {
        topics = List<Topic>.generate(
            result.length, (index) => Topic.fromJson(result[index]));
      }
      emit(TopicLoadedState(topics));
    } catch (e) {
      debugPrint('System error : $e');
      emit(const TopicFailState(Messenger('System error')));
    }
  }
}
