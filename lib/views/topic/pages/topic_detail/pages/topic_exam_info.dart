import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:education_helper/helpers/extensions/datetime_x.dart';
import 'package:education_helper/models/exam.model.dart';
import 'package:education_helper/views/topic/pages/topic_detail/widgets/open_exam_button.dart';
import 'package:education_helper/views/topic/pages/topic_form/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class TopicExamInfo extends StatelessWidget {
  final Exam? exam;
  final DateTime? createAt;
  final String classname;
  final DateTime? expiredAt;
  const TopicExamInfo({
    this.exam,
    this.createAt,
    this.expiredAt,
    this.classname = '',
    Key? key,
  }) : super(key: key);

  String dateToString(DateTime? date) =>
      date?.toStringFormat(format: 'MMM dd,yyyy  -  hh:mm') ?? 'Loading...';

  @override
  Widget build(BuildContext context) {
    final highlightColor =
        context.isLightTheme ? kSecondaryDarkColor : kSecondaryLightColor;
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                  Flexible(
                      flex: 2,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Text(classname,
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: kWhiteColor,
                                        fontSize: SPACING.M.size * 1.2,
                                        fontWeight: FontWeight.bold))),
                            SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Text(exam?.name ?? 'Loading...',
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: highlightColor,
                                        fontSize: SPACING.LG.size,
                                        fontWeight: FontWeight.bold))),
                            Text(
                                'Subject: '
                                '${exam?.subject ?? 'Loading...'}',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: SPACING.M.size))
                          ])),
                  Flexible(
                    child: OpenExamButton(
                      disable: exam == null,
                      type: exam?.type ?? '',
                      id: exam?.id ?? '',
                    ),
                  )
                ])),
            SPACING.S.vertical,
            KText(
                text: dateToString(createAt),
                colorText: highlightColor,
                label: 'Create date',
                colorLabel: context.isLightTheme ? kBlackColor : kWhiteColor,
                sizeLabel: SPACING.M.size),
            SPACING.S.vertical,
            KText(
                text: dateToString(expiredAt),
                colorText: highlightColor,
                label: 'Expired date',
                colorLabel: context.isLightTheme ? kBlackColor : kWhiteColor,
                sizeLabel: SPACING.M.size)
          ],
        ));
  }
}
