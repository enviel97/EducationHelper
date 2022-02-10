import 'dart:io';

import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/helpers/modules/file_module.dart';
import 'package:education_helper/helpers/widgets/file_error_notification.dart';
import 'package:flutter/material.dart';

import 'pages/answers_content.dart';

class AnswersShowFile extends StatelessWidget {
  final String content;
  const AnswersShowFile({
    required this.content,
    Key? key,
  }) : super(key: key);

  String get exts => content.split('/').first.toLowerCase();
  bool get isImage => exts.contains('image');
  bool get isPDF => exts.contains('pdf');
  Widget _buildLoading() {
    return const Center(
      child: SizedBox(
        height: 50.0,
        width: 50.0,
        child: CircularProgressIndicator(color: kPrimaryColor),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<File>(
      future: FileModule(content).loadFile(),
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data == null) {
            return _buildLoading();
          }
          return AnswerContent(file: snapshot.data!);
        }
        if (snapshot.hasError && snapshot.error != null) {
          return FileErrorNotification(
            mess: snapshot.error?.toString() ?? 'FILE NOT FOUND',
          );
        }
        return _buildLoading();
      },
    );
  }
}
