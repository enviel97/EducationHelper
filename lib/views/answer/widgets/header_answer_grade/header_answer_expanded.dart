import 'package:bordered_text/bordered_text.dart';
import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/string_x.dart';
import 'package:education_helper/models/topic.model.dart';
import 'package:education_helper/views/topic/typings/color_status.dart';
import 'package:flutter/material.dart';

class HeaderAnswerExpanded extends StatelessWidget {
  final String memberName;
  final StatusAnswer status;
  const HeaderAnswerExpanded({
    required this.memberName,
    required this.status,
    Key? key,
  }) : super(key: key);

  Color get color => getStatusColor(status);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              memberName,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: kBlackColor,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ),
          SPACING.M.horizontal,
          BorderedText(
            strokeWidth: 4.0,
            strokeColor: kBlackColor,
            child: Text(
              status.name.toUperCaseFirst(),
              style: TextStyle(
                color: color,
                fontSize: SPACING.M.size * 1.2,
              ),
            ),
          )
        ],
      ),
    );
  }
}
