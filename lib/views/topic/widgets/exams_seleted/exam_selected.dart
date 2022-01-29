import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/state.x.dart';
import 'package:education_helper/models/exam.model.dart';
import 'package:education_helper/views/exam/bloc/exam_bloc.dart';
import 'package:education_helper/views/exam/bloc/exam_state.dart';
import 'package:education_helper/views/widgets/button/custom_text_button.dart';
import 'package:education_helper/views/widgets/form/custom_search_field.dart';
import 'package:education_helper/views/widgets/list/list_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../topics.dart';
import 'widgets/exam_list_error.dart';
import 'widgets/exam_list_tile.dart';

class ExamSelected extends StatefulWidget {
  final String? id;
  const ExamSelected({Key? key, this.id}) : super(key: key);

  @override
  State<ExamSelected> createState() => _ExamSelectedState();
}

class _ExamSelectedState extends State<ExamSelected> {
  List<Exam> exams = [];
  bool isNeedReload = false;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ExamBloc>(context).getAll();
  }

  Color get shadowColor =>
      isLightTheme ? kSecondaryDarkColor : kSecondaryLightColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.0,
      shadowColor: shadowColor,
      color: kWhiteColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0))),
      margin: const EdgeInsets.symmetric(
        horizontal: 15.0,
        vertical: 30.0,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            KSearchText(
              hintText: 'Serach with id, subject or exma name',
              onSearch: _search,
            ),
            SPACING.LG.vertical,
            Expanded(
              child: BlocConsumer<ExamBloc, ExamState>(
                listener: (context, state) {
                  if (state is ExamLoadedState) {
                    setState(() {
                      exams = state.exams;
                    });
                  }
                },
                builder: (context, state) {
                  if (state is ExamLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is ExamFailureState) return const ExamListError();

                  return ListBuilder<Exam>(
                    datas: exams,
                    shirinkWrap: true,
                    itemBuilder: (data) => ExamListTile(
                      data: data,
                      isSelected: data.id == widget.id,
                    ),
                    margin: const EdgeInsets.only(bottom: 10.0),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                KTextButton(
                  width: 150.0,
                  onPressed: _onGoToExams,
                  text: 'Go to exams',
                ),
                KTextButton(
                  width: 150.0,
                  isOutline: true,
                  backgroudColor: kWhiteColor,
                  onPressed: () => Navigator.maybePop(context),
                  text: 'Cancel',
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void _search(String value) {
    BlocProvider.of<ExamBloc>(context).search(value);
  }

  void _onGoToExams() async {
    isNeedReload = await Topics.adapter.gotoExams(context);
    if (isNeedReload) BlocProvider.of<ExamBloc>(context).refresh();
  }
}
