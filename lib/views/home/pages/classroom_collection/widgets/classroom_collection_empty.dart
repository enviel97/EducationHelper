import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/views/widgets/button/custom_text_button.dart';
import 'package:flutter/material.dart';

class ClassroomCollectionEmpty extends StatelessWidget {
  final Function() goToClassrooms;
  final String? error;
  const ClassroomCollectionEmpty({
    required this.goToClassrooms,
    Key? key,
    this.error,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          error ?? "You don't have any classrooms",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: kPlaceholderDarkColor,
            fontSize: SPACING.LG.size,
          ),
        ),
        SPACING.LG.vertical,
        error?.isEmpty ?? true
            ? KTextButton(
                text: 'Go To Classroom List', onPressed: goToClassrooms)
            : const SizedBox.shrink(),
      ],
    );
  }
}
