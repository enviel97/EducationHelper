import 'package:education_helper/models/exam.model.dart';
import 'package:flutter/material.dart';

class ExamImage extends StatefulWidget {
  final Content content;

  const ExamImage({
    required this.content,
    Key? key,
  }) : super(key: key);

  @override
  _ExamImageState createState() => _ExamImageState();
}

class _ExamImageState extends State<ExamImage> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: InteractiveViewer(
        constrained: false,
        minScale: 1,
        child: Image.network(
          widget.content.public,
        ),
      ),
    );
  }
}
