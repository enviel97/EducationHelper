import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/models/answer.model.dart';
import 'package:education_helper/roots/bloc/app_bloc.dart';
import 'package:education_helper/views/answer/answer_grade/widgets/header_answer_grade/header_answer_collapsed.dart';
import 'package:education_helper/views/answer/answer_grade/widgets/header_answer_grade/header_answer_expanded.dart';
import 'package:education_helper/views/answer/answer_grade/widgets/header_answer_grade/header_answer_grade.dart';
import 'package:education_helper/views/answer/bloc/answer_bloc.dart';
import 'package:education_helper/views/answer/bloc/answer_state.dart';
import 'package:education_helper/views/widgets/deorate/custom_confirm_alert.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnswersGrade extends StatefulWidget {
  const AnswersGrade({
    Key? key,
  }) : super(key: key);

  @override
  State<AnswersGrade> createState() => _AnswersGradeState();
}

class _AnswersGradeState extends State<AnswersGrade> {
  String download = '',
      name = '',
      grade = '',
      memberName = '',
      infoMember = '',
      review = '',
      publicLink = '';
  DateTime? submitdate;
  StatusAnswer status = StatusAnswer.empty;

  @override
  void initState() {
    super.initState();
    memberName = '@Name Of Member';
    status = StatusAnswer.empty;
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
          BlocListener<AnswerBloc, AnswerState>(
            listener: (context, state) {
              if (state is AnswerLoaded) {
                final content = state.answer.content;
                final member = state.answer.member;

                setState(() {
                  download = content.download;
                  name = content.originName;
                  memberName = member.name;
                  status = state.answer.status;
                  submitdate = state.answer.createdAt;
                  grade = state.answer.grade.toString();
                  infoMember = member.phoneNumber ??
                      member.mail ??
                      "Don't havve info contact";
                });
              }
            },
            child: ExpandablePanel(
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
                grade: '',
              ),
              expanded: HeaderAnswerExpanded(
                memberName: 'NAME: $memberName',
                infoMember: infoMember,
                status: status,
              ),
              collapsed: HeaderAnswerCollapsed(
                memberName: 'NAME: $memberName',
                infoMember: infoMember,
                onChanged: (review) => this.review = review,
                status: status,
                submitdate: submitdate,
                review: review,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onConfirm() async {
    if (grade.isEmpty) return;
    try {
      final isConfirm = await showDialog(
        context: context,
        builder: (_) {
          return KConfirmAlert(
              title: 'Grade: $name',
              notice: 'Member: $memberName',
              content: '\nGrade: $grade',
              onConfirm: () {
                BlocProvider.of<AnswerBloc>(context)
                    .grade(
                      grade: double.tryParse(grade) ?? 0.0,
                      review: review,
                    )
                    .whenComplete(() => Navigator.maybePop(context, true));
              });
        },
      );
      if (isConfirm) {
        Navigator.maybePop(context, true);
      }
    } catch (e) {
      BlocProvider.of<AppBloc>(context).showError(context, 'Error system');
    }
  }
}
