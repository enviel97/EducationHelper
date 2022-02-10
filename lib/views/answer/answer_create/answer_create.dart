// 61fabe9898cfd1dc881677c4

import 'dart:io';

import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/models/answer.model.dart';
import 'package:education_helper/roots/app_root.dart';
import 'package:education_helper/roots/bloc/app_bloc.dart';
import 'package:education_helper/views/answer/adapters/answers.adapter.dart';
import 'package:education_helper/views/answer/bloc/answer_bloc.dart';
import 'package:education_helper/views/answer/bloc/answer_state.dart';
import 'package:education_helper/views/widgets/button/custom_go_back.dart';
import 'package:education_helper/views/widgets/deorate/custom_confirm_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'pages/answer_header.dart';
import 'pages/answer_info/answer_info.dart';
import 'pages/answer_picker_file/answer_picker_file.dart';

class AnswerCreate extends StatefulWidget {
  static AnswerAdapter adapter =
      Root.ins.adapter.getAdapter(answerAdapter).cast<AnswerAdapter>();
  const AnswerCreate({
    Key? key,
  }) : super(key: key);

  @override
  State<AnswerCreate> createState() => _AnswerCreateState();
}

class _AnswerCreateState extends State<AnswerCreate> {
  DateTime? expiredDate;
  File? file;
  bool isEdit = false;
  String note = '';
  Answer? answer;

  late PageController _scrollController;

  @override
  void initState() {
    super.initState();
    final topicId = BlocProvider.of<AnswerBloc>(context).id;
    if (topicId.isNotEmpty) {
      BlocProvider.of<AnswerBloc>(context).getAnswer();
      isEdit = true;
    }
    _scrollController = PageController(initialPage: isEdit ? 1 : 0);
    expiredDate = BlocProvider.of<AnswerBloc>(context).expiredDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        onPressed: _onHanlderSubmit,
        mini: false,
        elevation: 10.0,
        child: const Icon(
          MaterialIcons.create_new_folder,
          color: kWhiteColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      body: SafeArea(
        child: BlocListener<AnswerBloc, AnswerState>(
          listener: (context, state) {
            if (state is AnswerFailure) {
              BlocProvider.of<AppBloc>(context).hiddenLoading(context);
              BlocProvider.of<AppBloc>(context)
                  .showError(context, state.error.mess);
            }
            if (state is AnswerLoaded) {
              setState(() => answer = state.answer);
            }
            if (state is AnswerChanged) {
              BlocProvider.of<AppBloc>(context).hiddenLoading(context);
              Navigator.maybePop(context, true);
            }
          },
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const AnswerHeader(),
                  Expanded(
                    child: PageView(
                      controller: _scrollController,
                      children: [
                        AnswerPickerFile(
                          onFileChange: _onFileChange,
                          isGraded: (answer?.grade ?? 0.0) > 0,
                        ),
                        AnswerInfo(
                          onNoteChange: (value) => note = value,
                          isEditable: isEdit,
                          review: answer?.review ?? '',
                          grade: answer?.grade ?? 00.00,
                          note: answer?.note ?? '',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: KGoBack(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  StatusAnswer get statusAnswer {
    if (expiredDate!.isAfter(DateTime.now())) {
      return StatusAnswer.submit;
    }
    return StatusAnswer.lated;
  }

  Future<void> _onHanlderSubmit() async {
    if (!isEdit && file == null) return;

    final action = isEdit ? 'Change' : 'Submit';
    final name = file?.path.split('/').last ??
        answer?.content.originName ??
        "Don't know file name";
    final status = statusAnswer.name;
    final isConfirm = await showDialog<bool>(
      context: context,
      builder: (_) => KConfirmAlert(
        onConfirm: () {
          Navigator.of(context).maybePop(true);
        },
        title: 'Answer $action',
        notice: 'Are you sure you want to $action this answer? '
            '(Your status of answer will be changed '
            'and you should screen shoot your answer)',
        content: '\n$name - $status',
      ),
    );
    if (isConfirm ?? false) {
      !isEdit
          ? BlocProvider.of<AnswerBloc>(context).create(note, file!)
          : BlocProvider.of<AnswerBloc>(context).edit(note: note, file: file);
      BlocProvider.of<AppBloc>(context).showLoading(context, action);
    }
  }

  void _onFileChange(File? file) {
    this.file = file;
  }
}
