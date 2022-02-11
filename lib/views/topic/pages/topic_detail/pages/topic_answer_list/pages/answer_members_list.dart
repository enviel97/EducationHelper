import 'package:education_helper/models/answer.model.dart';
import 'package:education_helper/models/members.model.dart';
import 'package:education_helper/views/topic/blocs/member/topic_members_bloc.dart';
import 'package:education_helper/views/topic/pages/topic_detail/pages/topic_answer_list/streams/group_by_status.dart';
import 'package:education_helper/views/topic/pages/topic_detail/pages/topic_answer_list/widgets/answer_list_empty.dart';
import 'package:education_helper/views/topic/pages/topic_detail/pages/topic_answer_list/widgets/answer_list_error.dart';
import 'package:education_helper/views/topic/pages/topic_detail/pages/topic_answer_list/widgets/topic_answer_item.dart';

import 'package:education_helper/views/widgets/list/list_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnswerMembersList extends StatelessWidget {
  final List<Member> members;
  final GroupByStatus controller;
  const AnswerMembersList({
    required this.controller,
    required this.members,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Member>>(
      initialData: members,
      stream: controller.stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const AnswerListError();
        }
        return ListBuilder<Member>(
          datas: snapshot.data ?? [],
          margin: const EdgeInsets.all(8.0),
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          emptyList: const AnswerListEmpty(),
          shirinkWrap: false,
          itemBuilder: _itemBuilder,
          onRefresh: () => _onRefresh(context),
        );
      },
    );
  }

  Widget _itemBuilder(Member data) {
    return TopicAnswerItem(
      member: data,
      isDisable: false,
      status: controller.answerGroup[data.uid]?['status'] ?? StatusAnswer.empty,
      grade: controller.answerGroup[data.uid]?['grade'] ?? 0.0,
      idAnswer: controller.answerGroup[data.uid]?['id'] ?? '',
    );
  }

  Future<void> _onRefresh(BuildContext context) async {
    BlocProvider.of<TopicMembersBloc>(context).refreshMembers();
  }
}
