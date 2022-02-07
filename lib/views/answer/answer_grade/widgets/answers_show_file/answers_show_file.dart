import 'dart:io';

import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/modules/file_module.dart';
import 'package:education_helper/helpers/widgets/file_error_notification.dart';
import 'package:flutter/material.dart';

import 'pages/answers_content.dart';

class AnswersShowFile extends StatefulWidget {
  final String content;
  const AnswersShowFile({
    required this.content,
    Key? key,
  }) : super(key: key);

  @override
  State<AnswersShowFile> createState() => _AnswersShowFileState();
}

class _AnswersShowFileState extends State<AnswersShowFile> {
  late String content;
  @override
  void initState() {
    super.initState();
    content = widget.content;
  }

  String get exts => content.split('/').first.toLowerCase();
  bool get isImage => exts.contains('image');
  bool get isPDF => exts.contains('pdf');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<File>(
      future: FileModule(content).loadFile(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data != null) {
            return AnswerContent(file: snapshot.data!);
          } else {
            return const Center(
              child: SizedBox(
                height: 50.0,
                width: 50.0,
                child: CircularProgressIndicator(color: kPrimaryColor),
              ),
            );
          }
        }
        if (snapshot.hasError && snapshot.error != null) {
          return FileErrorNotification(
            mess: snapshot.error?.toString() ?? 'FILE NOT FOUND',
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
    );
  }
}
