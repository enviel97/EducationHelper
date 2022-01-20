import 'dart:io';

import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:education_helper/helpers/extensions/state.x.dart';
import 'package:education_helper/views/exam/pages/exam_form/streams/file_picker_stream.dart';
import 'package:education_helper/views/exam/pages/exam_form/widgets/exam_content.dart';
import 'package:education_helper/views/widgets/button/custom_go_back.dart';
import 'package:education_helper/views/widgets/button/custom_text_button.dart';
import 'package:education_helper/views/widgets/header/appbar_bottom.dart';
import 'package:flutter/material.dart';

import 'widgets/exam_text_form.dart';

class ExamForm extends StatefulWidget {
  final String title;
  final File? file;
  final String? subject;
  const ExamForm({
    required this.title,
    this.file,
    this.subject,
    Key? key,
  }) : super(key: key);

  @override
  _ExamFormState createState() => _ExamFormState();
}

class _ExamFormState extends State<ExamForm> {
  final _pickerFile = FilePickerStream();

  bool isNeedRefresh = false;
  String subject = '';
  String filename = 'Name of file';
  File? file;

  @override
  void initState() {
    super.initState();
    file = widget.file;
    _pickerFile.stream.listen(hookData);
  }

  @override
  Widget build(BuildContext context) {
    final color = isLightTheme ? kBlackColor : kWhiteColor;
    return GestureDetector(
      onTap: context.disableKeyBoard,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(widget.title),
          bottom: const AppbarBottom(),
          leading: const KGoBack(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ExamTextForm(
                initial: widget.subject ?? '',
                filename: filename,
                onChanged: (value) => subject = value,
              ),
              ExamContents(
                controller: _pickerFile,
                file: file,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    KTextButton(
                        width: 150.0,
                        onPressed: _onCreateForm,
                        text: 'Add Exam'),
                    KTextButton(
                      width: 150.0,
                      isOutline: true,
                      onPressed: context.goBack,
                      color: color,
                      text: 'Cancel',
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onCreateForm() {
    if (subject.isEmpty || file == null) return;
    context.goBack();
  }

  void hookData(File? file) {
    this.file = file;
    setState(
      () => filename =
          file?.path.split('/').last.split('.').first ?? 'Name of file',
    );
  }
}
