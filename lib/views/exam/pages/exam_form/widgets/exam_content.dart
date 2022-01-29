import 'dart:io';

import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/views/exam/pages/exam_form/streams/file_picker_stream.dart';
import 'package:education_helper/views/exam/pages/exam_form/widgets/exam_picker_content.dart';
import 'package:flutter/material.dart';

class ExamContents extends StatelessWidget {
  final File? file;
  final FilePickerStream controller;

  const ExamContents({
    required this.controller,
    Key? key,
    this.file,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget tools = const SizedBox.shrink();
    if (file != null) {
      tools = Align(
        alignment: Alignment.topLeft,
        child: Row(
          children: [
            IconButton(
              onPressed: controller.filePicker,
              icon: const Icon(Icons.edit),
              color: Theme.of(context).hintColor,
            ),
            IconButton(
              onPressed: controller.remove,
              icon: const Icon(Icons.delete),
              color: kErrorColor,
            )
          ],
        ),
      );
    }

    return Stack(children: [
      ExamPickerContent(controller: controller),
      tools,
    ]);
  }
}
