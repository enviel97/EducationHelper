import 'package:education_helper/models/user.model.dart';
import 'package:equatable/equatable.dart';

abstract class AppState extends Equatable {
  const AppState();
}

class AppStateInitial extends AppState {
  @override
  List<Object?> get props => [];
}

class UserStateLoading extends AppState {
  @override
  List<Object?> get props => [];
}

class UserStateSuccess extends AppState {
  final User user;

  const UserStateSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class UserStateFailure extends AppState {
  final String messenger;

  const UserStateFailure(this.messenger);

  @override
  List<Object?> get props => [messenger];
}
