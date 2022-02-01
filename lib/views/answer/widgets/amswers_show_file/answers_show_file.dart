import 'dart:io';

import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/modules/file_module.dart';
import 'package:flutter/material.dart';

import 'pages/answers_content.dart';

class AnswersShowFile extends StatefulWidget {
  const AnswersShowFile({
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
    // content = 'Image/Image-7b999011-139d-4376-b501-4609a158fe68-01-2022';
    // content = 'PDF/PDF-4b749a9b-bccb-4ee3-980e-83b6f529f60d-01-2022';
    content = 'RAR/RAR-1e4a027d-d9bc-4633-9844-b0de3f81a3f5-01-2022';
  }

  String get exts => content.split('/').first.toLowerCase();
  bool get isImage => exts.contains('image');
  bool get isPDF => exts.contains('pdf');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<File>(
      future: FileModule(content).loadFile(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          return AnswerContent(file: snapshot.data!);
        }
        if (snapshot.hasError) {
          return Center(
            child: Text(
              '${snapshot.error}',
              style: TextStyle(
                color: kBlackColor,
                fontSize: SPACING.LG.size,
              ),
            ),
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
