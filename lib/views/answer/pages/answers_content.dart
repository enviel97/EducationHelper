import 'package:education_helper/views/answer/widgets/amswers_show_file/answers_show_file.dart';
import 'package:flutter/material.dart';

class AnswersContent extends StatelessWidget {
  const AnswersContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(25.0)),
      ),
      child: const ClipRRect(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(25.0)),
        child: AnswersShowFile(),
      ),
    );
  }
}
