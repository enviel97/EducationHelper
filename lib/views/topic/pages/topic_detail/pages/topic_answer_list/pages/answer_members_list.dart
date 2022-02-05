import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:education_helper/models/members.model.dart';
import 'package:education_helper/models/topic.model.dart';
import 'package:education_helper/views/topic/pages/topic_detail/pages/topic_answer_list/widgets/answer_list_empty.dart';
import 'package:education_helper/views/topic/pages/topic_detail/pages/topic_answer_list/widgets/answer_list_error.dart';
import 'package:education_helper/views/topic/pages/topic_detail/pages/topic_answer_list/widgets/topic_answer_item.dart';

import 'package:education_helper/views/widgets/form/custom_search_field.dart';
import 'package:education_helper/views/widgets/list/list_builder.dart';
import 'package:flutter/material.dart';

class AnswerMembersList extends StatelessWidget {
  final List<Member> members;
  final String idClassroom;
  final DateTime? expiredDate;
  final Stream<List<Member>> controller;
  final Function(String value) onSearch;
  const AnswerMembersList({
    required this.controller,
    required this.members,
    required this.idClassroom,
    required this.onSearch,
    required this.expiredDate,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final color = context.isLightTheme ? kPrimaryDarkColor : kPrimaryLightColor;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(25.0), bottomLeft: Radius.circular(25.0)),
        boxShadow: [
          BoxShadow(
            color: color,
            offset: const Offset(4.0, 4.0),
            blurRadius: 10.0,
          )
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            child: KSearchText(
              hintText: 'Search with name',
              onSearch: onSearch,
            ),
          ),
          Flexible(
            child: StreamBuilder<List<Member>>(
              initialData: members,
              stream: controller,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const AnswerListError();
                }
                return ListBuilder<Member>(
                  datas: snapshot.data ?? [],
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  emptyList: AnswerListEmpty(id: idClassroom),
                  shirinkWrap: false,
                  itemBuilder: _itemBuilder,
                  onRefresh: _onRefresh,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _itemBuilder(Member data) {
    return TopicAnswerItem(
      member: data,
      isDisable: expiredDate?.isBefore(DateTime.now()) ?? false,
      status: StatusAnswer.empty,
      grade: 0.0,
      idAnswer: '',
    );
  }

  Future<void> _onRefresh() async {}
}
