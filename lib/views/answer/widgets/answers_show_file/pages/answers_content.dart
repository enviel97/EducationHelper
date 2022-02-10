import 'dart:io';

import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:education_helper/views/answer/widgets/answers_show_file/widgets/answers_files.dart';
import 'package:education_helper/views/answer/widgets/answers_show_file/widgets/answers_image.dart';
import 'package:education_helper/views/answer/widgets/answers_show_file/widgets/answers_pdf.dart';
import 'package:flutter/material.dart';

class AnswerContent extends StatelessWidget {
  final File file;
  final EdgeInsets pdfPadding;
  final double? imageHeight;
  const AnswerContent({
    required this.file,
    Key? key,
    this.pdfPadding = const EdgeInsets.only(top: 60.0),
    this.imageHeight,
  }) : super(key: key);

  String get filePath => file.path.split('/').last.toLowerCase();

  bool get isImage =>
      filePath.contains('jpg') ||
      filePath.contains('jpeg') ||
      filePath.contains('png');

  bool get isPDF => filePath.contains('pdf');

  @override
  Widget build(BuildContext context) {
    if (isImage) {
      return AnswersImage(
        file: file,
        height: imageHeight ?? context.mediaSize.height,
      );
    }
    if (isPDF) {
      return AnswersPDF(
        file: file,
        padding: pdfPadding,
      );
    }
    return AnswersFiles(name: filePath.split('.').last.split('-').first);
  }
}
