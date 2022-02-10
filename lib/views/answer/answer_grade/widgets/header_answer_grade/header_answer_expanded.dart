import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/models/answer.model.dart';
import 'package:education_helper/views/answer/widgets/status_answer_decorate.dart';
import 'package:flutter/material.dart';

class HeaderAnswerExpanded extends StatelessWidget {
  final String memberName, infoMember;
  final StatusAnswer status;
  const HeaderAnswerExpanded({
    required this.memberName,
    required this.status,
    required this.infoMember,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Tooltip(
              message: infoMember,
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
          ),
          SPACING.M.horizontal,
          StatusAnswerDecorate(status: status),
        ],
      ),
    );
  }
}
