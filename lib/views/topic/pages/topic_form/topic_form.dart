import 'package:education_helper/models/classroom.model.dart';
import 'package:education_helper/models/exam.model.dart';
import 'package:education_helper/roots/app_root.dart';
import 'package:education_helper/views/topic/adapter/topic.adapter.dart';
import 'package:education_helper/views/widgets/header/appbar_bottom.dart';
import 'package:flutter/material.dart';

import 'pages/topic_selected_exam.dart';

class TopicForm extends StatefulWidget {
  static TopicAdapter adapter =
      Root.ins.adapter.getAdapter(topicAdapter).cast<TopicAdapter>();

  final String? id;
  final Classroom? classroom;
  final Exam? exam;
  const TopicForm({Key? key, this.id, this.classroom, this.exam})
      : super(key: key);

  @override
  State<TopicForm> createState() => _TopicFormState();
}

class _TopicFormState extends State<TopicForm> {
  bool get isEdit => widget.id != null;
  late String examId;

  @override
  void initState() {
    super.initState();
    examId = widget.exam?.id ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Create topic' : 'Edit topic'),
        bottom: const AppbarBottom(),
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TopicSeclectExams(onSelectExam: _onSelectedExam),
            Container(),
          ],
        ),
      ),
    );
  }

  void _onSelectedExam(String id) {}
}
