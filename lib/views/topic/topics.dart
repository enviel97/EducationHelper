import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:education_helper/roots/app_root.dart';
import 'package:education_helper/views/topic/adapter/topic.adapter.dart';
import 'package:education_helper/views/topic/widgets/topic_search.dart';
import 'package:education_helper/views/widgets/button/custom_go_back.dart';
import 'package:education_helper/views/widgets/header/appbar_bottom.dart';
import 'package:flutter/material.dart';

import 'pages/topic_list/topic_list.dart';

class Topics extends StatefulWidget {
  static final TopicAdapter adapter =
      Root.ins.adapter.getAdapter(topicAdapter).cast<TopicAdapter>();

  const Topics({Key? key}) : super(key: key);

  @override
  _TopicsState createState() => _TopicsState();
}

class _TopicsState extends State<Topics> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('TOPIC'),
        leading: const KGoBack(),
        bottom: const AppbarBottom(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTopics,
        child: const Icon(Icons.add, size: 28),
      ),
      body: GestureDetector(
        onTap: () => context.disableKeyBoard(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const TopicSearch(),
            const TopicList(),
          ],
        ),
      ),
    );
  }

  void _addTopics() {
    Topics.adapter.gotoAddForm(context);
  }
}
