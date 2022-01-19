import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/models/exam.model.dart';
import 'package:education_helper/roots/app_root.dart';
import 'package:education_helper/views/exam/adapter/exam.adapter.dart';
import 'package:education_helper/views/exam/widgets/exams_empty.dart';
import 'package:education_helper/views/widgets/button/custom_go_back.dart';
import 'package:education_helper/views/widgets/form/custom_search_field.dart';
import 'package:education_helper/views/widgets/header/appbar_bottom.dart';
import 'package:education_helper/views/widgets/list/list_builder.dart';
import 'package:flutter/material.dart';

import 'widgets/exams_item.dart';

class Exams extends StatefulWidget {
  static final adapter =
      Root.ins.adapter.getAdapter(examAdapter).cast<ExamAdapter>();
  const Exams({Key? key}) : super(key: key);

  @override
  _ExamsState createState() => _ExamsState();
}

class _ExamsState extends State<Exams> {
  late List<Exam> exams;

  @override
  void initState() {
    super.initState();
    exams = List.generate(20, (index) => Exam.faker());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const KGoBack(),
        title: const Text('EXAM'),
        bottom: const AppbarBottom(),
        elevation: 0.0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addExams,
        elevation: 20.0,
        child: const Icon(Icons.add, size: 32),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            KSearchText(hintText: 'Search exam', onSearch: (value) {}),
            SPACING.M.vertical,
            Expanded(
              child: ListBuilder(
                datas: exams,
                emptyList: const ExamsEmpty(),
                itemBuilder: (int index) {
                  final exam = exams[index];
                  return GestureDetector(
                    onTap: () => _gotoExamDetail(exam.id),
                    child: ExamsItem(exam: exam),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addExams() {
    Exams.adapter.goToCreateExam(context);
  }

  void _gotoExamDetail(String id) {
    Exams.adapter.gotoDetailExam(context, idExam: id);
  }
}
