import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:education_helper/models/classroom.model.dart';
import 'package:education_helper/models/members.model.dart';
import 'package:education_helper/views/classrooms/widgets/add_member_form.dart';
import 'package:flutter/material.dart';

import 'widgets/classroom_item_body.dart';
import 'widgets/classroom_item_header.dart';

class ClassroomItem extends StatefulWidget {
  final Classroom classroom;
  const ClassroomItem({
    required this.classroom,
    Key? key,
  }) : super(key: key);

  @override
  State<ClassroomItem> createState() => _ClassroomItemState();
}

class _ClassroomItemState extends State<ClassroomItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SPACING.LG.vertical,
        ClassroomItemHeader(
          name: widget.classroom.name,
          onAddCSV: () {},
          onAddMember: () {},
          exams: widget.classroom.exams.length,
          members: widget.classroom.members.length,
        ),
        SPACING.S.vertical,
        ClassroomItemBody(members: widget.classroom.members),
      ],
    );
  }

  void _addMember() {
    const borderRadius = BorderRadius.only(
      topLeft: Radius.circular(40.0),
      topRight: Radius.circular(40.0),
    );
    showModalBottomSheet(
      elevation: 1,
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: borderRadius),
      builder: (builder) {
        return AddMemberForm(
          onConfirm: (Member member) {
            //context.goBack();
          },
          addWithCSV: () {
            print('create');
          },
        );
      },
    );
  }
}
