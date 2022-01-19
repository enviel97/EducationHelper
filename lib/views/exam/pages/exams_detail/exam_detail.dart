import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/state.x.dart';
import 'package:education_helper/models/exam.model.dart';
import 'package:education_helper/views/exam/pages/exams_detail/widgets/exam_appbar_bottom.dart';
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
  double process = 0.0;
  late String path;

  @override
  void initState() {
    super.initState();
    exam = Exam.fromJson({
      '_id': '61e6584502a910de66af388c',
      'creatorId': '61b23ed8d9c491f7e97178bd',
      'subject': 'Biology',
      'examType': 'ESSAY',
      'content': {
        'name': 'PDF/PDF-a4a2142a-eb8a-488f-9bd0-d6807a749b7a-01-2022',
        'originName': 'QuizExam.pdf',
        'download':
            'https://storage.googleapis.com/download/storage/v1/b/educationhelper-334518.appspot.com/o/PDF%2FPDF-a4a2142a-eb8a-488f-9bd0-d6807a749b7a-01-2022?generation=1642485828644119&alt=media',
        'public':
            'https://storage.googleapis.com/educationhelper-334518.appspot.com/PDF/PDF-a4a2142a-eb8a-488f-9bd0-d6807a749b7a-01-2022',
        'offset': []
      },
    });
    // exam = Exam.fromJson({
    //   '_id': '61e6584502a910de66af388c',
    //   'creatorId': '61b23ed8d9c491f7e97178bd',
    //   'subject': 'Biology',
    //   'examType': 'ESSAY',
    //   'content': {
    //     'name': 'Image/Image-37c8690a-b0bd-456b-8884-4faa0e757785-01-2022',
    //     'originName': '271656093_2099695566864074_1280132571646855750_n.jpg',
    //     'download':
    //         'https://storage.googleapis.com/download/storage/v1/b/educationhelper-334518.appspot.com/o/Image%2FImage-37c8690a-b0bd-456b-8884-4faa0e757785-01-2022?generation=1642515300871449&alt=media',
    //     'public':
    //         'https://storage.googleapis.com/educationhelper-334518.appspot.com/Image/Image-37c8690a-b0bd-456b-8884-4faa0e757785-01-2022',
    //     'offset': []
    //   },
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EXAM DETAIL'),
        bottom: AppbarBottom(
          height: 105,
          child: ExamAppbarBottom(
            name: exam.content.originName,
            downloadLink: exam.content.download,
            publicLink: exam.content.public,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Subject:',
                maxLines: 1,
                style: TextStyle(
                  fontSize: SPACING.M.size,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                exam.subject,
                maxLines: 1,
                style: TextStyle(
                  color: isLightTheme ? kPrimaryColor : kSecondaryColor,
                  fontSize: SPACING.M.size * 1.2,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Expanded(child: ExamDetailContent(content: exam.content)),
        ],
      ),
    );
  }
}
