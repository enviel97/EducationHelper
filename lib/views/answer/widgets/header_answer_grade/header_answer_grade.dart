import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/views/widgets/button/download_button.dart';
import 'package:flutter/material.dart';

import '../text_grade_field.dart';

class HeaderAnswerGrade extends StatelessWidget {
  final String name;
  final String download;
  final Function(String grade) onChangeGrade;
  final Function() onConfirm;
  const HeaderAnswerGrade({
    required this.name,
    required this.download,
    required this.onChangeGrade,
    required this.onConfirm,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 32.0,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                    const Text('Grade',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: kBlackColor,
                            fontSize: 18.0)),
                    SPACING.S.horizontal,
                    SizedBox(
                        width: 100.0,
                        child: TextGradeField(onChanged: onChangeGrade))
                  ])),
              DownloadButton(
                  iconSize: 24.0,
                  iconColor: kPrimaryColor,
                  download: download,
                  name: name),
              IconButton(
                  iconSize: 24.0,
                  color: kBlackColor,
                  icon: const Icon(Icons.check),
                  onPressed: onConfirm)
            ]));
  }
}
