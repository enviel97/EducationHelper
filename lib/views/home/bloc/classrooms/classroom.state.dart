import 'package:education_helper/constants/constant.dart';
import 'package:education_helper/models/classroom.model.dart';
import 'package:equatable/equatable.dart';

abstract class ClassroomState extends Equatable {
  const ClassroomState();
}

class ClassroomInitialState extends ClassroomState {
  const ClassroomInitialState();
  @override
  List<Object?> get props => [];
}

class ClassroomLoadingState extends ClassroomState {
  const ClassroomLoadingState();
  @override
  List<Object?> get props => [];
}

class ClassroomLoadedState extends ClassroomState {
  final List<Classroom> classrooms;
  const ClassroomLoadedState(this.classrooms);
  @override
  List<Object?> get props => [classrooms];
}

class ClassroomFailState extends ClassroomState {
  final Messenger messenger;

  const ClassroomFailState(this.messenger);
  @override
  List<Object?> get props => [messenger];
}
