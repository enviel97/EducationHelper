import 'package:education_helper/constants/constant.dart';
import 'package:education_helper/models/topic.model.dart';
import 'package:equatable/equatable.dart';

abstract class TopicState extends Equatable {
  const TopicState();
}

class TopicInitialState extends TopicState {
  const TopicInitialState();
  @override
  List<Object?> get props => [];
}

class TopicLoadingState extends TopicState {
  const TopicLoadingState();
  @override
  List<Object?> get props => [];
}

class TopicLoadedState extends TopicState {
  final List<Topic> topics;
  const TopicLoadedState(this.topics);
  @override
  List<Object?> get props => [topics];
}

class TopicFailState extends TopicState {
  final Messenger messenger;

  const TopicFailState(this.messenger);
  @override
  List<Object?> get props => [messenger];
}
