import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:education_helper/models/topic.model.dart';
import 'package:education_helper/views/topic/blocs/topic/topic_bloc.dart';
import 'package:education_helper/views/topic/pages/topic_list/widgets/topic_back_item.dart';
import 'package:education_helper/views/topic/pages/topic_list/widgets/topic_front_item.dart';
import 'package:education_helper/views/topic/typings/color_schema.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../topics.dart';

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
  bool flipping = false;

  @override
  void initState() {
    _controller = FlipCardController();
    super.initState();
    topic = widget.topic;
  }

  @override
  void didUpdateWidget(TopicListItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.topic != widget.topic) {
      topic = widget.topic;
    }
  }

  ColorSchema get colorSchema => ColorSchema.industry(topic.type);

  BoxDecoration get decoration {
    return BoxDecoration(
      color: kWhiteColor,
      gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: colorSchema.gradient,
      ),
      borderRadius: const BorderRadius.all(Radius.circular(25.0)),
      boxShadow: [
        BoxShadow(
          color: kBlackColor.withOpacity(.5),
          offset: const Offset(4.0, 4.0),
          blurRadius: 4.0,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FlipCard(
      flipOnTouch: true,
      speed: 200,
      onFlipDone: _onFlipDone,
      direction: FlipDirection.HORIZONTAL,
      controller: _controller,
      back: TopicBackItem(
        gotoDetail: _goToDetail,
        decoration: decoration,
        topic: topic,
      ),
      front: TopicFrontItem(
        topic: topic,
        gotoDetail: _goToDetail,
        decoration: decoration,
      ),
    );
  }

  Future<void> _goToDetail() async {
    context.disableKeyBoard();
    final isNeedRefresh =
        await Topics.adapter.goToTopicDetail(context, topic.id);
    if (isNeedRefresh) {
      BlocProvider.of<TopicBloc>(context).refresh();
    }
  }

  void _onFlipDone(bool isFront) {
    if (mounted) {
      setState(() => flipping = isFront);
    }
  }
}
