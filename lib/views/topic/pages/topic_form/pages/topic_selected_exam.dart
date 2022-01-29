import 'dart:io';
import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/state.x.dart';
import 'package:education_helper/models/exam.model.dart';
import 'package:education_helper/models/topic.model.dart';
import 'package:education_helper/views/exam/bloc/exam_bloc.dart';
import 'package:education_helper/views/topic/pages/topic_form/widgets/custom_selected.dart';
import 'package:education_helper/views/topic/pages/topic_form/widgets/custom_text.dart';
import 'package:education_helper/views/topic/topics.dart';
import 'package:education_helper/views/topic/typings/color_schema.dart';
import 'package:education_helper/views/topic/widgets/exams_seleted/exams_selected.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopicSeclectExams extends StatefulWidget {
  final void Function(String id) onSelectExam;
  const TopicSeclectExams({
    required this.onSelectExam,
    Key? key,
  }) : super(key: key);

  @override
  State<TopicSeclectExams> createState() => _TopicSeclectExamsState();
}

class _TopicSeclectExamsState extends State<TopicSeclectExams> {
  String? idFile;
  String? idExam;
  String exam = 'Name of exam';
  String subject = 'Name of subject';
  String type = '';

  Color get cardColor => isLightTheme ? kBlackColor : kWhiteColor;

  ColorSchema get colorScheme => ColorSchema.industry(type);

  BoxShadow get shadow {
    return BoxShadow(
      color: kBlackColor.withOpacity(.8),
      offset: const Offset(-5.0, 5.0),
      blurRadius: 10.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 15.0,
          ),
          margin: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              color: kWhiteColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(40.0),
              ),
              boxShadow: [shadow]),
          child: Column(
            children: [
              KSelected(
                onSelected: _selectedExam,
                value: idFile?.split('/').last,
              ),
              SPACING.S.vertical,
              KText(
                label: 'Exam',
                text: exam,
              ),
              SPACING.S.vertical,
              KText(
                label: 'Subject',
                text: subject,
              ),
            ],
          ),
        ),
        SPACING.S.vertical,
        GestureDetector(
          onTap: _gotoDetail,
          child: Container(
            height: 200.0,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 5.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: colorScheme.color,
                borderRadius: const BorderRadius.all(Radius.circular(25.0)),
                border: Border.all(color: colorScheme.light, width: 5.0),
                boxShadow: [shadow]),
            child: _buildFile(),
          ),
        ),
      ],
    );
  }

  Future<void> _selectedExam() async {
    final exam = await showDialog<Exam?>(
        context: context,
        builder: (_) {
          return BlocProvider(
            create: (_) => ExamBloc(),
            child: ExamSelected(id: idExam),
          );
        });
    if (exam == null) return;
    setState(() {
      idExam = exam.id;
      idFile = exam.content.name;
      this.exam = exam.name;
      subject = exam.subject;
      type = exam.type;
    });
  }

  void _gotoDetail() {
    if (idExam?.isEmpty ?? true) return;
    Topics.adapter.gotoExam(context, idExam!);
  }

  Widget _buildFile() {
    if (type.isEmpty) {
      return const Icon(
        Icons.file_copy_rounded,
        color: kWhiteColor,
        size: 45.0,
      );
    }
    return Text(
      type.toUpperCase(),
      style: const TextStyle(
        fontSize: 50.0,
        color: kWhiteColor,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
