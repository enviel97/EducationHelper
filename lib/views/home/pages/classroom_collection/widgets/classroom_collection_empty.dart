import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/views/widgets/button/custom_text_button.dart';
import 'package:flutter/material.dart';

class ClassroomCollectionEmpty extends StatelessWidget {
  final Function() goToClassrooms;
  const ClassroomCollectionEmpty({
    required this.goToClassrooms,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "You don't have any classrooms",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: kPlaceholderDarkColor,
            fontSize: SPACING.LG.size,
          ),
        ),
        SPACING.LG.vertical,
        KTextButton(text: 'Go To Classroom List', onPressed: goToClassrooms),
      ],
    );
  }
}
