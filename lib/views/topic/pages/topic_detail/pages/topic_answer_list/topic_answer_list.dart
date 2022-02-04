import 'package:education_helper/helpers/ultils/funtions.dart';
import 'package:education_helper/models/classroom.model.dart';
import 'package:education_helper/models/members.model.dart';
import 'package:education_helper/models/topic.model.dart';
import 'package:education_helper/views/topic/streams/group_by_status.dart';
import 'package:flutter/material.dart';

import 'pages/answer_members_list.dart';
import 'pages/status_total.dart';

class TopicAnswerList extends StatefulWidget {
  final List<Answer> answers;
  final Classroom classroom;
  final DateTime? expiredDate;
  const TopicAnswerList({
    required this.answers,
    required this.classroom,
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
  late Classroom classroom;

  @override
  void initState() {
    super.initState();
    classroom = widget.classroom;
    members = mapToList(classroom.members, Member.fromJson);
    answers = widget.answers;

    _controller = GroupByStatus(members, answers);
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
            controller: _controller.stream,
            members: members,
            idClassroom: classroom.id,
            onSearch: _controller.search,
            expiredDate: widget.expiredDate,
          ),
        ),
      ],
    );
  }
}
