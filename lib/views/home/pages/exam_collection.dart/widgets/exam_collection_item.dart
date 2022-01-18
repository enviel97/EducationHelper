import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:education_helper/models/exam.model.dart';
import 'package:education_helper/views/home/pages/exam_collection.dart/widgets/exam_image.dart';
import 'package:flutter/material.dart';

class ExamCollectionItem extends StatelessWidget {
  final Exam exam;
  const ExamCollectionItem({
    required this.exam,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        right: 10.0,
        left: 10.0,
        bottom: 10.0,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 10.0),
      width: 150.0,
      decoration: BoxDecoration(
        color: context.isLightTheme ? kWhiteColor : kBlackColor,
        borderRadius: const BorderRadius.all(Radius.circular(40)),
        boxShadow: [
          const BoxShadow(
            color: kPrimaryColor,
            offset: Offset(5, 5),
            blurRadius: 5.0,
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ExamImage(
            public: exam.content.public,
            name: exam.content.name,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  exam.content.originName,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: SPACING.M.size,
                    color: context.isLightTheme
                        ? kPrimaryColor
                        : kSecondaryLightColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SPACING.S.vertical,
                Text(
                  exam.subject,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: SPACING.M.size,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
