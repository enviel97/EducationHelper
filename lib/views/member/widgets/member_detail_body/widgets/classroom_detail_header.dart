import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:education_helper/views/classrooms/widgets/classroom_exams_total.dart';
import 'package:flutter/material.dart';

class ClassroomDetailHeader extends StatelessWidget {
  final String name;
  final int numExams;
  final int numMembers;

  const ClassroomDetailHeader({
    required this.name,
    required this.numExams,
    required this.numMembers,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = context.mediaSize.width;

    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: width * 2 / 3),
            child: Text(
              name,
              maxLines: 2,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ),
          ClassroomExamsTotal(
            totalExams: numExams,
            totalMembers: numMembers,
          )
        ],
      ),
    );
  }
}
