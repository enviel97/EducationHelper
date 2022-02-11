import 'package:bordered_text/bordered_text.dart';
import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/datetime_x.dart';
import 'package:education_helper/helpers/extensions/string_x.dart';
import 'package:education_helper/models/answer.model.dart';
import 'package:education_helper/views/topic/typings/color_status.dart';
import 'package:education_helper/views/widgets/form/custom_multi_text_field.dart';
import 'package:flutter/material.dart';

class HeaderAnswerCollapsed extends StatelessWidget {
  final String memberName, review, infoMember;
  final DateTime? submitdate;
  final StatusAnswer status;
  final Function(String note) onChanged;
  const HeaderAnswerCollapsed({
    required this.memberName,
    required this.submitdate,
    required this.status,
    required this.onChanged,
    required this.review,
    required this.infoMember,
    Key? key,
  }) : super(key: key);

  Color get color => getStatusColor(status);
  @override
  Widget build(BuildContext context) {
    const format = 'MMM dd,yyyy - hh:mm';
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Tooltip(
          message: infoMember,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 10.0,
            ),
            decoration: const BoxDecoration(
              color: kPrimaryDarkColor,
              borderRadius: BorderRadius.all(
                Radius.circular(40.0),
              ),
            ),
            child: Text(
              memberName,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ),
        ),
        SPACING.M.vertical,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                'Date: '
                '${submitdate?.toStringFormat(format: format) ?? 'Loading'}',
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
        SPACING.M.vertical,
        KMultiTextField(
          labelText: 'Review',
          initValue: review,
          hintText: 'Say somthing you ...',
          hintStyle: TextStyle(color: kBlackColor.withOpacity(.7)),
          textStyle: const TextStyle(color: kBlackColor),
          onChange: onChanged,
        ),
        SPACING.M.vertical,
      ],
    );
  }
}
