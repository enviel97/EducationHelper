import 'dart:math';

import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/state.x.dart';
import 'package:education_helper/helpers/widgets/scroller_grow_disable.dart';
import 'package:education_helper/models/classroom.model.dart';
import 'package:education_helper/views/widgets/button/custom_link_button.dart';
import 'package:flutter/material.dart';

import '../../home.dart';
import 'widgets/classroom_collection_item.dart';

class ClassroomColection extends StatefulWidget {
  const ClassroomColection({Key? key}) : super(key: key);

  @override
  _ClassroomColectionState createState() => _ClassroomColectionState();
}

class _ClassroomColectionState extends State<ClassroomColection> {
  late List<Classroom> classrooms;
  final adapter = Home.adapter;
  @override
  void initState() {
    super.initState();
    classrooms = List<Classroom>.generate(10, (index) => Classroom.fake());
    classrooms.sort((a, b) => a.exams.length.compareTo(b.exams.length));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220.0,
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(55.0),
        color: isLightTheme ? kBlackColor : kWhiteColor,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 35.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'CLASSROOM',
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: SPACING.M.size * 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                KLinkButton(
                  'More',
                  onPress: gotoClassList,
                  color: isLightTheme ? kWhiteColor : kBlackColor,
                  isBold: true,
                  isUnderline: true,
                )
              ],
            ),
          ),
          SizedBox(
            height: 160.0,
            child: NormalScroll(
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: classrooms.length,
                itemBuilder: (_, index) {
                  final classroom = classrooms[index];
                  return GestureDetector(
                    onTap: () => goToDetail(classroom.id),
                    child: ClassroomCollectionItem(
                      name: classroom.name,
                      exams: List<int>.generate(
                          Random().nextInt(10), (index) => index),
                      members: classroom.members,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void gotoClassList() {
    adapter.goToClassroom(context);
  }

  Future<void> goToDetail(String id) async {
    await adapter.goToClassroomDetail(context, id);
  }
}
