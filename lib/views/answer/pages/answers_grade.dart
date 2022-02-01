import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/models/topic.model.dart';
import 'package:education_helper/views/answer/widgets/header_answer_grade/header_answer_collapsed.dart';
import 'package:education_helper/views/answer/widgets/header_answer_grade/header_answer_expanded.dart';
import 'package:education_helper/views/answer/widgets/header_answer_grade/header_answer_grade.dart';
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
    publicLink =
        'https://scontent.fsgn6-2.fna.fbcdn.net/v/t39.30808-6/271656093_2099695566864074_1280132571646855750_n.jpg?_nc_cat=100&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=6eoHNK6ZI0YAX-01gPU&_nc_ht=scontent.fsgn6-2.fna&oh=00_AT9BqFSUpQ1PNJ_0ISWAtgRFfh7Cugc8F_gJhg-zW6i-GA&oe=61FDFF62';
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
      ),
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
              publicLink: '',
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
    Navigator.of(context).maybePop();
  }
}
