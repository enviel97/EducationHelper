import 'dart:io';
import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/state.x.dart';
import 'package:education_helper/views/topic/pages/topic_form/topic_form.dart';
import 'package:education_helper/views/topic/pages/topic_form/widgets/custom_selected.dart';
import 'package:education_helper/views/topic/pages/topic_form/widgets/custom_text.dart';
import 'package:education_helper/views/topic/typings/color_schema.dart';
import 'package:flutter/material.dart';

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
  File? file;
  String? id;
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
                value: id,
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
          onTap: _openFile,
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
    final exam = await TopicForm.adapter.selectedExam(context);
    if (exam == null) return;
    setState(() {
      id = exam.id;
      this.exam = exam.name;
      subject = exam.subject;
      type = exam.type;
    });
  }

  void _openFile() {
    if (file == null) return;
    try {} catch (e) {}
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
