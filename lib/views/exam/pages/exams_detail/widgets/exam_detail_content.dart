import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/models/exam.model.dart';
import 'package:education_helper/views/exam/pages/exams_detail/pages/exam_pdf_essay.dart';
import 'package:flutter/material.dart';

class ExamDetailContent extends StatelessWidget {
  final Content content;
  const ExamDetailContent({required this.content, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        border: Border.all(
          color: kPlacehoderSuperDarkColor,
          width: 5.0,
        ),
      ),
      child: Builder(
        builder: (context) {
          // if (content.isImage) {
          //   return ExamImage(public: content.public, name: content.originName);
          // }
          return ExamPdfEssay(
            public: content.public,
            name: content.originName,
          );
        },
      ),
    );
  }
}
