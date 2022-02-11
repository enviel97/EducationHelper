import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/helpers/extensions/state.x.dart';
import 'package:education_helper/models/answer.model.dart';
import 'package:education_helper/models/members.model.dart';
import 'package:education_helper/views/topic/blocs/member/topic_members_bloc.dart';
import 'package:education_helper/views/topic/blocs/member/topic_members_state.dart';
import 'package:education_helper/views/topic/pages/topic_detail/pages/topic_answer_list/widgets/answer_list_error.dart';
import 'package:education_helper/views/widgets/form/custom_search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'pages/answer_members_list.dart';
import 'pages/status_total.dart';
import 'streams/group_by_status.dart';

class TopicAnswerList extends StatefulWidget {
  final DateTime? expiredDate;
  const TopicAnswerList({
    Key? key,
    this.expiredDate,
  }) : super(key: key);

  @override
  State<TopicAnswerList> createState() => _TopicAnswerListState();
}

class _TopicAnswerListState extends State<TopicAnswerList> {
  int submited = 0;
  int lated = 0;
  int missing = 0;
  StatusAnswer? selected;
  List<Member> members = [];
  List<Answer> answers = [];
  late GroupByStatus _controller;

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() {
    if (mounted) {
      setState(() {
        _controller = GroupByStatus(members, answers);
        submited =
            answers.where((ans) => ans.status == StatusAnswer.submit).length;
        lated = answers.where((ans) => ans.status == StatusAnswer.lated).length;
        missing = members.length - submited - lated;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onSorted(StatusAnswer type) {
    if (mounted) {
      setState(() {
        if (selected == type) {
          selected = null;
        } else {
          selected = type;
        }
      });
      _controller.sorted(type);
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = isLightTheme ? kPrimaryDarkColor : kPrimaryLightColor;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        StatusTotal(
          onSorted: _onSorted,
          selected: selected,
          submited: submited,
          lated: lated,
          missing: missing,
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            decoration: BoxDecoration(
              color: kWhiteColor,
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(25.0),
                  bottomLeft: Radius.circular(25.0)),
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
                    onSearch: _controller.search,
                  ),
                ),
                Expanded(
                  child: BlocConsumer<TopicMembersBloc, TopicMembersState>(
                    listener: (context, state) {
                      if (state is TopicMembersLoaded) {
                        setState(() {
                          members = state.members;
                          answers = state.answers;
                        });
                        _init();
                      }
                    },
                    builder: (context, state) {
                      if (state is TopicMembersInitial ||
                          state is TopicMembersLoading && members.isEmpty) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (state is TopicMembersFailure) {
                        return const AnswerListError();
                      }

                      return AnswerMembersList(
                        controller: _controller,
                        members: members,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
