import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/state.x.dart';
import 'package:education_helper/helpers/widgets/scroller_grow_disable.dart';
import 'package:education_helper/models/topic.model.dart';
import 'package:education_helper/roots/bloc/app_bloc.dart';
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
            title: 'Topics',
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
            }
            if (state is TopicLoadedState) {
              setState(() => topics = state.topics);
            }
          }, builder: (context, state) {
            if (state is TopicLoadingState) {
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
                endOfList: GestureDetector(
                    onTap: _morePressed,
                    child: Container(
                        height: 300,
                        color: kPlacehoderSuperDarkColor.withOpacity(.6),
                        padding: const EdgeInsets.symmetric(horizontal: 55.5),
                        child: const CircleAvatar(
                            radius: 32.0,
                            backgroundColor: kPrimaryColor,
                            child: Icon(Icons.more_horiz_rounded)))));
          }))
        ]));
  }

  Future<void> _morePressed() async {
    final isNeedRefresh = await Home.adapter.goToTopics(context);
    if (isNeedRefresh) _refresh();
  }

  Widget _itemTopics(Topic topic) {
    final ansSuccess =
        topic.answers.where((ans) => ans.status == StatusAnswer.submit).length;
    final ansMiss =
        topic.answers.where((ans) => ans.status == StatusAnswer.lated).length;
    final ansLate = topic.answers.length - ansSuccess - ansMiss;
    final type = topic.exam.content.name.split('/').first;
    return TopicItem(
      type: type.split('-').first,
      examsName: topic.exam.content.originName,
      members: topic.classroom.members.length,
      expiredDate: topic.expiredDate,
      ansSuccess: ansSuccess,
      ansMiss: ansMiss,
      ansLate: ansLate,
    );
  }

  Future<void> _refresh() async {
    BlocProvider.of<TopicBloc>(context).refresh();
  }
}
