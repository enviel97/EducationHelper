import 'package:education_helper/views/widgets/header/appbar_bottom.dart';
import 'package:flutter/material.dart';

class ExamForm extends StatefulWidget {
  final String title;
  const ExamForm({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  _ExamFormState createState() => _ExamFormState();
}

class _ExamFormState extends State<ExamForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        bottom: const AppbarBottom(),
      ),
    );
  }
}
