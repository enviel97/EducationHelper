import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:education_helper/helpers/extensions/datetime_x.dart';
import 'package:education_helper/models/exam.model.dart';
import 'package:education_helper/views/topic/pages/topic_detail/widgets/open_exam_button.dart';
import 'package:education_helper/views/topic/pages/topic_form/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class TopicExamInfo extends StatelessWidget {
  final Exam exam;
  final DateTime createDate;
  final DateTime expiredDate;
  const TopicExamInfo({
    required this.exam,
    required this.createDate,
    required this.expiredDate,
    Key? key,
  }) : super(key: key);

  String dateToString(DateTime date) =>
      date.toStringFormat(format: 'MMM dd,yyyy  -  hh:mm');

  @override
  Widget build(BuildContext context) {
    final highlightColor =
        context.isLightTheme ? kSecondaryDarkColor : kSecondaryLightColor;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 5.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        exam.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: highlightColor,
                          fontSize: SPACING.LG.size,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Subject: ${exam.subject}',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: SPACING.M.size),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: OpenExamButton(
                    type: exam.type,
                    id: exam.id,
                  ),
                )
              ],
            ),
          ),
          SPACING.S.vertical,
          KText(
            text: dateToString(createDate),
            colorText: highlightColor,
            label: 'Create date',
            colorLabel: context.isLightTheme ? kBlackColor : kWhiteColor,
            sizeLabel: SPACING.M.size,
          ),
          SPACING.S.vertical,
          KText(
            text: dateToString(expiredDate),
            colorText: highlightColor,
            label: 'Expired date',
            colorLabel: context.isLightTheme ? kBlackColor : kWhiteColor,
            sizeLabel: SPACING.M.size,
          ),
        ],
      ),
    );
  }
}
