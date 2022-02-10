import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/ultils/funtions.dart';
import 'package:education_helper/views/classrooms/widgets/user_avatar.dart';

import 'package:flutter/material.dart';

class ClassroomHeader extends StatefulWidget {
  final String avatar;
  final String name;
  final String email;
  final int totalClassroom;
  final int totalExams;

  const ClassroomHeader({
    required this.totalExams,
    required this.totalClassroom,
    required this.avatar,
    required this.name,
    required this.email,
    Key? key,
  }) : super(key: key);

  @override
  State<ClassroomHeader> createState() => _ClassroomHeaderState();
}

class _ClassroomHeaderState extends State<ClassroomHeader> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        UserAvatar(url: widget.avatar),
        SPACING.M.horizontal,
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.name,
                style: TextStyle(
                  fontSize: SPACING.LG.size,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SPACING.S.vertical,
              Text(
                widget.email,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: SPACING.M.size,
                ),
              ),
              SPACING.S.vertical,
              Flexible(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    ' ${quantity(widget.totalExams, 'exam')}',
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: SPACING.M.size,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: SPACING.M.size,
                    child: const VerticalDivider(
                      color: kPrimaryColor,
                      thickness: 2.0,
                    ),
                  ),
                  Text(
                    quantity(widget.totalClassroom, 'classroom'),
                    style: TextStyle(
                      fontSize: SPACING.M.size,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ))
            ],
          ),
        ),
      ],
    );
  }
}
