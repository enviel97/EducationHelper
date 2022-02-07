import 'package:bordered_text/bordered_text.dart';
import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/helpers/extensions/int_x.dart';
import 'package:education_helper/models/answer.model.dart';
import 'package:education_helper/views/topic/typings/color_status.dart';
import 'package:flutter/material.dart';

class AnswerStatus extends StatelessWidget {
  final double size;
  final int number;
  final StatusAnswer type;
  final String? tooltip;
  final Color colorShadow;
  const AnswerStatus({
    required this.number,
    required this.type,
    this.tooltip,
    this.size = 16.0,
    this.colorShadow = kBlackColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip ?? '',
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: getStatusColor(type),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: colorShadow.withOpacity(0.7),
              offset: const Offset(2.0, 2.0),
              blurRadius: 4.0,
            )
          ],
        ),
        child: BorderedText(
          strokeWidth: 2.0,
          strokeColor: kBlackColor,
          child: Text(
            number.str,
            style: TextStyle(
              color: kWhiteColor,
              fontSize: size,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
