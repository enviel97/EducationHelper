import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:education_helper/models/topic.model.dart';
import 'package:education_helper/views/topic/pages/topic_detail/pages/topic_answer_list/widgets/answers_status_chip.dart';
import 'package:education_helper/views/widgets/form/custom_search_field.dart';
import 'package:flutter/material.dart';

class PListMembersAnswers extends StatelessWidget {
  const PListMembersAnswers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = context.isLightTheme ? kPrimaryDarkColor : kPrimaryLightColor;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const AnswerStatusChip(
              isSelected: false,
              type: StatusAnswer.submit,
              quantiy: 0,
            ),
            const AnswerStatusChip(
              isSelected: false,
              type: StatusAnswer.lated,
              quantiy: 00,
            ),
            const AnswerStatusChip(
              isSelected: false,
              type: StatusAnswer.empty,
              quantiy: 0,
            ),
          ],
        ),
        Expanded(
          child: Container(
            margin:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            decoration: BoxDecoration(
              color: kWhiteColor,
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(25.0),
                  bottomLeft: Radius.circular(25.0)),
              boxShadow: [
                BoxShadow(
                    color: color,
                    offset: const Offset(4.0, 4.0),
                    blurRadius: 10.0)
              ],
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: KSearchText(hintText: 'Search', onSearch: (value) {}),
                ),
                const Expanded(
                  child: Center(child: CircularProgressIndicator()),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
