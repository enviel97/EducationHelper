import 'package:education_helper/models/classroom.model.dart';
import 'package:education_helper/models/exam.model.dart';
import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitialState extends HomeState {
  @override
  List<Object?> get props => [];
}

class ClassroomLoadingState extends HomeState {
  const ClassroomLoadingState();
  @override
  List<Object?> get props => [];
}

class ExamLoadingState extends HomeState {
  const ExamLoadingState();

  @override
  List<Object?> get props => [];
}

class ClassroomLoadedState extends HomeState {
  final List<Classroom> classrooms;
  const ClassroomLoadedState(this.classrooms);
  @override
  List<Object?> get props => [classrooms];
}

class ExamLoadedState extends HomeState {
  final List<Exam> exams;
  const ExamLoadedState(this.exams);
  @override
  List<Object?> get props => [exams];
}

class HomeFailureState extends HomeState {
  final String messenger;
  const HomeFailureState(this.messenger);

  @override
  List<Object?> get props => [messenger];
}
