import 'package:education_helper/models/topic.model.dart';
import 'package:education_helper/views/topic/blocs/topic/topic_bloc.dart';
import 'package:education_helper/views/topic/blocs/topic/topic_state.dart';
import 'package:education_helper/views/widgets/list/list_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'pages/topic_list_empty.dart';
import 'pages/topic_list_item.dart';

class TopicList extends StatefulWidget {
  const TopicList({Key? key}) : super(key: key);

  @override
  State<TopicList> createState() => _TopicListState();
}

class _TopicListState extends State<TopicList> {
  List<Topic> topics = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<TopicBloc>(context).getAll();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocConsumer<TopicBloc, TopicState>(
        listener: (context, state) {
          if (state is TopicsLoaded) {
            setState(() => topics = state.topics);
          }
        },
        builder: (context, state) {
          if (state is TopicLoading && topics.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListBuilder<Topic>(
            onRefresh: BlocProvider.of<TopicBloc>(context).refresh,
            padding: const EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 10.0,
            ),
            margin: const EdgeInsets.only(bottom: 16.0),
            datas: topics,
            shirinkWrap: true,
            emptyList: const TopicListEmpty(),
            addAutomaticKeepAlives: true,
            addRepaintBoundaries: true,
            itemBuilder: (data) => TopicListItem(topic: data),
          );
        },
      ),
    );
  }
}
