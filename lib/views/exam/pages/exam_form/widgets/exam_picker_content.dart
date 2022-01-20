import 'dart:io';

import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:education_helper/views/exam/pages/exam_form/streams/file_picker_stream.dart';
import 'package:education_helper/views/exam/pages/exams_detail/pages/exam_image.dart';
import 'package:education_helper/views/exam/pages/exams_detail/pages/exam_pdf.dart';
import 'package:flutter/material.dart';

class ExamPickerContent extends StatelessWidget {
  final FilePickerStream controller;
  const ExamPickerContent({
    required this.controller,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = context.isLightTheme ? kBlackColor : kWhiteColor;
    return Container(
      height: context.mediaSize.height * .5,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: color),
        borderRadius: const BorderRadius.all(Radius.circular(25.0)),
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: kWhiteColor),
          color: kPlaceholderDarkColor,
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: StreamBuilder<File?>(
          stream: controller.stream,
          builder: _streamBuilder,
        ),
      ),
    );
  }

  Widget _streamBuilder(BuildContext context, AsyncSnapshot<File?> snapshot) {
    if (snapshot.hasData && snapshot.data != null) {
      final file = snapshot.data!;
      final exts = file.path.split('/').last.split('.').last;
      if (exts.toLowerCase() == 'pdf') {
        return ExamPdf(file: file);
      }
      if (exts.toLowerCase() == 'png' || exts.toLowerCase() == 'jpg') {
        return ExamImage(file: file);
      }
    }

    return IconButton(
      iconSize: 40.0,
      color: kWhiteColor,
      icon: const Icon(Icons.add),
      onPressed: controller.filePicker,
    );
  }
}
