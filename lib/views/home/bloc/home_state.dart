import 'package:education_helper/models/classroom.model.dart';
import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitialState extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class HClassCollectionSuccessState extends HomeState {
  final List<Classroom> classrooms;

  const HClassCollectionSuccessState(this.classrooms);

  @override
  List<Object?> get props => [classrooms];
}

class HomeFailureState extends HomeState {
  final String messenger;
  const HomeFailureState(this.messenger);

  @override
  List<Object?> get props => [messenger];
}
