import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/state.x.dart';
import 'package:education_helper/helpers/widgets/circle_animation.dart';
import 'package:education_helper/helpers/widgets/scroller_grow_disable.dart';
import 'package:education_helper/models/user.model.dart';
import 'package:education_helper/roots/app_root.dart';
import 'package:education_helper/roots/bloc/app_bloc.dart';
import 'package:education_helper/roots/bloc/app_state.dart';
import 'package:education_helper/views/home/adapters/home.adapter.dart';
import 'package:education_helper/views/home/bloc/classrooms/classroom.bloc.dart';
import 'package:education_helper/views/home/bloc/exams/exam.bloc.dart';
import 'package:education_helper/views/home/bloc/topics/topic.bloc.dart';
import 'package:education_helper/views/home/pages/topic_collection/topic_collection.dart';
import 'package:education_helper/views/home/widgets/circle_floating_action_button/menu_button.dart';
import 'package:education_helper/views/widgets/button/custom_icon_button.dart';
import 'package:education_helper/views/widgets/header/appbar_bottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  final dtControll = DatePickerTimelineControler();
  final mnController = MenuController();
  late User user;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AppBloc>(context).getUser();
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
              height: 210.0,
              child: _buildAppBarChild,
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

  Widget get _buildAppBarChild {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(
            height: 50.0,
            width: 85.0,
            child: Wrap(children: [
              KIconButton(
                  icon: const Icon(Icons.calendar_today, size: 20.0),
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  onPressed: () => dtControll.animateToDate(DateTime.now()),
                  text: 'Now')
            ])),
        Expanded(
            child: BlocBuilder<AppBloc, AppState>(builder: (context, state) {
          List<DateTime> expiredDate = [];
          if (state is UserStateSuccess) {
            expiredDate = state.user.exams.map((e) => e.expiredDate).toList();
          }
          return DatePickerTimeLine(
              controler: dtControll,
              onDateChange: dtControll.animateToDate,
              note: expiredDate,
              initialSelectedDate: DateTime.now(),
              startDate: DateTime.now().subtract(const Duration(days: 7)));
        }))
      ],
    );
  }

  Future<void> homeRefresh() async {
    Future.wait([
      BlocProvider.of<TopicBloc>(context).refresh(),
      BlocProvider.of<AppBloc>(context).refreshUser(),
      BlocProvider.of<ClassroomsBloc>(context).refresh()
    ]);
  }

  Future<void> gotoClassList() async {
    final isNeedRefresh = await Home.adapter.goToClassroom(context);
    if (isNeedRefresh) BlocProvider.of<ClassroomsBloc>(context).refresh();
  }

  Future<void> gotoExams() async {
    final isNeedRefresh = await Home.adapter.goToExams(context);
    if (isNeedRefresh) BlocProvider.of<ExamsBloc>(context).refresh();
  }

  Future<void> goTopic() async {
    final isNeedRefresh = await Home.adapter.goToTopics(context);
    if (isNeedRefresh) homeRefresh();
  }
}
