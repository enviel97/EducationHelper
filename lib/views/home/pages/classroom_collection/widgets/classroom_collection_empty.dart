import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/views/widgets/button/custom_text_button.dart';
import 'package:flutter/material.dart';

class ClassroomCollectionEmpty extends StatelessWidget {
  final Function() onStateHandle;
  final String title;
  final String messneger;
  final bool loading;
  const ClassroomCollectionEmpty({
    required this.onStateHandle,
    Key? key,
    this.title = 'Go To Classroom List',
    this.messneger = "You don't have any classrooms",
    this.loading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
