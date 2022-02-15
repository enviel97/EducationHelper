import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/views/widgets/button/download_button.dart';
import 'package:flutter/material.dart';

import '../text_grade_field.dart';

class HeaderAnswerGrade extends StatelessWidget {
  final String name, download, grade, note;
  final Function(String grade) onChangeGrade;
  final Function() onConfirm;
  const HeaderAnswerGrade({
    required this.name,
    required this.download,
    required this.onChangeGrade,
    required this.onConfirm,
    required this.grade,
    this.note = '',
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: note.isNotEmpty ? 80.0 : 32.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
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
                              child: TextGradeField(
                                onChanged: onChangeGrade,
                                grade: grade,
                              ))
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
                  ]),
            ),
            note.isNotEmpty
                ? Expanded(
                    child: GestureDetector(
                      onTap: () => _onTap(context),
                      child: Container(
                        decoration: const BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(40.0))),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 8.0),
                        margin: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Text(
                          note,
                          maxLines: 1,
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          style: const TextStyle(
                              fontSize: 18.0, color: kWhiteColor),
                        ),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ));
  }

  bool _textSize(String text, TextStyle style, {double maxWidth = 200.0}) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text, style: style),
        maxLines: 1,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: maxWidth);
    return textPainter.didExceedMaxLines;
  }

  void _onTap(BuildContext context) {
    final isOverFlow = _textSize(note, const TextStyle(fontSize: 18.0),
        maxWidth: MediaQuery.of(context).size.width * .7);
    if (!isOverFlow) return;
    final cancelButton = TextButton(
      child: const Text(
        'Ok',
        style: TextStyle(color: kPrimaryColor),
      ),
      onPressed: () {
        Navigator.maybePop(context);
      },
    );

    // set up the AlertDialog
    final alert = AlertDialog(
      title: const Text(
        'Note',
        style: TextStyle(color: kPrimaryColor),
      ),
      content: Text(
        note,
        style: const TextStyle(color: kWhiteColor),
      ),
      actions: [
        cancelButton,
      ],
    );

    showDialog(
        context: context,
        builder: (_) {
          return alert;
        });
  }
}
