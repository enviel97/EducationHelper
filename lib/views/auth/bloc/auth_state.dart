import 'package:education_helper/constants/constant.dart';
import 'package:education_helper/models/user.model.dart';
import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitialState extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthLoadingState extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthSignupSuccessState extends AuthState {
  final User user;
  const AuthSignupSuccessState(this.user);

  @override
  List<Object> get props => [user];
}

class AuthSigninSuccessState extends AuthState {
  final String token;
  const AuthSigninSuccessState(this.token);

  @override
  List<Object> get props => [token];
}

class AuthSignoutState extends AuthState {
  const AuthSignoutState();

  @override
  List<Object> get props => [];
}

class AuthErrorState extends AuthState {
  final Messenger error;
  const AuthErrorState(this.error);

  @override
  List<Object?> get props => [error];
}

class AuthErrorsState extends AuthState {
  final List<dynamic> _errors;
  const AuthErrorsState(this._errors);
  List<Map<String, dynamic>> get errors {
    final errs = _errors.map((e) {
      return e as Map<String, dynamic>;
    }).toList();

    return errs;
  }

  @override
  List<Object?> get props => [_errors];
}
