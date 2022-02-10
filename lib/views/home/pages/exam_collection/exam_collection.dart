import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/state.x.dart';
import 'package:education_helper/helpers/widgets/scroller_grow_disable.dart';
import 'package:education_helper/models/exam.model.dart';
import 'package:education_helper/roots/bloc/app_bloc.dart';
import 'package:education_helper/views/home/bloc/classrooms/classroom.bloc.dart';
import 'package:education_helper/views/home/bloc/exams/exam.bloc.dart';
import 'package:education_helper/views/home/bloc/exams/exam.state.dart';
import 'package:education_helper/views/home/bloc/topics/topic.bloc.dart';
import 'package:education_helper/views/home/home.dart';
import 'package:education_helper/views/home/widgets/header_collections.dart';
import 'package:education_helper/views/widgets/list/list_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/exam_collection_empty.dart';
import 'widgets/exam_collection_item.dart';

class ExamCollection extends StatefulWidget {
  const ExamCollection({
    Key? key,
  }) : super(key: key);

  @override
  _ExamCollectionState createState() => _ExamCollectionState();
}

class _ExamCollectionState extends State<ExamCollection> {
  List<Exam> exams = [];

  @override
  void initState() {
    super.initState();
    // BlocProvider.of<ExamsBloc>(context).getExamCollection();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.0,
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(55.0),
        color: isLightTheme ? kBlackColor : kWhiteColor,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SPACING.M.vertical,
          HeaderCollection(
            title: 'Topics',
            qunatity: exams.length,
            onPressMore: gotoExams,
          ),
          SPACING.M.vertical,
          // Build List scrole
          Expanded(
            child: BlocConsumer<ExamsBloc, ExamState>(
              listener: (context, state) {
                if (state is ExamFailState) {
                  BlocProvider.of<AppBloc>(context)
                      .showError(context, '${state.messenger}');
                  setState(() => exams = []);
                }
                if (state is ExamLoadedState) {
                  setState(() => exams = state.exams);
                }
              },
              builder: (context, state) {
                if (state is ExamLoadingState && exams.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is ExamFailState) {
                  return ExamCollectionEmpty(
                    messneger: 'An error occurred loading data.'
                        'please wait a few minutes and click refresh',
                    title: 'Refresh',
                    onStateHandle: BlocProvider.of<ExamsBloc>(context).refresh,
                  );
                }

                return ListBuilder<Exam>(
                  scrollDirection: Axis.horizontal,
                  emptyList: ExamCollectionEmpty(
                    onStateHandle: gotoExams,
                  ),
                  shirinkWrap: true,
                  scrollBehavior: NormalScollBehavior(),
                  datas: exams,
                  itemBuilder: (exam) {
                    return GestureDetector(
                      onTap: () => goToDetail(exam),
                      child: ExamCollectionItem(exam: exam),
                    );
                  },
                );
              },
            ),
          ),
          SPACING.M.vertical,
        ],
      ),
    );
  }

  Future<void> gotoExams() async {
    final isNeedRefresh = await Home.adapter.goToExams(context);
    if (isNeedRefresh) refreshExam();
  }

  Future<void> goToDetail(Exam exam) async {
    Home.adapter.goToExamDetail(context, exam.id);
  }

  Future<void> refreshExam() async {
    Future.wait([
      BlocProvider.of<TopicBloc>(context).refresh(),
      BlocProvider.of<AppBloc>(context).refreshUser(),
      BlocProvider.of<ClassroomsBloc>(context).refresh(),
      BlocProvider.of<ExamsBloc>(context).refresh(),
    ]);
  }
}
