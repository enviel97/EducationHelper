import 'dart:io';

import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:education_helper/helpers/modules/file_module.dart';
import 'package:education_helper/models/exam.model.dart';
import 'package:education_helper/views/exam/pages/exams_detail/pages/exam_image.dart';
import 'package:education_helper/views/exam/pages/exams_detail/pages/exam_pdf.dart';
import 'package:flutter/material.dart';

class ExamDetailContent extends StatelessWidget {
  final Content content;
  const ExamDetailContent({required this.content, Key? key}) : super(key: key);
// 'Image/Image-37c8690a-b0bd-456b-8884-4faa0e757785-01-2022'
  @override
  Widget build(BuildContext context) {
    final color = context.isLightTheme ? kBlackColor : kWhiteColor;
    return Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          border: Border.all(
            color: color.withOpacity(0.8),
            width: 2.0,
          ),
        ),
        child: FutureBuilder<File>(
          future: FileModule(content.name).loadFile(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (content.isImage) {
                return ExamImage(file: snapshot.data!);
              }
              return ExamPdf(file: snapshot.data!);
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  '${snapshot.error}',
                  style: TextStyle(
                    color: color,
                    fontSize: SPACING.LG.size,
                  ),
                ),
              );
            }
            return const Center(
              child: SizedBox(
                height: 50.0,
                width: 50.0,
                child: CircularProgressIndicator(color: kPrimaryColor),
              ),
            );
          },
        ));
  }
}
