import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/models/answer.model.dart';
import 'package:education_helper/views/answer/answer_grade/widgets/header_answer_grade/header_answer_collapsed.dart';
import 'package:education_helper/views/answer/answer_grade/widgets/header_answer_grade/header_answer_expanded.dart';
import 'package:education_helper/views/answer/answer_grade/widgets/header_answer_grade/header_answer_grade.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class AnswersGrade extends StatefulWidget {
  const AnswersGrade({Key? key}) : super(key: key);

  @override
  State<AnswersGrade> createState() => _AnswersGradeState();
}

class _AnswersGradeState extends State<AnswersGrade> {
  String download = '';
  String name = '';
  String grade = '';
  String memberName = '';
  StatusAnswer status = StatusAnswer.empty;
  String publicLink = '';
  late DateTime submitdate;

  @override
  void initState() {
    super.initState();
    download = '';
    name = '';
    memberName = '@Name Of Member';
    status = StatusAnswer.empty;
    submitdate = DateTime.now().add(const Duration(days: 2));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
      decoration: const BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
          boxShadow: [
            BoxShadow(
              offset: Offset(0.0, -4.0),
              color: kPrimaryColor,
              blurRadius: 4.0,
            )
          ]),
      child: Wrap(
        children: [
          ExpandablePanel(
            controller: ExpandableController(initialExpanded: true),
            theme: const ExpandableThemeData(
              alignment: Alignment.centerLeft,
              useInkWell: false,
              headerAlignment: ExpandablePanelHeaderAlignment.center,
              bodyAlignment: ExpandablePanelBodyAlignment.center,
              iconPadding: EdgeInsets.only(top: 8.0, bottom: 8.0),
              hasIcon: true,
            ),
            header: HeaderAnswerGrade(
              download: download,
              name: name,
              onChangeGrade: (value) => grade = value,
              onConfirm: _onConfirm,
            ),
            expanded: HeaderAnswerExpanded(
              memberName: memberName,
              status: status,
            ),
            collapsed: HeaderAnswerCollapsed(
              memberName: memberName,
              onChanged: (String note) {},
              status: status,
              submitdate: submitdate,
            ),
          ),
        ],
      ),
    );
  }

  void _onConfirm() {
    if (grade.isEmpty) return;
    Navigator.of(context).maybePop(true);
  }
}
