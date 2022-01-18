import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/state.x.dart';
import 'package:education_helper/helpers/widgets/scroller_grow_disable.dart';
import 'package:education_helper/models/exam.model.dart';
import 'package:education_helper/roots/app_root.dart';
import 'package:education_helper/views/home/adapters/home.adapter.dart';
import 'package:education_helper/views/home/home.dart';
import 'package:education_helper/views/home/pages/exam_collection.dart/widgets/exam_collection_empty.dart';
import 'package:education_helper/views/widgets/button/custom_link_button.dart';
import 'package:education_helper/views/widgets/list/list_builder.dart';
import 'package:flutter/material.dart';

import 'widgets/exam_collection_item.dart';

class ExamCollection extends StatefulWidget {
  const ExamCollection({Key? key}) : super(key: key);

  @override
  _ExamCollectionState createState() => _ExamCollectionState();
}

class _ExamCollectionState extends State<ExamCollection> {
  HomeAdapter get adapter => Home.adapter;
  String errorMessenger = '';
  late List<Exam> exams;

  @override
  void initState() {
    super.initState();
    exams = List.generate(6, (index) => Exam.faker());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.0,
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(55.0),
        color: isLightTheme ? kBlackColor : kWhiteColor,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SPACING.M.vertical,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'EXAM',
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: SPACING.M.size * 1.5,
                      fontWeight: FontWeight.bold),
                ),
                KLinkButton(
                  'More',
                  onPress: gotoExams,
                  color: isLightTheme ? kWhiteColor : kBlackColor,
                  isBold: true,
                  isUnderline: true,
                )
              ],
            ),
          ),
          SPACING.M.vertical,
          // Build List scrole
          Expanded(
            child: ListBuilder(
              scrollDirection: Axis.horizontal,
              emptyList: ExamCollectionEmpty(
                gotoExams: gotoExams,
              ),
              shirinkWrap: true,
              scrollBehavior: NormalScollBehavior(),
              datas: exams,
              itemBuilder: (index) {
                final exam = exams[index];
                return GestureDetector(
                  onTap: () => goToDetail(exam),
                  child: ExamCollectionItem(exam: exam),
                );
              },
            ),
          ),
          SPACING.M.vertical,
        ],
      ),
    );
  }

  void gotoExams() {
    adapter.goToExams(context);
  }

  Future<void> goToDetail(Exam exam) async {}
}
