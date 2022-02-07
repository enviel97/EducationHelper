import 'package:bordered_text/bordered_text.dart';
import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/models/answer.model.dart';
import 'package:education_helper/views/topic/typings/color_status.dart';
import 'package:flutter/material.dart';

class AnswerGrade extends StatelessWidget {
  final StatusAnswer status;
  final double? grade;
  const AnswerGrade({
    required this.status,
    required this.grade,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: getStatusColor(status),
      child: BorderedText(
        strokeColor: kBlackColor,
        strokeWidth: 3.2,
        child: Text(
          '${grade ?? ''}',
          style: const TextStyle(
            color: kWhiteColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
