import 'package:education_helper/constants/constant.dart' as c;
import 'package:education_helper/models/topic.model.dart';
import 'package:education_helper/models/user.model.dart';
import 'package:education_helper/roots/miragate/google_sigin.dart';
import 'package:education_helper/roots/miragate/http.dart';
import 'package:education_helper/roots/miragate/local_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_state.dart';

// enum TypeSignin { google, email }

// // ignore: camel_case_extensions
// extension _ on TypeSignin {
//   String get value => toString().split('.')[1];
// }

class AuthBloc extends Cubit<AuthState> {
  final _path = '/auth';
  final LocalStorage _storage;
  late RestApi _restApi;
  late GoogleAuth ggAuth;
  AuthBloc(this._storage) : super(AuthInitialState()) {
    _restApi = RestApi();
    ggAuth = GoogleAuth();
  }

  Future<void> signInWithEmail(
    String username,
    String password,
  ) async {
    emit(AuthLoadingState());
    try {
      final result = await _restApi.post(
        '$_path/signin/email',
        {'email': username, 'password': password},
      );
      final String token = result[c.token] ?? '';
      await _storage.write(c.token, token).whenComplete(() async {
        emit(AuthSigninSuccessState(token));
        _restApi.setHeaders(token);
      });
    } catch (error) {
      onErrors(error);
    }
  }

  Future<void> signInWithGoogle() async {
    emit(AuthLoadingState());

    try {
      final account = await ggAuth.googleSignIn();
      if (account != null) {
        final result = await _restApi.post(
          '$_path/signin/google',
          {
            'id': account.id,
            'email': account.email,
            'password': '@user_${account.email.split("@")[0]}',
            'name': account.displayName,
            'avatar': account.photoUrl,
          },
        );
        final String token = result[c.token] ?? '';
        if (token.isNotEmpty) {
          await _storage.write(c.token, token).whenComplete(() async {
            emit(AuthSigninSuccessState(token));
            _restApi.setHeaders(token);
          });
        }
      }
    } catch (error) {
      onErrors(error);
    }
  }

  Future<void> signUp(User user, String password) async {
    emit(AuthLoadingState());
    final json = user.toJson();
    json['password'] = password;
    try {
      final result = await _restApi.post('$_path/signup', json);
      emit(AuthSignupSuccessState(User.fromJson(result)));
    } catch (error) {
      onErrors(error);
    }
  }

  Future<Topic?> checkId(String idTopic) async {
    try {
      final result = await _restApi.get('topics/$idTopic').catchError((error) {
        emit(AuthErrorState(error['error'] ?? "Don't know"));
        return null;
      });
      if (result == null) return null;
      final topic = Topic.fromJson(result);
      return topic;
    } catch (e) {
      emit(const AuthErrorState('Error system'));
      return null;
    }
  }

  void onErrors(Object error) {
    try {
      final errs = error as Map<String, dynamic>;
      if (error['error'] != null) {
        emit(AuthErrorState(errs['error']));
        return;
      }
      if (error['errors'] != null) {
        emit(AuthErrorsState(errs['errors']));
        return;
      }
    } catch (error) {
      debugPrint('[Error system]: $error');
      emit(const AuthErrorState('System error'));
    }
  }
}
