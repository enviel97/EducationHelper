import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/views/classrooms/widgets/classroom_exams_total.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class ClassroomItemHeader extends StatelessWidget {
  final String name;
  final Function() onAddCSV;
  final Function() editClassroom;
  final Function() removeClassroom;
  final int exams;
  final int members;

  const ClassroomItemHeader({
    required this.name,
    required this.onAddCSV,
    required this.editClassroom,
    required this.removeClassroom,
    required this.exams,
    required this.members,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = SPACING.M.size * 1.2;
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
                  fontSize: size,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: SPACING.SM.size,
              child: const VerticalDivider(thickness: 2.0),
            ),
            SPACING.M.horizontal,
            IconButton(
              splashColor: Colors.transparent,
              constraints: BoxConstraints(
                maxHeight: size,
                minWidth: size,
              ),
              icon: const Icon(Feather.edit),
              tooltip: 'Edit classroom',
              color: kPlaceholderDarkColor,
              padding: const EdgeInsets.all(0.0),
              iconSize: size,
              onPressed: editClassroom,
            ),
            SPACING.M.horizontal,
            IconButton(
              splashColor: Colors.transparent,
              constraints: BoxConstraints(
                maxHeight: size,
                minWidth: size,
              ),
              icon: const Icon(Icons.delete_forever_rounded),
              tooltip: 'Remove classroom',
              color: kPlaceholderDarkColor,
              padding: const EdgeInsets.all(0.0),
              iconSize: size * 1.2,
              onPressed: removeClassroom,
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
