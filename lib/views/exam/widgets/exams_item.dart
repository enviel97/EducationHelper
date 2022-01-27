import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:education_helper/helpers/modules/file_module.dart';
import 'package:education_helper/models/exam.model.dart';
import 'package:education_helper/views/exam/dialogs/exam_dialogs.dart';
import 'package:education_helper/views/exam/widgets/exam_image.dart';
import 'package:education_helper/views/widgets/button/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../exam.dart';

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
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            overflow: TextOverflow.fade,
            maxLines: 1,
            softWrap: false,
            style: TextStyle(
              color: kWhiteColor,
              fontWeight: FontWeight.bold,
              fontSize: SPACING.M.size * 1.1,
            ),
          ),
        )
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
                      ? kSecondarySuperDarkColor
                      : kPrimaryDarkColor,
                  borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                  border: Border.all(
                    color: context.isLightTheme
                        ? kSecondaryColor
                        : kPrimaryLightColor,
                    width: 5.0,
                  )),
              padding: const EdgeInsets.only(left: 50.0, right: 15.0),
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildLabelRow(
                      'Name', exam.content.originName.split('.').first),
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
          Positioned(
            bottom: 0.0,
            child: Row(
              children: [
                KIconButton(
                  icon: const Icon(Feather.edit, color: kWhiteColor),
                  backgroundColor: kPrimaryColor,
                  sideColor: kPrimaryColor,
                  size: const Size(20.0, 20.0),
                  onPressed: () => _onEdit(context),
                ),
                KIconButton(
                  icon: const Icon(Feather.x_circle, color: kWhiteColor),
                  backgroundColor: kErrorColor,
                  sideColor: kErrorColor,
                  size: const Size(20.0, 20.0),
                  onPressed: () => _onDelete(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onDelete(BuildContext context) {
    deleteExam(context, exam.content.originName, exam.id);
  }

  void _onEdit(BuildContext context) async {
    try {
      await FileModule(exam.content.name).loadFile().then((value) {
        Exams.adapter.goToEditExam(
          context,
          id: exam.id,
          subject: exam.subject,
          file: value,
        );
      });
    } catch (error) {
      debugPrint('$error');
    }
  }
}
