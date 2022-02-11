import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/constant.dart' as c;
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:education_helper/models/user.model.dart';
import 'package:education_helper/roots/app_root.dart';
import 'package:education_helper/roots/miragate/http.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'app_state.dart';

class AppBloc extends Cubit<AppState> {
  final api = RestApi();
  AppBloc() : super(AppStateInitial());
  bool _hasDialog = false;
  User? _currentUser;
  String? token;

  SnackBar _snackBar(String message, Color color, int timeWait) => SnackBar(
        backgroundColor: color,
        dismissDirection: DismissDirection.endToStart,
        duration: Duration(milliseconds: timeWait),
        content: Text(
          message,
          style: const TextStyle(
            color: kWhiteColor,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      );

  void showError(BuildContext context, String message, {int timeWait = 3000}) {
    ScaffoldMessenger.of(context)
        .showSnackBar(_snackBar(message, kErrorColor, timeWait));
  }

  void showNotice(BuildContext context, String message, {int timeWait = 1000}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Theme.of(context).backgroundColor,
      dismissDirection: DismissDirection.endToStart,
      duration: Duration(milliseconds: timeWait),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            message,
            style: const TextStyle(
              color: kWhiteColor,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const CircularProgressIndicator(),
        ],
      ),
    ));
  }

  void showSuccess(BuildContext context, String message,
      {int timeWait = 3000}) {
    ScaffoldMessenger.of(context)
        .showSnackBar(_snackBar(message, kSuccessColor, timeWait));
  }

  void hiddenLoading(BuildContext context) {
    if (!_hasDialog) return;
    context.goBack();
    _hasDialog = false;
  }

  void showLoading(BuildContext context, String title) {
    _hasDialog = true;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          backgroundColor: kWhiteColor,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          content: Container(
              height: 70.0,
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(children: [
                const SpinKitFadingCube(color: kPrimaryColor),
                SPACING.LG.horizontal,
                Flexible(
                  child: Text(
                    title,
                    maxLines: 1,
                    style: const TextStyle(
                        color: kBlackColor,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                        fontSize: 28.0),
                  ),
                )
              ])),
        ),
      ),
    );
  }

  bool isAuth() {
    if (token == null) {
      final _local = Root.ins.localStorage;
      token = _local.read(c.token);
    }
    return token!.isNotEmpty;
  }

  Future<void> refreshUser() async {
    _currentUser = null;
    getUser();
  }

  Future<void> getUser() async {
    if (_currentUser != null) {
      emit(UserStateSuccess(_currentUser!));
      return;
    }
    emit(UserStateLoading());
    try {
      final user = await api.get('users');
      _currentUser = User.fromJson(user);
      emit(UserStateSuccess(User.fromJson(user)));
    } catch (error) {
      debugPrint(error.toString());
      emit(const UserStateFailure("Can't get user"));
    }
  }

  Future<bool> removeToken() async {
    try {
      final isRemove = await Root.ins.localStorage.remove(c.token);
      if (isRemove) {
        api.setHeaders('');
      }
      return isRemove;
    } catch (e) {
      return false;
    }
  }
}
