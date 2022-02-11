import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/models/answer.model.dart';
import 'package:education_helper/models/exam.model.dart';
import 'package:education_helper/models/members.model.dart';
import 'package:education_helper/models/topic.model.dart';
import 'package:education_helper/roots/bloc/app_bloc.dart';
import 'package:education_helper/views/topic/blocs/member/topic_members_bloc.dart';
import 'package:education_helper/views/topic/blocs/member/topic_members_state.dart';
import 'package:education_helper/views/topic/blocs/topic/topic_bloc.dart';
import 'package:education_helper/views/topic/blocs/topic/topic_state.dart';
import 'package:education_helper/views/widgets/button/custom_go_back.dart';
import 'package:education_helper/views/widgets/button/share_button.dart';
import 'package:education_helper/views/widgets/header/appbar_bottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'pages/topic_answer_list/topic_answer_list.dart';
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
  Topic? topic;
  DateTime? createDate;
  DateTime? expiredDate;
  String classname = '';
  bool isNeedRefresh = false;
  String idClasroom = '';

  @override
  void initState() {
    super.initState();
    BlocProvider.of<TopicBloc>(context).getOnce(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assignment Detail'),
        bottom: const AppbarBottom(),
        leading: KGoBack(result: isNeedRefresh),
      ),
      floatingActionButton: CircleAvatar(
        backgroundColor: kSecondaryColor,
        radius: 28.0,
        child: ShareButton(
          iconColor: kPrimaryDarkColor,
          publicLink: widget.id,
          subject: 'Topic Id',
        ),
      ),
      body: Container(
        color: Theme.of(context).backgroundColor,
        child: Column(
          children: [
            TopicExamInfo(id: widget.id),
            Expanded(
                child: BlocListener<TopicMembersBloc, TopicMembersState>(
              listener: (context, state) {
                if (state is TopicMembersFailure) {
                  BlocProvider.of<AppBloc>(context)
                      .showError(context, state.error.mess);
                }
                if (state is TopicMembersChanged) {
                  setState(() => isNeedRefresh = true);
                }
              },
              child: TopicAnswerList(
                expiredDate: expiredDate,
              ),
            )),
          ],
        ),
      ),
    );
  }
}
