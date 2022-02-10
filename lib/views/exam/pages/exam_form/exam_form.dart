import 'dart:io';

import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:education_helper/helpers/extensions/state.x.dart';
import 'package:education_helper/roots/bloc/app_bloc.dart';
import 'package:education_helper/views/exam/bloc/exam_bloc.dart';
import 'package:education_helper/views/exam/bloc/exam_state.dart';
import 'package:education_helper/helpers/streams/file_picker_stream.dart';
import 'package:education_helper/views/exam/pages/exam_form/widgets/exam_content.dart';
import 'package:education_helper/views/widgets/button/custom_go_back.dart';
import 'package:education_helper/views/widgets/button/custom_text_button.dart';
import 'package:education_helper/views/widgets/header/appbar_bottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/exam_text_form.dart';

class ExamForm extends StatefulWidget {
  final File? file;
  final String? subject;
  final String? id;
  const ExamForm({
    this.file,
    this.subject,
    this.id,
    Key? key,
  }) : super(key: key);

  @override
  _ExamFormState createState() => _ExamFormState();
}

class _ExamFormState extends State<ExamForm> {
  late FilePickerStream _pickerFile;

  String subject = '';
  String filename = 'Name of file';
  File? file;

  @override
  void initState() {
    super.initState();
    file = widget.file;
    subject = widget.subject ?? '';
    _pickerFile = FilePickerStream(file);
    _pickerFile.stream.listen(hookData);
  }

  @override
  void dispose() {
    _pickerFile.dispose();
    super.dispose();
  }

  bool get isCreate => widget.id?.isEmpty ?? true;

  @override
  Widget build(BuildContext context) {
    final color = isLightTheme ? kBlackColor : kWhiteColor;
    return GestureDetector(
      onTap: context.disableKeyBoard,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(widget.id == null ? 'Create topic' : 'Edit topic'),
          bottom: const AppbarBottom(),
          leading: const KGoBack(),
        ),
        body: BlocListener<ExamBloc, ExamState>(
          listener: (context, state) async {
            if (state is ExamLoadingState) {
              BlocProvider.of<AppBloc>(context).showLoading(context, 'Loading');
            }
            if (state is ExamFailureState) {
              BlocProvider.of<AppBloc>(context).hiddenLoading(context);
              BlocProvider.of<AppBloc>(context)
                  .showError(context, state.error.mess);
            }
            if (state is ExamCreateState || state is ExamUdateState) {
              BlocProvider.of<AppBloc>(context).hiddenLoading(context);
              await Future.delayed(
                  const Duration(milliseconds: 500), context.goBack);
            }
          },
          child: Padding(
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
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      KTextButton(
                        width: 150.0,
                        color: kPrimaryDarkColor,
                        isDisable:
                            (subject.isEmpty || file == null) && isCreate,
                        onPressed: _onHandleForm,
                        text: isCreate ? 'Add Exam' : 'Update Exam',
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
        ),
      ),
    );
  }

  void _onHandleForm() {
    if (isCreate) {
      return _onCreateForm();
    }
    return _onUpdateForm();
  }

  void _onCreateForm() {
    BlocProvider.of<ExamBloc>(context).create(subject, file!);
  }

  void _onUpdateForm() {
    BlocProvider.of<ExamBloc>(context).edit(widget.id!, subject, file);
  }

  void hookData(File? file) {
    this.file = file;
    setState(
      () => filename =
          file?.path.split('/').last.split('.').first ?? 'Name of file',
    );
  }
}
