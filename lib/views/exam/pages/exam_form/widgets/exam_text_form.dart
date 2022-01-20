import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:education_helper/views/widgets/form/custom_text_field.dart';
import 'package:flutter/material.dart';

class ExamTextForm extends StatelessWidget {
  final void Function(String value) onChanged;
  final String filename;
  final String initial;
  const ExamTextForm({
    required this.onChanged,
    required this.filename,
    required this.initial,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 10.0,
      ),
      decoration: BoxDecoration(
        color: kWhiteColor,
        border: Border.all(color: kBlackColor.withOpacity(.2), width: 0.2),
        borderRadius: BorderRadius.circular(40.0),
        boxShadow: [
          BoxShadow(
            color: kBlackColor.withOpacity(.7),
            offset: const Offset(4, 4),
            blurRadius: 4.0,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Exam: ',
                style: TextStyle(
                  color: kBlackColor,
                  fontSize: SPACING.M.size,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    filename,
                    style: TextStyle(
                      color: context.isLightTheme
                          ? kSecondaryDarkColor
                          : kPrimaryDarkColor,
                      fontSize: SPACING.M.size * 1.2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
          KTextField(
            iconData: Icons.subject_rounded,
            hintText: 'Subject',
            initValue: initial,
            onChange: onChanged,
          ),
        ],
      ),
    );
  }
}
