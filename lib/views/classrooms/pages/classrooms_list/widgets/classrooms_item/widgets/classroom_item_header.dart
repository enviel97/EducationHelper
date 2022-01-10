import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/views/classrooms/widgets/classroom_exams_total.dart';
import 'package:education_helper/views/widgets/button/custom_link_button.dart';
import 'package:flutter/material.dart';

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
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 125.0),
              child: Text(
                name,
                maxLines: 1,
                softWrap: false,
                overflow: TextOverflow.fade,
                style: TextStyle(
                  fontSize: SPACING.M.size,
                  fontWeight: FontWeight.bold,
                ),
              ),
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
