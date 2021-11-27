import 'package:education_helper/models/user.model.dart';
import 'package:equatable/equatable.dart';

abstract class AppState extends Equatable {
  const AppState();
}

class AppStateInitial extends AppState {
  @override
  List<Object?> get props => [];
}

class AppStateStorage extends AppState {
  final User user;
  final String token;

  const AppStateStorage(this.user, this.token);

  @override
  List<Object?> get props => [user, token];
}
