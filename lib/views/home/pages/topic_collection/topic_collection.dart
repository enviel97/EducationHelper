import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/state.x.dart';
import 'package:education_helper/helpers/widgets/scroller_grow_disable.dart';
import 'package:education_helper/models/topic.model.dart';
import 'package:education_helper/roots/bloc/app_bloc.dart';
import 'package:education_helper/views/home/bloc/classrooms/classroom.bloc.dart';
import 'package:education_helper/views/home/bloc/exams/exam.bloc.dart';
import 'package:education_helper/views/home/bloc/topics/topic.bloc.dart';
import 'package:education_helper/views/home/bloc/topics/topic.state.dart';
import 'package:education_helper/views/home/home.dart';
import 'package:education_helper/views/home/widgets/header_collections.dart';
import 'package:education_helper/views/widgets/list/list_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/topic_item.dart';
import 'widgets/topic_empty.dart';

class TopicCollection extends StatefulWidget {
  const TopicCollection({Key? key}) : super(key: key);

  @override
  _TopicCollectionState createState() => _TopicCollectionState();
}

class _TopicCollectionState extends State<TopicCollection> {
  late List<Topic> topics;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<TopicBloc>(context).getTopicCollection();
    topics = [];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 320.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(55.0),
        ),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          HeaderCollection(
            title: 'Assignment',
            qunatity: topics.length,
            onPressMore: _morePressed,
            textColor: isLightTheme ? kPrimaryColor : kSecondaryColor,
            textMoreColor: Theme.of(context).textTheme.bodyText1!.color,
          ),
          SPACING.SM.vertical,
          Expanded(
              child: BlocConsumer<TopicBloc, TopicState>(
                  listener: (context, state) {
            if (state is TopicFailState) {
              BlocProvider.of<AppBloc>(context)
                  .showError(context, state.messenger.mess);
              setState(() => topics = []);
            }
            if (state is TopicLoadedState) {
              setState(() => topics = state.topics);
            }
          }, builder: (context, state) {
            if (state is TopicLoadingState && topics.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is TopicFailState) {
              return TopicEmpty(
                onPressed: _refresh,
                messenger: 'Has occus when loading topic',
                buttonText: 'Refresh',
              );
            }

            return ListBuilder<Topic>(
              datas: topics,
              shirinkWrap: true,
              emptyList: TopicEmpty(onPressed: _morePressed),
              scrollDirection: Axis.horizontal,
              scrollBehavior: NormalScollBehavior(),
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              itemBuilder: _itemTopics,
              onRefresh: _refresh,
            );
          }))
        ]));
  }

  Future<void> _morePressed() async {
    final isNeedRefresh = await Home.adapter.goToTopics(context);
    if (isNeedRefresh) _refresh();
  }

  Widget _itemTopics(Topic topic) {
    final ansSuccess = topic.success;
    final ansLate = topic.lated;
    final ansMiss = topic.missing;
    return TopicItem(
        type: topic.type,
        examsName: topic.name,
        members: topic.totalMembers,
        expiredDate: topic.expiredDate,
        ansSuccess: ansSuccess,
        ansMiss: ansMiss,
        ansLate: ansLate,
        id: topic.id,
        refresh: _refresh);
  }

  Future<void> _refresh() async {
    Future.wait([
      BlocProvider.of<TopicBloc>(context).refresh(),
      BlocProvider.of<AppBloc>(context).refreshUser(),
      BlocProvider.of<ClassroomsBloc>(context).refresh(),
      BlocProvider.of<ExamsBloc>(context).refresh(),
    ]);
  }
}
