import 'package:education_helper/constants/constant.dart';
import 'package:education_helper/models/exam.model.dart';
import 'package:equatable/equatable.dart';

abstract class ExamState extends Equatable {
  const ExamState();
}

class ExamInitialState extends ExamState {
  const ExamInitialState();
  @override
  List<Object?> get props => [];
}

class ExamLoadingState extends ExamState {
  const ExamLoadingState();
  @override
  List<Object?> get props => [];
}

class ExamLoadedState extends ExamState {
  final List<Exam> exams;
  const ExamLoadedState(this.exams);
  @override
  List<Object?> get props => [exams];
}

class ExamFailState extends ExamState {
  final Messenger messenger;

  const ExamFailState(this.messenger);
  @override
  List<Object?> get props => [messenger];
}
