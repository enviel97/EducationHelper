import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/datetime_x.dart';
import 'package:education_helper/models/topic.model.dart';
import 'package:education_helper/views/topic/pages/topic_list/widgets/topic_answer_item.dart';
import 'package:education_helper/views/topic/pages/topic_list/widgets/topic_info_item.dart';
import 'package:education_helper/views/topic/typings/color_schema.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';

class TopicListItem extends StatefulWidget {
  final Topic topic;
  const TopicListItem({
    required this.topic,
    Key? key,
  }) : super(key: key);

  @override
  State<TopicListItem> createState() => _TopicListItemState();
}

class _TopicListItemState extends State<TopicListItem> {
  late Topic topic;
  late FlipCardController _controller;
  @override
  void initState() {
    super.initState();
    if (mounted) {
      topic = topic;
      _controller = FlipCardController();
    }
  }

  ColorSchema get colorSchema => ColorSchema.industry(widget.topic.type);

  @override
  Widget build(BuildContext context) {
    const radius = 25.0;
    const height = 210.0;
    return Container(
      height: height,
      decoration: BoxDecoration(
          color: kWhiteColor,
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: colorSchema.gradient,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(radius)),
          boxShadow: [
            BoxShadow(
              color: kBlackColor.withOpacity(.5),
              offset: const Offset(4.0, 4.0),
              blurRadius: 4.0,
            )
          ]),
      child: Column(
        children: [
          Expanded(
            child: TopicInfoItem(
              expiredDate: topic.expiredDate.toStringFormat(
                format: 'dd/MM/yyyy',
              ),
              totalMembers: '${widget.topic.totalMembers}',
              name: topic.name,
            ),
          ),
          Expanded(
            child: TopicAnswerItem(
              answerTotal: topic.totalMembers,
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
