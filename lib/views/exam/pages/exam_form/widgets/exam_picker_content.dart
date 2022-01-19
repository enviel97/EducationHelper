import 'dart:io';

import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/helpers/extensions/state.x.dart';
import 'package:education_helper/views/exam/pages/exam_form/streams/file_picker_stream.dart';
import 'package:education_helper/views/exam/pages/exams_detail/pages/exam_image.dart';
import 'package:education_helper/views/exam/pages/exams_detail/pages/exam_pdf.dart';
import 'package:flutter/material.dart';

class ExamPickerContent extends StatefulWidget {
  final void Function(File file) onPickFile;
  const ExamPickerContent({
    required this.onPickFile,
    Key? key,
  }) : super(key: key);

  @override
  _ExamPickerContentState createState() => _ExamPickerContentState();
}

class _ExamPickerContentState extends State<ExamPickerContent> {
  final _controller = FilePickerStream();

  @override
  Widget build(BuildContext context) {
    final color = isLightTheme ? kBlackColor : kWhiteColor;
    return Container(
      height: size.height * .5,
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
        child: StreamBuilder<File>(
          stream: _controller.stream,
          builder: _streamBuilder,
        ),
      ),
    );
  }

  void _onPickFile() {
    _controller.filePicker();
  }

  Widget _streamBuilder(BuildContext context, AsyncSnapshot<File> snapshot) {
    if (snapshot.hasData && snapshot.data != null) {
      final file = snapshot.data!;
      final exts = file.path.split('/').last.split('.').last;
      if (exts.toLowerCase() == 'pdf') {
        return ExamPdf(file: file);
      }
      if (exts.toLowerCase() == 'png' || exts.toLowerCase() == 'jpg') {
        return ExamImage(file: file);
      }
      widget.onPickFile(file);
    }

    return IconButton(
      iconSize: 40.0,
      color: kWhiteColor,
      icon: const Icon(Icons.add),
      onPressed: _onPickFile,
    );
  }
}
