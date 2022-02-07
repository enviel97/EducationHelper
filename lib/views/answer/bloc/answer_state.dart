import 'package:education_helper/constants/constant.dart';
import 'package:education_helper/models/answer.model.dart';
import 'package:equatable/equatable.dart';

abstract class AnswerState extends Equatable {
  const AnswerState();
}

class AnswerInitial extends AnswerState {
  const AnswerInitial();

  @override
  List<Object?> get props => [];
}

class AnswerLoading extends AnswerState {
  const AnswerLoading();

  @override
  List<Object?> get props => [];
}

class AnswerLoaded extends AnswerState {
  final Answer answer;
  const AnswerLoaded(this.answer);

  @override
  List<Object?> get props => [];
}

class AnswerChanged extends AnswerState {
  final String idAnswer;
  const AnswerChanged(this.idAnswer);

  @override
  List<Object?> get props => [idAnswer];
}

class AnswerGradeFailure extends AnswerState {
  final Messenger error;
  const AnswerGradeFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class AnswerFailure extends AnswerState {
  final Messenger error;
  const AnswerFailure(this.error);

  @override
  List<Object?> get props => [error];
}
