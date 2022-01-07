import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/views/widgets/button/custom_link_button.dart';
import 'package:flutter/material.dart';

import 'classroom_exams_total.dart';

class ClassroomItemHeader extends StatelessWidget {
  final String name;
  final Function() onAddCSV;
  final Function() onAddMember;
  final int exams;
  final int members;

  const ClassroomItemHeader({
    required this.name,
    required this.onAddCSV,
    required this.onAddMember,
    required this.exams,
    required this.members,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            KLinkButton(
              name,
              isBold: true,
              maxWidth: 125.0,
              fontSize: SPACING.M.size,
              onPress: () {
                print('detail');
              },
            ),
            SizedBox(
              height: SPACING.SM.size,
              child: const VerticalDivider(thickness: 2.0),
            ),
            KLinkButton(
              'ADD WITH CSV +',
              color: kDividerColor,
              fontSize: SPACING.SM.size,
              onPress: () {
                print('OpenCSV file');
              },
            )
          ],
        ),
        ClassroomExamsTotal(
          totalExams: exams,
          totalMembers: members,
        )
      ],
    );
  }
}
