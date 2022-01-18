import 'package:cached_network_image/cached_network_image.dart';
import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/state.x.dart';
import 'package:education_helper/models/exam.model.dart';
import 'package:education_helper/views/widgets/button/custom_icon_button.dart';
import 'package:education_helper/views/widgets/header/appbar_bottom.dart';
import 'package:flutter/material.dart';

import 'widgets/exam_detail_content.dart';

class ExamDetail extends StatefulWidget {
  final String id;
  const ExamDetail({
    required this.id,
    Key? key,
  }) : super(key: key);

  @override
  _ExamDetailState createState() => _ExamDetailState();
}

class _ExamDetailState extends State<ExamDetail> {
  late Exam exam;

  @override
  void initState() {
    super.initState();
    exam = Exam.faker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EXAM DETAIL'),
        bottom: const AppbarBottom(),
      ),
      body: Column(
        children: [
          Expanded(
            child: ExamDetailContent(
              content: exam.content,
            ),
          ),
          Card(
            margin: const EdgeInsets.all(20.0),
            color: kWhiteColor,
            borderOnForeground: true,
            elevation: 20.0,
            shadowColor: kPrimaryDarkColor.withOpacity(.2),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 5.0,
              ),
              child: Row(
                children: [
                  Text(
                    exam.subject,
                    style: const TextStyle(
                      color: kBlackColor,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
