import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/state.x.dart';
import 'package:education_helper/helpers/widgets/scroller_grow_disable.dart';
import 'package:education_helper/models/topic.model.dart';
import 'package:education_helper/views/home/home.dart';
import 'package:education_helper/views/home/pages/topic_collection/widgets/topic_item.dart';
import 'package:education_helper/views/home/widgets/header_collections.dart';
import 'package:education_helper/views/widgets/button/custom_text_button.dart';
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
            child: ListBuilder<Topic>(
              datas: topics,
              shirinkWrap: true,
              emptyList: const TopicEmtpy(),
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
}

class TopicEmtpy extends StatelessWidget {
  const TopicEmtpy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(32),
          child: Text(
            "Woohoo! Don't have topics this time",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: SPACING.LG.size),
          ),
        ),
        KTextButton(
          onPressed: () => Home.adapter.goToTopics(context),
          text: 'Go to topics',
        )
      ],
    );
  }
}
