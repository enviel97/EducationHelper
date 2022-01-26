import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/views/widgets/button/custom_text_button.dart';
import 'package:flutter/material.dart';

class ExamCollectionEmpty extends StatelessWidget {
  final Function() onStateHandle;
  final String title;
  final String messneger;
  final bool loading;
  const ExamCollectionEmpty({
    required this.onStateHandle,
    Key? key,
    this.messneger = "You don't have any Exams",
    this.title = 'Go To Exams List',
    this.loading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            messneger,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: kPlaceholderDarkColor,
              fontSize: SPACING.LG.size,
            ),
          ),
          SPACING.LG.vertical,
          KTextButton(text: title, onPressed: loading ? null : onStateHandle)
        ],
      ),
    );
  }
}
