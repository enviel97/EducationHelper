import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:education_helper/roots/app_root.dart';
import 'package:education_helper/roots/bloc/app_bloc.dart';
import 'package:education_helper/views/topic/adapter/topic.adapter.dart';
import 'package:education_helper/views/topic/blocs/topic/topic_bloc.dart';
import 'package:education_helper/views/topic/blocs/topic/topic_state.dart';
import 'package:education_helper/views/topic/widgets/topic_search.dart';
import 'package:education_helper/views/widgets/button/custom_go_back.dart';
import 'package:education_helper/views/widgets/header/appbar_bottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'pages/topic_list/topic_list.dart';

class Topics extends StatefulWidget {
  static final TopicAdapter adapter =
      Root.ins.adapter.getAdapter(topicAdapter).cast<TopicAdapter>();

  const Topics({Key? key}) : super(key: key);

  @override
  _TopicsState createState() => _TopicsState();
}

class _TopicsState extends State<Topics> {
  bool isNeedRefresh = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Assignment'),
        leading: KGoBack(result: isNeedRefresh),
        bottom: const AppbarBottom(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: _addTopics,
        child: const Icon(Icons.add, size: 28),
      ),
      body: GestureDetector(
        onTap: context.disableKeyBoard,
        child: BlocListener<TopicBloc, TopicState>(
          listener: (context, state) {
            if (state is TopicFailure) {
              BlocProvider.of<AppBloc>(context).showError(
                context,
                state.error.mess,
              );
            }
            if (state is TopicChanged) {
              setState(() => isNeedRefresh = true);
            }
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const TopicSearch(),
              const TopicList(),
            ],
          ),
        ),
      ),
    );
  }

  void _addTopics() {
    Topics.adapter.gotoAddForm(context);
  }
}
