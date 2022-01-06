import 'package:education_helper/helpers/widgets/circle_animation.dart';
import 'package:education_helper/models/classroom.model.dart';
import 'package:education_helper/roots/app_root.dart';
import 'package:education_helper/views/home/adapters/home.adapter.dart';
import 'package:flutter/material.dart';

import 'widgets/date_horizantal/date_picker_timeline.dart';

class Home extends StatefulWidget {
  static final HomeAdapter adapter =
      Root.ins.adapter.getAdapter(homeAdapter).as<HomeAdapter>();
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<Classroom> classrooms;
  late List<DateTime> expirDate;
  final DatePickerTimelineControler dtControll = DatePickerTimelineControler();

  @override
  void initState() {
    super.initState();
    classrooms = List<Classroom>.generate(10, (index) => Classroom.fake());
    expirDate = [
      DateTime.now().add(const Duration(days: 7)),
      DateTime.now().add(const Duration(days: 22))
    ];
  }

  @override
  Widget build(BuildContext context) {
    return AnimationCircleLayout(
      child: Scaffold(
        body: SafeArea(
          child: Container(
            alignment: Alignment.bottomCenter,
            decoration: const BoxDecoration(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DatePickerTimeLine(
                  controler: dtControll,
                  onDateChange: dtControll.animateToDate,
                  note: expirDate,
                  initialSelectedDate: DateTime.now(),
                  startDate: DateTime.now().subtract(const Duration(days: 7)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
