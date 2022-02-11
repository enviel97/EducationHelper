import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/views/topic/blocs/member/topic_members_bloc.dart';
import 'package:education_helper/views/topic/blocs/topic/topic_bloc.dart';
import 'package:education_helper/views/topic/topics.dart';
import 'package:education_helper/views/widgets/button/custom_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnswerListEmpty extends StatelessWidget {
  const AnswerListEmpty({
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
    final topic = BlocProvider.of<TopicBloc>(context).topic;
    final isNeedRefresh =
        await Topics.adapter.goToClassroom(context, topic.classroom.id);
    if (isNeedRefresh) {
      BlocProvider.of<TopicMembersBloc>(context).refreshMembers();
    }
  }
}
