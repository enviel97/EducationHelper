import 'package:education_helper/models/members.model.dart';
import 'package:education_helper/models/topic.model.dart';
import 'package:education_helper/views/widgets/button/custom_go_back.dart';
import 'package:education_helper/views/widgets/header/appbar_bottom.dart';
import 'package:flutter/material.dart';

import 'pages/topic_answer_list.dart';
import 'pages/topic_exam_info.dart';

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
  late Topic topic;
  @override
  void initState() {
    super.initState();
    topic = Topic.faker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Topic Detail'),
        bottom: const AppbarBottom(),
        leading: const KGoBack(),
      ),
      body: Container(
        color: Theme.of(context).backgroundColor,
        child: Column(
          children: [
            TopicExamInfo(
              createDate: topic.createDate,
              expiredDate: topic.expiredDate,
              exam: topic.exam,
            ),
            Expanded(
              child: TopicAnswerList(
                answers: topic.answers,
                // TODO: need cjange when add bloc
                members: List<Member>.from(topic.classroom.members),
                lated: topic.lated,
                missing: topic.missing,
                submited: topic.success, idClassroom: topic.classroom.id,
              ),
            )
          ],
        ),
      ),
    );
  }
}
