import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/models/answer.model.dart';
import 'package:education_helper/views/topic/typings/color_schema.dart';
import 'package:education_helper/views/topic/widgets/answer_status.dart';
import 'package:flutter/material.dart';

class TopicAnswerItem extends StatelessWidget {
  final int answerTotal;

  final int success;

  final int lated;

  final int missing;

  final String type;

  const TopicAnswerItem({
    required this.answerTotal,
    required this.success,
    required this.lated,
    required this.missing,
    required this.type,
    Key? key,
  }) : super(key: key);

  ColorSchema get colorSchema => ColorSchema.industry(type);

  @override
  Widget build(BuildContext context) {
    const radius = 25.0;
    const height = 210.0;
    return Row(
      children: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Answers: $answerTotal',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: SPACING.M.size,
                    fontWeight: FontWeight.bold,
                    color: kWhiteColor,
                  ),
                ),
                SPACING.M.vertical,
                Flexible(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      AnswerStatus(
                        number: success,
                        type: StatusAnswer.submit,
                        tooltip: 'Submitted',
                      ),
                      AnswerStatus(
                          number: lated,
                          type: StatusAnswer.lated,
                          tooltip: 'Lated'),
                      AnswerStatus(
                          number: missing,
                          type: StatusAnswer.empty,
                          tooltip: 'Missing')
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Flexible(
          child: Container(
            decoration: const BoxDecoration(
              color: kWhiteColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radius),
                bottomRight: Radius.circular(radius),
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              '.$type',
              style: TextStyle(
                  color: colorSchema.color,
                  fontSize: height / 4,
                  fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    );
  }
}
