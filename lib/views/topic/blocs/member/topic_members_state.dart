import 'package:education_helper/constants/constant.dart';
import 'package:education_helper/models/answer.model.dart';
import 'package:education_helper/models/members.model.dart';
import 'package:equatable/equatable.dart';

abstract class TopicMembersState extends Equatable {
  const TopicMembersState();
}

class TopicMembersInitial extends TopicMembersState {
  @override
  List<Object?> get props => [];
}

class TopicMembersLoading extends TopicMembersState {
  @override
  List<Object?> get props => [];
}

class TopicMembersChanged extends TopicMembersState {
  const TopicMembersChanged();

  @override
  List<Object?> get props => [];
}

class TopicMembersLoaded extends TopicMembersState {
  final List<Member> members;
  final List<Answer> answers;

  const TopicMembersLoaded(this.members, this.answers);

  @override
  List<Object?> get props => [members, answers];
}

class TopicMembersFailure extends TopicMembersState {
  final Messenger error;
  const TopicMembersFailure(this.error);

  @override
  List<Object?> get props => [error];
}
