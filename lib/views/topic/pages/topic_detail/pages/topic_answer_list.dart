import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/helpers/extensions/state.x.dart';
import 'package:education_helper/helpers/ultils/funtions.dart';
import 'package:education_helper/models/members.model.dart';
import 'package:education_helper/models/topic.model.dart';
import 'package:education_helper/views/topic/pages/topic_detail/widgets/answer_list_empty.dart';
import 'package:education_helper/views/topic/pages/topic_detail/widgets/answer_list_error.dart';
import 'package:education_helper/views/topic/pages/topic_detail/widgets/topic_answer_item.dart';
import 'package:education_helper/views/topic/streams/group_by_status.dart';
import 'package:education_helper/views/widgets/form/custom_search_field.dart';
import 'package:education_helper/views/widgets/list/list_builder.dart';
import 'package:flutter/material.dart';
import '../widgets/answers_status_chip.dart';

class TopicAnswerList extends StatefulWidget {
  final String idClassroom;
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
    required this.idClassroom,
    Key? key,
  }) : super(key: key);

  @override
  State<TopicAnswerList> createState() => _TopicAnswerListState();
}

class _TopicAnswerListState extends State<TopicAnswerList> {
  late List<Member> members = [];
  late GroupByStatus _controller;
  bool isGrade = false;
  StatusAnswer? selected;

  late Map<String, dynamic> answerGroup;
  @override
  void initState() {
    super.initState();
    answerGroup = {
      for (final ans in widget.answers)
        ans.memberId: {
          'id': ans.id,
          'status': ans.status,
          'grade': ans.grade,
        }
    };
    members.addAll(widget.members);
    _controller = GroupByStatus(members, answerGroup);
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
            color: isLightTheme ? kPrimaryDarkColor : kPrimaryLightColor,
            offset: const Offset(4.0, 4.0),
            blurRadius: 10.0,
          )
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Flexible(
                  child: KSearchText(
                    hintText: 'Search with name',
                    onSearch: _controller.search,
                  ),
                ),
                Switch(
                  value: isGrade,
                  onChanged: (_) {
                    setState(() {
                      isGrade = !isGrade;
                      _controller.grade(isGrade);
                    });
                  },
                  activeColor: kPrimaryColor,
                  activeThumbImage: AssetImage(
                    ImageFromLocal.asPng('grade'),
                  ),
                ),
              ],
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
                    emptyList: AnswerListEmpty(id: widget.idClassroom),
                    shirinkWrap: false,
                    itemBuilder: _itemBuilder,
                    onRefresh: () async {
                      // TODO: refresh bloc
                    },
                  );
                }
                return const AnswerListError();
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
      status: answerGroup[data.uid]['status'],
      grade: answerGroup[data.uid]['grade'],
      idAnswer: answerGroup[data.uid]['id'],
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
