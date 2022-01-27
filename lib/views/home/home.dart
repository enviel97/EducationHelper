import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/state.x.dart';
import 'package:education_helper/helpers/widgets/circle_animation.dart';
import 'package:education_helper/helpers/widgets/scroller_grow_disable.dart';
import 'package:education_helper/roots/app_root.dart';
import 'package:education_helper/views/home/adapters/home.adapter.dart';
import 'package:education_helper/views/home/pages/topic_collection/topic_collection.dart';
import 'package:education_helper/views/home/widgets/circle_floating_action_button/menu_button.dart';
import 'package:education_helper/views/widgets/header/appbar_bottom.dart';
import 'package:flutter/material.dart';

import 'pages/classroom_collection/classroom_collection.dart';
import 'pages/exam_collection/exam_collection.dart';
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
  final dtControll = DatePickerTimelineControler();
  final mnController = MenuController();

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
    mnController.dispose();
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
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: NormalScroll(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SPACING.LG.vertical,
                          const TopicCollection(),
                          SPACING.LG.vertical,
                          const ClassroomColection(),
                          SPACING.LG.vertical,
                          const ExamCollection(),
                          SPACING.LG.vertical,
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 30.0,
                  bottom: 10.0,
                  child: MenuButton(
                    controler: mnController,
                    onClickClassroom: gotoClassList,
                    onClickExam: gotoExams,
                    onClickTopic: goTopic,
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

  void goTopic() {
    Home.adapter.goToTopics(context);
  }
}
