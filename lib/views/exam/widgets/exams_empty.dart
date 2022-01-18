import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:flutter/material.dart';

class ExamsEmpty extends StatelessWidget {
  const ExamsEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "You don't have any exams.\n"
        'Click ➕ to add exam',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: kPlaceholderDarkColor,
          fontSize: SPACING.LG.size,
        ),
      ),
    );
  }
}
