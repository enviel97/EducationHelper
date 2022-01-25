import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/state.x.dart';
import 'package:education_helper/helpers/widgets/scroller_grow_disable.dart';
import 'package:education_helper/models/topic.model.dart';
import 'package:education_helper/views/home/home.dart';
import 'package:education_helper/views/home/pages/topic_collection/widgets/topic_item.dart';
import 'package:education_helper/views/home/widgets/header_collections.dart';
import 'package:education_helper/views/widgets/list/list_builder.dart';
import 'package:flutter/material.dart';

class TopicCollection extends StatefulWidget {
  const TopicCollection({Key? key}) : super(key: key);

  @override
  _TopicCollectionState createState() => _TopicCollectionState();
}

class _TopicCollectionState extends State<TopicCollection> {
  List<Topic> topics = [];
  @override
  void initState() {
    super.initState();
    topics = List<Topic>.generate(2, (index) => Topic.faker());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(55.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          HeaderCollection(
            title: 'Topics',
            qunatity: topics.length,
            onPressMore: _morePressed,
            textColor: isLightTheme ? kPrimaryColor : kSecondaryColor,
            textMoreColor: Theme.of(context).textTheme.bodyText1!.color,
          ),
          SPACING.SM.vertical,
          Expanded(
            child: ListBuilder(
              datas: topics,
              shirinkWrap: true,
              scrollDirection: Axis.horizontal,
              scrollBehavior: NormalScollBehavior(),
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              itemBuilder: _itemTopics,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _morePressed() async {
    Home.adapter.goToTopics(context);
  }

  Widget _itemTopics(int index) {
    final topic = topics[index];
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
}
