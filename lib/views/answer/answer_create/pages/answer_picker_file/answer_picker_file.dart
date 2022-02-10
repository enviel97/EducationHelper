import 'dart:io';

import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:education_helper/helpers/modules/file_module.dart';
import 'package:education_helper/helpers/widgets/file_error_notification.dart';
import 'package:education_helper/views/answer/bloc/answer_bloc.dart';
import 'package:education_helper/views/answer/bloc/answer_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'pages/answer_file_picker_content.dart';

class AnswerPickerFile extends StatelessWidget {
  final Function(File? file) onFileChange;
  final bool isGraded;

  const AnswerPickerFile({
    required this.onFileChange,
    required this.isGraded,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLightTheme = context.isLightTheme;
    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(25.0)),
        border: Border.all(
          color: isLightTheme ? kBlackColor : kWhiteColor,
          width: 4.0,
        ),
      ),
      alignment: Alignment.center,
      child: BlocBuilder<AnswerBloc, AnswerState>(
        builder: (context, state) {
          if (state is AnswerLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          String idFile = '';
          if (state is AnswerLoaded) {
            idFile = state.answer.content.name;
          }
          return FutureBuilder(
            future: FileModule(idFile).loadFile(),
            builder: (context, AsyncSnapshot<File> snapshot) {
              if (snapshot.connectionState == ConnectionState.none) {
                return const FileErrorNotification();
              }
              if (snapshot.connectionState == ConnectionState.done) {
                return AnswerFilePickerContent(
                  onFileChange: onFileChange,
                  file: snapshot.data,
                  isDisable: isGraded,
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          );
        },
      ),
    );
  }
}
