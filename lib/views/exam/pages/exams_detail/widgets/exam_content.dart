import 'dart:io';

import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/helpers/ultils/funtions.dart';
import 'package:education_helper/views/exam/pages/exams_detail/pages/exam_image.dart';
import 'package:education_helper/views/exam/pages/exams_detail/pages/exam_pdf.dart';
import 'package:flutter/material.dart';

class ExamContent extends StatelessWidget {
  final File file;
  const ExamContent({
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
    if (isImage) {
      return ExamImage(file: file);
    }
    if (isPDF) {
      return ExamPdf(file: file);
    }
    return DecoratedBox(
      decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Theme.of(context).hintColor)),
      child: Stack(
        children: [
          Center(
            child: Image.asset(
              ImageFromLocal.asPng('rar-icon'),
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Wrap(children: [
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    color: kWhiteColor,
                    borderRadius: BorderRadius.circular(20.0)),
                child: Text(
                  '.${filePath.split('.').last}',
                  style: const TextStyle(
                    fontSize: 60.0,
                    color: kBlackColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }
}
