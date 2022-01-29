import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/models/exam.model.dart';
import 'package:education_helper/views/topic/topics.dart';
import 'package:education_helper/views/topic/typings/color_schema.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class ExamListTile extends StatelessWidget {
  final Exam data;
  final bool isSelected;
  const ExamListTile({
    required this.data,
    required this.isSelected,
    Key? key,
  }) : super(key: key);

  ColorSchema get colorSchema => ColorSchema.industry(data.type);

  @override
  Widget build(BuildContext context) {
    const shape = RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.0)));

    return Material(
      elevation: 20.0,
      shadowColor: kPrimaryDarkColor.withOpacity(.7),
      shape: shape,
      child: ListTile(
        onTap: () {
          Navigator.maybePop<Exam>(context, data);
        },
        shape: shape,
        enableFeedback: true,
        selected: isSelected,
        textColor: kBlackColor,
        selectedColor: kWhiteColor,
        selectedTileColor: kPrimaryColor,
        autofocus: true,
        trailing: IconButton(
          iconSize: 18,
          color: isSelected ? kSecondaryLightColor : kPrimaryColor,
          icon: const Icon(Fontisto.preview),
          onPressed: () => _goDetail(context),
        ),
        leading: Container(
          height: double.infinity,
          width: 50.0,
          decoration: BoxDecoration(
            color: colorSchema.color,
            borderRadius: shape.borderRadius,
            border: Border.all(color: colorSchema.light, width: 2.0),
          ),
          alignment: Alignment.center,
          child: const Text(
            'PDF',
            style: TextStyle(
              color: kWhiteColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          data.name.split('.').first,
          style: TextStyle(
            color: isSelected ? kSecondaryLightColor : kPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(data.subject),
      ),
    );
  }

  void _goDetail(BuildContext context) {
    Topics.adapter.gotoExam(context, data.id);
  }
}
