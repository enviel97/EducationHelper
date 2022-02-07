import 'package:bordered_text/bordered_text.dart';
import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:education_helper/helpers/extensions/string_x.dart';
import 'package:education_helper/models/answer.model.dart';
import 'package:flutter/material.dart';

class AnswerStatusChip extends StatelessWidget {
  final StatusAnswer type;
  final int quantiy;
  final bool isSelected;
  final void Function(StatusAnswer type)? onSorted;
  const AnswerStatusChip({
    required this.type,
    required this.quantiy,
    this.onSorted,
    Key? key,
    this.isSelected = false,
  }) : super(key: key);

  Color get color {
    switch (type) {
      case StatusAnswer.submit:
        return const Color(0xFF60FF66);
      case StatusAnswer.lated:
        return const Color(0xFFFFEF60);
      case StatusAnswer.empty:
        return const Color(0xFFFF6060);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      tooltip: type.name,
      onPressed: () => onSorted == null ? null : onSorted!(type),
      labelPadding: const EdgeInsets.all(5.0),
      avatar: CircleAvatar(
        backgroundColor: color,
        child: BorderedText(
          strokeColor: kBlackColor,
          strokeWidth: 3.2,
          child: Text(
            '$quantiy',
            style: const TextStyle(
              color: kWhiteColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      side: isSelected
          ? BorderSide(
              color: context.isLightTheme
                  ? kSecondarySuperDarkColor
                  : kSecondaryColor,
              width: 3.0)
          : null,
      shadowColor: kPrimaryColor,
      backgroundColor: kPrimaryColor,
      elevation: 15.0,
      label: Text(
        type.name.toUperCaseFirst(),
        style: const TextStyle(color: kWhiteColor),
      ),
    );
  }
}
