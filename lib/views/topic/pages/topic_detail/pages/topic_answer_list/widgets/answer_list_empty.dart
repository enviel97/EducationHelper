import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/views/topic/topics.dart';
import 'package:education_helper/views/widgets/button/custom_text_button.dart';
import 'package:flutter/material.dart';

class AnswerListEmpty extends StatelessWidget {
  final String id;
  const AnswerListEmpty({
    required this.id,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have any members in classrooms",
          style: TextStyle(
            color: kBlackColor,
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
        SPACING.LG.vertical,
        KTextButton(
            onPressed: () => _goToMember(context), text: 'Add More Members'),
      ],
    );
  }

  _goToMember(BuildContext context) async {
    final isNeedRefresh = await Topics.adapter.goToClassroom(context, id);
    if (isNeedRefresh) {
      // Todo: Update
    }
  }
}
