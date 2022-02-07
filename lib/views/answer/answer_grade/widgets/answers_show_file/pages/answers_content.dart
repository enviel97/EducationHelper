import 'dart:io';

import 'package:education_helper/views/answer/answer_grade/widgets/answers_show_file/widgets/answers_files.dart';
import 'package:education_helper/views/answer/answer_grade/widgets/answers_show_file/widgets/answers_image.dart';
import 'package:education_helper/views/answer/answer_grade/widgets/answers_show_file/widgets/answers_pdf.dart';
import 'package:flutter/material.dart';

class AnswerContent extends StatelessWidget {
  final File file;
  const AnswerContent({
    required this.file,
    Key? key,
  }) : super(key: key);

  String get filePath => file.path.split('/').last.toLowerCase();

  bool get isImage =>
      filePath.contains('img') ||
      filePath.contains('image') ||
      filePath.contains('jpg') ||
      filePath.contains('jpeg') ||
      filePath.contains('png');

  bool get isPDF => filePath.contains('pdf');

  @override
  Widget build(BuildContext context) {
    if (isImage) return AnswersImage(file: file);
    if (isPDF) return AnswersPDF(file: file);
    return AnswersFiles(name: filePath.split('-').first);
  }
}
