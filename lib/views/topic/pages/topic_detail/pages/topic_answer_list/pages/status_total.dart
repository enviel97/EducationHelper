import 'package:education_helper/models/answer.model.dart';
import 'package:education_helper/views/topic/pages/topic_detail/pages/topic_answer_list/widgets/answers_status_chip.dart';
import 'package:flutter/material.dart';

class StatusTotal extends StatelessWidget {
  final StatusAnswer? selected;
  final int submited;
  final int lated;
  final int missing;
  final void Function(StatusAnswer) onSorted;
  const StatusTotal({
    required this.submited,
    required this.lated,
    required this.missing,
    required this.onSorted,
    Key? key,
    this.selected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        AnswerStatusChip(
          isSelected: StatusAnswer.submit == selected,
          type: StatusAnswer.submit,
          quantiy: submited,
          onSorted: onSorted,
        ),
        AnswerStatusChip(
          isSelected: StatusAnswer.lated == selected,
          type: StatusAnswer.lated,
          quantiy: lated,
          onSorted: onSorted,
        ),
        AnswerStatusChip(
          isSelected: StatusAnswer.empty == selected,
          type: StatusAnswer.empty,
          quantiy: missing,
          onSorted: onSorted,
        ),
      ],
    );
  }
}
