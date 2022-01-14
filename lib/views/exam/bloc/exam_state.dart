import 'package:education_helper/models/exam.model.dart';
import 'package:equatable/equatable.dart';

abstract class ExamState extends Equatable {
  const ExamState();
}

class ExamInitial extends ExamState {
  @override
  List<Object?> get props => [];
}

class ExamLoadingState extends ExamState {
  @override
  List<Object?> get props => [];
}

class ExamLoadedState extends ExamState {
  final List<Exam> exams;

  const ExamLoadedState(this.exams);

  @override
  List<Object?> get props => [exams];
}

class ExamCreateState extends ExamState {
  @override
  List<Object?> get props => [];
}

class ExamFailureState extends ExamState {
  final String messanger;
  const ExamFailureState(this.messanger);

  @override
  List<Object?> get props => [messanger];
}
