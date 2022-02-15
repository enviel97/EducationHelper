import 'dart:io';

import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:education_helper/helpers/modules/file_module.dart';
import 'package:education_helper/helpers/widgets/file_error_notification.dart';
import 'package:education_helper/models/exam.model.dart';
import 'package:education_helper/views/exam/pages/exams_detail/widgets/exam_content.dart';
import 'package:flutter/material.dart';

class ExamDetailContent extends StatelessWidget {
  final Content content;
  const ExamDetailContent({required this.content, Key? key}) : super(key: key);
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
            if (snapshot.connectionState == ConnectionState.done) {
              return ExamContent(file: snapshot.data!);
            }

            if (snapshot.hasError) {
              return FileErrorNotification(
                mess: '${snapshot.error ?? 'FILE NOT FOUND'}',
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
