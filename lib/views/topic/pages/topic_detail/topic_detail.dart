import 'package:education_helper/models/exam.model.dart';
import 'package:education_helper/models/topic.model.dart';
import 'package:education_helper/roots/bloc/app_bloc.dart';
import 'package:education_helper/views/topic/blocs/member/topic_members_bloc.dart';
import 'package:education_helper/views/topic/blocs/member/topic_members_state.dart';
import 'package:education_helper/views/topic/blocs/topic/topic_bloc.dart';
import 'package:education_helper/views/topic/blocs/topic/topic_state.dart';
import 'package:education_helper/views/widgets/button/custom_go_back.dart';
import 'package:education_helper/views/widgets/header/appbar_bottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'pages/topic_answer_list/topic_answer_list.dart';
import 'pages/topic_exam_info.dart';
import 'placeholders/placeholder_list_members_answers.dart';

class TopicDetail extends StatefulWidget {
  final String id;
  const TopicDetail({
    required this.id,
    Key? key,
  }) : super(key: key);

  @override
  State<TopicDetail> createState() => _TopicDetailState();
}

class _TopicDetailState extends State<TopicDetail> {
  Topic? topic;
  Exam? exam;
  DateTime? createDate;
  DateTime? expiredDate;
  String classname = '';
  bool isNeedRefresh = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<TopicBloc>(context).getOnce(widget.id);
    BlocProvider.of<TopicMembersBloc>(context).getMembers(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Topic Detail'),
        bottom: const AppbarBottom(),
        leading: KGoBack(result: isNeedRefresh),
      ),
      body: Container(
        color: Theme.of(context).backgroundColor,
        child: Column(
          children: [
            BlocListener<TopicBloc, TopicState>(
              listener: (context, state) {
                if (state is TopicLoaded) {
                  if (exam == null ||
                      expiredDate == null ||
                      createDate == null) {
                    setState(() {
                      classname = state.topic.classroom.name;
                      exam = state.topic.exam;
                      expiredDate = state.topic.expiredDate;
                      createDate = state.topic.createDate;
                    });
                  }
                  setState(() => topic = state.topic);
                }
              },
              child: TopicExamInfo(
                exam: exam,
                createAt: createDate,
                expiredAt: expiredDate,
                classname: classname,
              ),
            ),
            Expanded(
                child: BlocConsumer<TopicMembersBloc, TopicMembersState>(
              listener: (context, state) {
                if (state is TopicMembersFailure) {
                  BlocProvider.of<AppBloc>(context)
                      .showError(context, state.error.mess);
                }
                if (state is TopicMembersChanged) {
                  setState(() => isNeedRefresh = true);
                }
              },
              builder: (context, state) {
                if (state is TopicMembersLoaded) {
                  return TopicAnswerList(
                    answers: state.answers,
                    classroom: state.classroom,
                    expiredDate: expiredDate,
                  );
                }
                return const PListMembersAnswers();
              },
            )),
          ],
        ),
      ),
    );
  }
}
