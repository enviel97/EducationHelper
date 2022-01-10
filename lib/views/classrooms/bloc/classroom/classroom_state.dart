import 'package:education_helper/models/classroom.model.dart';
import 'package:equatable/equatable.dart';

abstract class ClassroomState extends Equatable {
  const ClassroomState();
}

class ClassroomInitialState extends ClassroomState {
  @override
  List<Object?> get props => [];
}

class ClassroomLoadingState extends ClassroomState {
  @override
  List<Object?> get props => [];
}

class ClassroomCreateSuccessState extends ClassroomState {
  final Classroom classroom;
  const ClassroomCreateSuccessState(this.classroom);

  @override
  List<Object?> get props => [classroom];
}

class ClassroomCollectionState extends ClassroomState {
  final List<Classroom> classrooms;
  const ClassroomCollectionState(this.classrooms);

  @override
  List<Object?> get props => [classrooms];
}

class ClassroomGetAllSuccessState extends ClassroomState {
  final List<Classroom> classrooms;
  const ClassroomGetAllSuccessState(this.classrooms);

  @override
  List<Object?> get props => [classrooms];
}

class ClassroomGetSuccessState extends ClassroomState {
  final Classroom classroom;
  const ClassroomGetSuccessState(this.classroom);

  @override
  List<Object?> get props => [classroom];
}

class ClassroomDeleteSuccessState extends ClassroomState {
  final Classroom classroom;
  const ClassroomDeleteSuccessState(this.classroom);

  @override
  List<Object?> get props => [classroom];
}

class ClassroomFailureState extends ClassroomState {
  final String messenger;
  const ClassroomFailureState(this.messenger);

  @override
  List<Object?> get props => [messenger];
}
