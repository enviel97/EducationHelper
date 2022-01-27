import 'package:education_helper/models/classroom.model.dart';
import 'package:education_helper/models/exam.model.dart';
import 'package:education_helper/views/widgets/header/appbar_bottom.dart';
import 'package:flutter/material.dart';

class TopicForm extends StatefulWidget {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Create topic' : 'Edit topic'),
        bottom: const AppbarBottom(),
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(),
      ),
    );
  }
}
