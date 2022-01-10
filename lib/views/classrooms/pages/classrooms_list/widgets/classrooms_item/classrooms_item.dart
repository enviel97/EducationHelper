import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:education_helper/models/classroom.model.dart';
import 'package:education_helper/views/classrooms/dialogs/classroom_dialog.dart';
import 'package:education_helper/views/classrooms/pages/classroom_detail/classroom_detail.dart';
import 'package:flutter/material.dart';

import 'classroom_item_empty.dart';
import 'widgets/classroom_item_body.dart';
import 'widgets/classroom_item_header.dart';

class ClassroomItem extends StatelessWidget {
  final Classroom classroom;
  const ClassroomItem({
    required this.classroom,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.goTo(ClassroomDetail(id: classroom.id)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SPACING.LG.vertical,
          ClassroomItemHeader(
            name: classroom.name,
            exams: classroom.exams.length,
            members: classroom.members.length,
            onAddCSV: () {},
            editClassroom: () => editClassroom(
              context,
              classroom.name,
              classroom.id,
            ),
            removeClassroom: () => deleteClassroom(
              context,
              classroom.name,
              classroom.id,
            ),
          ),
          SPACING.S.vertical,
          classroom.members.isNotEmpty
              ? ClassroomItemBody(members: classroom.members)
              : const ClassroomItemEmpty(),
        ],
      ),
    );
  }
}
