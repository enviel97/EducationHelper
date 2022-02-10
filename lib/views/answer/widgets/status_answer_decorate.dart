import 'package:bordered_text/bordered_text.dart';
import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/string_x.dart';
import 'package:education_helper/models/answer.model.dart';
import 'package:education_helper/views/topic/typings/color_status.dart';
import 'package:flutter/material.dart';

class StatusAnswerDecorate extends StatelessWidget {
  final StatusAnswer status;
  final Color borderColor;
  const StatusAnswerDecorate({
    required this.status,
    Key? key,
    this.borderColor = kBlackColor,
  }) : super(key: key);

  Color get color => getStatusColor(status);
  @override
  Widget build(BuildContext context) {
    return BorderedText(
      strokeWidth: 4.0,
      strokeColor: borderColor,
      child: Text(
        status.name.toUperCaseFirst(),
        style: TextStyle(
          color: color,
          fontSize: SPACING.M.size * 1.2,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
