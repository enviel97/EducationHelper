import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:flutter/material.dart';

class KConfirmAlert extends StatelessWidget {
  final Function() onConfirm;
  final String content;
  final String notice;
  final String title;
  final Future<void> Function()? onCancel;
  const KConfirmAlert({
    required this.onConfirm,
    required this.title,
    required this.notice,
    required this.content,
    Key? key,
    this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final highlightColor =
        context.isLightTheme ? kPrimaryColor : kSecondaryLightColor;
    final textColor = context.isLightTheme ? kBlackColor : kWhiteColor;
    return AlertDialog(
      titleTextStyle: TextStyle(color: highlightColor),
      elevation: 20.0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: textColor.withOpacity(0.2), width: 1),
        borderRadius: const BorderRadius.all(Radius.circular(20.0)),
      ),
      title: Text(title),
      content: RichText(
        text: TextSpan(children: [
          TextSpan(
            text: notice,
            style: TextStyle(fontSize: SPACING.M.size),
          ),
          TextSpan(
              text: content,
              style: TextStyle(
                color: highlightColor,
                fontSize: SPACING.M.size * 1.2,
              )),
        ]),
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.check, color: kErrorColor),
          onPressed: onConfirm,
        ),
        IconButton(
            icon: Icon(Icons.close, color: textColor),
            onPressed: () => _onGoBack(context))
      ],
    );
  }

  void _onGoBack(BuildContext context) {
    if (onCancel != null) {
      onCancel!().whenComplete(context.goBack);
    } else {
      context.goBack();
    }
  }
}
