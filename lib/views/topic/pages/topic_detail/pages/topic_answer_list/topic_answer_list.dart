import 'package:education_helper/models/answer.model.dart';
import 'package:education_helper/models/members.model.dart';
import 'package:flutter/material.dart';

import 'pages/answer_members_list.dart';
import 'pages/status_total.dart';
import 'streams/group_by_status.dart';

class TopicAnswerList extends StatefulWidget {
  final String idClassroom;
  final List<Answer> answers;
  final List<Member> members;
  final DateTime? expiredDate;
  const TopicAnswerList({
    required this.answers,
    required this.members,
    required this.idClassroom,
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
        members = widget.members;
        answers = widget.answers;
        _controller = GroupByStatus(members, answers);
        submited =
            answers.where((ans) => ans.status == StatusAnswer.submit).length;
        lated = answers.where((ans) => ans.status == StatusAnswer.lated).length;
        missing = members.length - submited - lated;
      });
    }
  }

  @override
  void didUpdateWidget(TopicAnswerList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.members != widget.members ||
        widget.answers != oldWidget.answers) {
      _init();
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
          child: AnswerMembersList(
            controller: _controller,
            members: widget.members, // init
            idClassroom: widget.idClassroom,
          ),
        ),
      ],
    );
  }
}
