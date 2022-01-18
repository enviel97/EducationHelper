import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:education_helper/models/exam.model.dart';
import 'package:education_helper/views/exam/widgets/exam_image.dart';
import 'package:flutter/material.dart';

class ExamsItem extends StatelessWidget {
  final Exam exam;
  const ExamsItem({
    required this.exam,
    Key? key,
  }) : super(key: key);

  Widget _buildLabelRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$label:',
          style: TextStyle(
            color: kSecondaryLightColor,
            fontWeight: FontWeight.bold,
            fontSize: SPACING.M.size,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: kWhiteColor,
            fontWeight: FontWeight.bold,
            fontSize: SPACING.M.size * 1.1,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = context.mediaSize.width * 0.8;
    return SizedBox(
      width: double.infinity,
      height: 150.0,
      child: Stack(
        children: [
          Positioned(
            top: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: Container(
              width: width,
              decoration: BoxDecoration(
                  color: context.isLightTheme
                      ? kPrimaryDarkColor
                      : kSecondaryDarkColor,
                  borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                  border: Border.all(
                    color: context.isLightTheme
                        ? kPrimaryLightColor
                        : kSecondaryLightColor,
                    width: 5.0,
                  )),
              padding: const EdgeInsets.only(left: 50.0, right: 15.0),
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildLabelRow('Name', exam.content.originName),
                  SPACING.S.vertical,
                  _buildLabelRow('Subject', exam.subject),
                  SPACING.S.vertical,
                  _buildLabelRow('Type', exam.examType.name),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: ExamImage(
              public: exam.content.public,
              name: exam.content.name,
            ),
          ),
        ],
      ),
    );
  }
}
