import 'dart:io';

import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:education_helper/helpers/extensions/state.x.dart';
import 'package:education_helper/views/exam/pages/exam_form/widgets/exam_picker_content.dart';
import 'package:education_helper/views/widgets/button/custom_go_back.dart';
import 'package:education_helper/views/widgets/button/custom_text_button.dart';
import 'package:education_helper/views/widgets/form/custom_text_field.dart';
import 'package:education_helper/views/widgets/header/appbar_bottom.dart';
import 'package:flutter/material.dart';

class ExamForm extends StatefulWidget {
  final String title;
  const ExamForm({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  _ExamFormState createState() => _ExamFormState();
}

class _ExamFormState extends State<ExamForm> {
  bool isNeedRefresh = false;
  String subject = '';
  String filename = 'Name of file';
  File? file;

  @override
  Widget build(BuildContext context) {
    final color = isLightTheme ? kBlackColor : kWhiteColor;
    return Scaffold(
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
            _buildForm(),
            ExamPickerContent(onPickFile: _pickerFile),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 5.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  KTextButton(
                    width: 150.0,
                    onPressed: _onCreateForm,
                    text: 'Add Exam',
                  ),
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
    );
  }

  void _onCreateForm() {
    if (subject.isEmpty || file == null) return;
    print(subject);
    print(file!.readAsBytesSync());
    context.goBack();
  }

  void _pickerFile(File? file) {
    if (file != null) {
      this.file = file;
      setState(() => filename = file.path.split('/').last);
    }
  }

  Widget _buildForm() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 10.0,
      ),
      decoration: BoxDecoration(
        color: kWhiteColor,
        border: Border.all(color: kBlackColor.withOpacity(.2), width: 0.2),
        borderRadius: BorderRadius.circular(40.0),
        boxShadow: [
          BoxShadow(
            color: kBlackColor.withOpacity(.7),
            offset: const Offset(4, 4),
            blurRadius: 4.0,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Exam: ',
                style: TextStyle(
                  color: kBlackColor,
                  fontSize: SPACING.M.size,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    filename,
                    style: TextStyle(
                      color: isLightTheme
                          ? kSecondaryDarkColor
                          : kPrimaryDarkColor,
                      fontSize: SPACING.M.size * 1.2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
          KTextField(
            iconData: Icons.subject_rounded,
            hintText: 'Subject',
            onChange: (value) => subject = value,
          ),
        ],
      ),
    );
  }
}
