import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/helpers/extensions/state.x.dart';
import 'package:education_helper/models/members.model.dart';
import 'package:education_helper/models/topic.model.dart';
import 'package:education_helper/views/topic/pages/topic_detail/widgets/topic_answer_item.dart';
import 'package:education_helper/views/topic/typings/group_by_status.dart';
import 'package:education_helper/views/widgets/form/custom_search_field.dart';
import 'package:education_helper/views/widgets/list/list_builder.dart';
import 'package:flutter/material.dart';
import '../widgets/answers_status_chip.dart';

class TopicAnswerList extends StatefulWidget {
  final List<Member> members;
  final List<Answer> answers;
  final int submited;
  final int lated;
  final int missing;
  const TopicAnswerList({
    required this.members,
    required this.answers,
    required this.submited,
    required this.lated,
    required this.missing,
    Key? key,
  }) : super(key: key);

  @override
  State<TopicAnswerList> createState() => _TopicAnswerListState();
}

class _TopicAnswerListState extends State<TopicAnswerList> {
  late Map<String, StatusAnswer> status;
  late Map<String, double> grade;
  late List<Member> members = [];
  late GroupByStatus _controller;
  StatusAnswer? selected;

  @override
  void initState() {
    super.initState();
    status = {for (final ans in widget.answers) ans.memberId: ans.status};
    grade = {for (final ans in widget.answers) ans.memberId: ans.grade};
    members.addAll(widget.members);
    _controller = GroupByStatus(members, status);
  }

  Widget get _buildStatusTotal {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        AnswerStatusChip(
          isSelected: StatusAnswer.submit == selected,
          type: StatusAnswer.submit,
          quantiy: widget.submited,
          onSorted: _onSorted,
        ),
        AnswerStatusChip(
          isSelected: StatusAnswer.lated == selected,
          type: StatusAnswer.lated,
          quantiy: widget.lated,
          onSorted: _onSorted,
        ),
        AnswerStatusChip(
          isSelected: StatusAnswer.empty == selected,
          type: StatusAnswer.empty,
          quantiy: widget.missing,
          onSorted: _onSorted,
        ),
      ],
    );
  }

  Widget get _buildSearchList {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(25.0), bottomLeft: Radius.circular(25.0)),
        boxShadow: [
          BoxShadow(
            color: isLightTheme ? kBlueColor : kPrimaryLightColor,
            offset: const Offset(4.0, 4.0),
            blurRadius: 4.0,
          )
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: KSearchText(
              hintText: 'Search with name',
              onSearch: _controller.search,
            ),
          ),
          Flexible(
            child: StreamBuilder<List<Member>>(
              initialData: members,
              stream: _controller.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListBuilder<Member>(
                    datas: snapshot.data ?? [],
                    margin: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    shirinkWrap: false,
                    itemBuilder: _itemBuilder,
                    onRefresh: () async {
                      // TODO: Refresh
                    },
                  );
                }
                return const Center(
                  child: Text('error'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildStatusTotal,
        Expanded(child: _buildSearchList),
      ],
    );
  }

  Widget _itemBuilder(Member data) {
    return TopicAnswerItem(
      member: data,
      status: status[data.uid],
      grade: grade[data.uid] ?? 0.0,
    );
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
    }
    _controller.sorted(selected);
  }
}
