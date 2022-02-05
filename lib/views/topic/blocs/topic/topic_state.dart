import 'package:education_helper/constants/constant.dart';
import 'package:education_helper/models/topic.model.dart';
import 'package:equatable/equatable.dart';

abstract class TopicState extends Equatable {
  const TopicState();
}

class TopicInitial extends TopicState {
  @override
  List<Object?> get props => [];
}

class TopicLoading extends TopicState {
  @override
  List<Object?> get props => [];
}

class TopicChanged extends TopicState {
  final Topic topic;

  const TopicChanged(this.topic);

  @override
  List<Object?> get props => [topic];
}

class TopicLoaded extends TopicState {
  final Topic topic;
  const TopicLoaded(this.topic);

  @override
  List<Object?> get props => [topic];
}

class TopicsLoaded extends TopicState {
  final List<Topic> topics;

  const TopicsLoaded(this.topics);

  @override
  List<Object?> get props => [topics];
}

class TopicFailure extends TopicState {
  final Messenger error;
  const TopicFailure(this.error);

  @override
  List<Object?> get props => [error.mess];
}
