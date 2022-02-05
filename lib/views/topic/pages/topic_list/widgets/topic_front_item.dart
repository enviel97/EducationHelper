import 'package:education_helper/helpers/extensions/datetime_x.dart';
import 'package:education_helper/models/topic.model.dart';
import 'package:flutter/material.dart';

import 'topic_answer_item.dart';
import 'topic_info_item.dart';

class TopicFrontItem extends StatelessWidget {
  final Topic topic;
  final Function() gotoDetail;
  final BoxDecoration decoration;
  const TopicFrontItem({
    required this.topic,
    required this.gotoDetail,
    required this.decoration,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210.0,
      decoration: decoration,
      child: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: gotoDetail,
              child: TopicInfoItem(
                expiredDate: topic.expiredDate.toStringFormat(
                  format: 'dd/MM/yyyy - hh:mm',
                ),
                totalMembers: '${topic.totalMembers}',
                name: topic.name,
              ),
            ),
          ),
          Expanded(
            child: TopicAnswerItem(
              answerTotal: topic.answers.length,
              lated: topic.lated,
              missing: topic.missing,
              success: topic.success,
              type: topic.type,
            ),
          )
        ],
      ),
    );
  }
}
