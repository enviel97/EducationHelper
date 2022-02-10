import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:education_helper/helpers/extensions/state.x.dart';
import 'package:education_helper/views/widgets/form/custom_multi_text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnswerInfo extends StatefulWidget {
  final Function(String value) onNoteChange;
  final bool isEditable;
  final String review, note;
  final double grade;
  const AnswerInfo({
    required this.onNoteChange,
    required this.isEditable,
    required this.review,
    required this.grade,
    required this.note,
    Key? key,
  }) : super(key: key);

  @override
  State<AnswerInfo> createState() => _AnswerInfoState();
}

class _AnswerInfoState extends State<AnswerInfo> {
  bool isEdit = false;

  @override
  void initState() {
    super.initState();
    isEdit = widget.isEditable;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: context.disableKeyBoard,
      child: Container(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    KMultiTextField(
                      initValue: widget.note,
                      hintText: 'add something you want ...',
                      labelText: 'Note',
                      hintStyle: TextStyle(
                        color: kWhiteColor.withOpacity(.5),
                      ),
                      onChange: widget.onNoteChange,
                    ),
                    _buildInfoContent(),
                  ],
                ),
              ),
            ),
            _buildGrade(),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoContent() {
    final text = !widget.isEditable
        ? '...'
        : widget.review.isEmpty
            ? 'good job'
            : widget.review;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
          child: Text.rich(TextSpan(
              text: 'Review: ',
              style: const TextStyle(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0),
              children: [
                TextSpan(
                    text: text,
                    style: TextStyle(
                        color: isLightTheme ? kBlackColor : kWhiteColor,
                        fontSize: 18.0))
              ])))
    ]);
  }

  Widget _buildGrade() {
    final color =
        isLightTheme ? const Color(0xFFAD3838) : const Color(0xFFDB4444);
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        'Grade: ${widget.grade.toString()}',
        textAlign: TextAlign.center,
        style: GoogleFonts.satisfy(
          textStyle: TextStyle(
            color: color,
            fontSize: 50.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
