import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/models/exam.model.dart';
import 'package:education_helper/roots/app_root.dart';
import 'package:education_helper/views/exam/adapter/exam.adapter.dart';
import 'package:education_helper/views/exam/bloc/exam_bloc.dart';
import 'package:education_helper/views/exam/bloc/exam_state.dart';
import 'package:education_helper/views/exam/widgets/exams_empty.dart';
import 'package:education_helper/views/home/bloc/exams/exam.bloc.dart';
import 'package:education_helper/views/widgets/button/custom_go_back.dart';
import 'package:education_helper/views/widgets/form/custom_search_field.dart';
import 'package:education_helper/views/widgets/header/appbar_bottom.dart';
import 'package:education_helper/views/widgets/list/list_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/exams_item.dart';

class Exams extends StatefulWidget {
  static final adapter =
      Root.ins.adapter.getAdapter(examAdapter).cast<ExamAdapter>();
  const Exams({Key? key}) : super(key: key);

  @override
  _ExamsState createState() => _ExamsState();
}

class _ExamsState extends State<Exams> {
  bool isNeedRefresh = false;
  List<Exam> exams = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ExamBloc>(context).getAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: KGoBack(
          preGoBack: _preGoBack,
        ),
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
            KSearchText(hintText: 'Search exam', onSearch: _search),
            SPACING.M.vertical,
            Expanded(
              child: BlocConsumer<ExamBloc, ExamState>(
                listener: (context, state) {
                  if (state is ExamCreateState ||
                      state is ExamDeleteState ||
                      state is ExamUdateState) {
                    setState(() => isNeedRefresh = true);
                  }

                  if (state is ExamLoadedState) {
                    setState(() => exams = state.exams);
                  }
                },
                builder: (context, state) {
                  if (state is ExamLoadingState) {
                    return const Center(
                      child: SizedBox(
                        height: 60.0,
                        width: 60.0,
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  return ListBuilder<Exam>(
                    datas: exams,
                    padding: const EdgeInsets.only(bottom: 30.0),
                    emptyList: const ExamsEmpty(),
                    itemBuilder: _itemBuilder,
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

  void _preGoBack() {
    if (isNeedRefresh) {
      BlocProvider.of<ExamsBloc>(context).refresh();
    }
  }

  void _search(String value) async {
    await BlocProvider.of<ExamBloc>(context).search(value);
  }

  Widget _itemBuilder(Exam data) {
    return GestureDetector(
      onTap: () => _gotoExamDetail(data.id),
      child: ExamsItem(exam: data),
    );
  }
}
