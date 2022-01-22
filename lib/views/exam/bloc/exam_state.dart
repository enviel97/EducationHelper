import 'package:education_helper/constants/constant.dart';
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
  final Exam exam;

  const ExamCreateState(this.exam);

  @override
  List<Object?> get props => [exam];
}

class ExamUdateState extends ExamState {
  final Exam exam;

  const ExamUdateState(this.exam);

  @override
  List<Object?> get props => [exam];
}

class ExamDeleteState extends ExamState {
  final Exam exam;

  const ExamDeleteState(this.exam);

  @override
  List<Object?> get props => [exam];
}

class ExamGetState extends ExamState {
  final Exam exam;

  const ExamGetState(this.exam);

  @override
  List<Object?> get props => [exam];
}

class ExamFailureState extends ExamState {
  final Messenger error;
  const ExamFailureState(this.error);

  @override
  List<Object?> get props => [error];
}
