import 'dart:math';

import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/state.x.dart';
import 'package:education_helper/helpers/widgets/circle_animation.dart';
import 'package:education_helper/helpers/widgets/scroller_grow_disable.dart';
import 'package:education_helper/roots/app_root.dart';
import 'package:education_helper/views/home/adapters/home.adapter.dart';
import 'package:education_helper/views/home/widgets/circle_floating_action_button/menu_button.dart';
import 'package:education_helper/views/widgets/header/appbar_bottom.dart';
import 'package:flutter/material.dart';

import 'pages/classroom_collection/classroom_collection.dart';
import 'pages/exam_collection.dart/exam_collection.dart';
import 'widgets/circle_floating_action_button/circular_button.dart';
import 'widgets/date_horizantal/date_picker_timeline.dart';

class Home extends StatefulWidget {
  static final adapter =
      Root.ins.adapter.getAdapter(homeAdapter).cast<HomeAdapter>();
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<DateTime> expirDate;
  final DatePickerTimelineControler dtControll = DatePickerTimelineControler();

  @override
  void initState() {
    super.initState();
    expirDate = [
      DateTime.now().add(const Duration(days: 7)),
      DateTime.now().add(const Duration(days: 22))
    ];
  }

  @override
  void dispose() {
    dtControll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimationCircleLayout(
      child: Scaffold(
        appBar: AppBar(
            title: const Text('HOME'),
            elevation: 0.0,
            bottom: AppbarBottom(
              height: 165.0,
              child: DatePickerTimeLine(
                controler: dtControll,
                onDateChange: dtControll.animateToDate,
                note: expirDate,
                initialSelectedDate: DateTime.now(),
                startDate: DateTime.now().subtract(const Duration(days: 7)),
              ),
            )),
        body: SafeArea(
          child: SizedBox(
            height: size.height,
            width: size.width,
            child: Stack(
              fit: StackFit.expand,
              children: [
                NormalScroll(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SPACING.LG.vertical,
                        ClassroomColection(goToClassRoomList: gotoClassList),
                        SPACING.LG.vertical,
                        ExamCollection(goToExams: gotoExams),
                        SPACING.LG.vertical,
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: 30.0,
                  bottom: 30.0,
                  child: MenuButton(
                    onClickClassroom: gotoClassList,
                    onClickExam: gotoExams,
                    onClickTopic: goTopicList,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void gotoClassList() {
    Home.adapter.goToClassroom(context);
  }

  void gotoExams() {
    Home.adapter.goToExams(context);
  }

  void goTopicList() {
    // Home.adapter.goToClassroom(context);
  }
}
