import 'package:education_helper/constants/colors.dart';
import 'package:flutter/material.dart';

confirmDialog(
  BuildContext context, {
  required String title,
  required String content,
  required VoidCallback okConfirm,
}) {
  final okButton = TextButton(
    child: const Text('OK', style: TextStyle(color: kPrimaryColor)),
    onPressed: okConfirm,
  );

  // set up the AlertDialog
  final alert = AlertDialog(
    title: Text(title),
    content: Text(content),
    elevation: 5.0,
    actions: [okButton],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (_) => alert,
  );
}
