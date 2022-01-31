import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:education_helper/models/topic.model.dart';
import 'package:education_helper/views/widgets/list/list_builder.dart';
import 'package:flutter/material.dart';

import '../../topics.dart';
import 'widgets/topic_list_empty.dart';
import 'widgets/topic_list_item.dart';

class TopicList extends StatefulWidget {
  const TopicList({Key? key}) : super(key: key);

  @override
  State<TopicList> createState() => _TopicListState();
}

class _TopicListState extends State<TopicList> {
  late List<Topic> topics;

  @override
  void initState() {
    super.initState();

    topics = List.generate(10, (index) => Topic.faker());
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListBuilder<Topic>(
        padding: const EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 10.0,
        ),
        margin: const EdgeInsets.only(bottom: 16.0),
        datas: topics,
        shirinkWrap: true,
        emptyList: const TopicListEmpty(),
        itemBuilder: _itemBuilder,
      ),
    );
  }

  Widget _itemBuilder(Topic data) {
    return GestureDetector(
      onTap: () async {
        context.disableKeyBoard();
        final isNeedRefresh =
            await Topics.adapter.goToTopicDetail(context, data.id);
        if (isNeedRefresh) {
          // TODO: Bloc refersh
        }
      },
      child: TopicListItem(topic: data),
    );
  }
}
