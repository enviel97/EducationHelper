import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/state.x.dart';
import 'package:education_helper/helpers/widgets/circle_animation.dart';
import 'package:education_helper/helpers/widgets/scroller_grow_disable.dart';
import 'package:education_helper/models/user.model.dart';
import 'package:education_helper/roots/app_root.dart';
import 'package:education_helper/roots/bloc/app_bloc.dart';
import 'package:education_helper/views/home/adapters/home.adapter.dart';
import 'package:education_helper/views/home/bloc/classrooms/classroom.bloc.dart';
import 'package:education_helper/views/home/bloc/exams/exam.bloc.dart';
import 'package:education_helper/views/home/bloc/topics/topic.bloc.dart';
import 'package:education_helper/views/home/pages/home_app_bar_child.dart';
import 'package:education_helper/views/home/pages/topic_collection/topic_collection.dart';
import 'package:education_helper/views/home/widgets/circle_floating_action_button/menu_button.dart';
import 'package:education_helper/views/widgets/deorate/custom_confirm_alert.dart';
import 'package:education_helper/views/widgets/header/appbar_bottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'pages/classroom_collection/classroom_collection.dart';
import 'pages/exam_collection/exam_collection.dart';

class Home extends StatefulWidget {
  static final adapter =
      Root.ins.adapter.getAdapter(homeAdapter).cast<HomeAdapter>();
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final mnController = MenuController();
  late User user;
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController()..addListener(_onScroll);
    super.initState();
    _fetch();
  }

  @override
  void dispose() {
    mnController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimationCircleLayout(
      child: Scaffold(
        appBar: AppBar(
            title: const Text('Home'),
            elevation: 0.0,
            bottom: const AppbarBottom(
              padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
              height: 250.0,
              child: HomeAppBarChild(),
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
                      controller: _scrollController,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SPACING.M.vertical,
                          const TopicCollection(),
                          SPACING.LG.vertical,
                          const ClassroomColection(),
                          SPACING.LG.vertical,
                          const ExamCollection(),
                          SPACING.M.vertical,
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
                    onClickClassroom: () => gotoClassList(context),
                    onClickExam: () => gotoExams(context),
                    onClickTopic: () => goTopic(context),
                    onShutdown: logout,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> gotoClassList(BuildContext context) async {
    final isNeedRefresh = await Home.adapter.goToClassroom(context);
    if (isNeedRefresh) homeRefresh(context);
  }

  Future<void> gotoExams(BuildContext context) async {
    final isNeedRefresh = await Home.adapter.goToExams(context);
    if (isNeedRefresh) homeRefresh(context);
  }

  Future<void> goTopic(BuildContext context) async {
    final isNeedRefresh = await Home.adapter.goToTopics(context);
    if (isNeedRefresh) homeRefresh(context);
  }

  void _onScroll() {
    if (mounted) {
      mnController.closeMenu();
    }
  }

  Future<void> logout() async {
    final isConfirm = await showDialog<bool>(
      context: context,
      builder: (_) {
        return KConfirmAlert(
            title: 'Sign out',
            notice: 'Are you sure you want',
            content: '\nSIGN OUT',
            onConfirm: () {
              BlocProvider.of<AppBloc>(context)
                  .removeToken()
                  .then((isRemoveSuccess) =>
                      Navigator.maybePop(context, isRemoveSuccess))
                  .catchError((_) {
                debugPrint('[Logout remove error]: $_');
                Navigator.maybePop(context, false);
              });
            });
      },
    );
    if (isConfirm ?? false) {
      Home.adapter.goToLogin(context);
    }
  }

  Future<void> homeRefresh(BuildContext context) async {
    Future.wait([
      BlocProvider.of<TopicBloc>(context).refresh(),
      BlocProvider.of<AppBloc>(context).refreshUser(),
      BlocProvider.of<ClassroomsBloc>(context).refresh(),
      BlocProvider.of<ExamsBloc>(context).refresh(),
    ]);
  }

  void _fetch() {
    Future.wait([
      BlocProvider.of<TopicBloc>(context).getTopicCollection(),
      BlocProvider.of<AppBloc>(context).getUser(),
      BlocProvider.of<ClassroomsBloc>(context).getClassCollection(),
      BlocProvider.of<ExamsBloc>(context).getExamCollection(),
    ]);
  }
}
