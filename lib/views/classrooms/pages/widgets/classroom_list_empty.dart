import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:flutter/material.dart';

class EmptyClassroomList extends StatelessWidget {
  const EmptyClassroomList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "You don't have any classrooms.\n"
            'Click ➕ to add classroom',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: kPlaceholderDarkColor, fontSize: SPACING.LG.size),
          ),
        ],
      ),
    );
  }
}
