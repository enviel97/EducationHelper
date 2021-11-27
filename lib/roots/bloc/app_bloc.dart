import 'package:education_helper/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_state.dart';

class AppBloc extends Cubit<AppState> {
  AppBloc() : super(AppStateInitial());

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

  void showSuccess(BuildContext context, String message,
      {int timeWait = 3000}) {
    ScaffoldMessenger.of(context)
        .showSnackBar(_snackBar(message, kSuccessColor, timeWait));
  }

  void showLoading(BuildContext context, {int timeWait = 3000}) {}
}
