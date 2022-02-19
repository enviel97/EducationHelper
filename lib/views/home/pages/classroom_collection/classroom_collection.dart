import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/state.x.dart';
import 'package:education_helper/helpers/widgets/scroller_grow_disable.dart';
import 'package:education_helper/models/classroom.model.dart';
import 'package:education_helper/roots/bloc/app_bloc.dart';
import 'package:education_helper/views/home/adapters/home.adapter.dart';
import 'package:education_helper/views/home/bloc/classrooms/classroom.bloc.dart';
import 'package:education_helper/views/home/bloc/classrooms/classroom.state.dart';
import 'package:education_helper/views/home/bloc/exams/exam.bloc.dart';
import 'package:education_helper/views/home/bloc/topics/topic.bloc.dart';
import 'package:education_helper/views/home/widgets/header_collections.dart';
import 'package:education_helper/views/widgets/list/list_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../home.dart';
import 'widgets/classroom_collection_empty.dart';
import 'widgets/classroom_collection_item.dart';

class ClassroomColection extends StatefulWidget {
  const ClassroomColection({
    Key? key,
  }) : super(key: key);

  @override
  _ClassroomColectionState createState() => _ClassroomColectionState();
}

class _ClassroomColectionState extends State<ClassroomColection> {
  HomeAdapter get adapter => Home.adapter;
  List<Classroom> classrooms = [];

  @override
  void initState() {
    super.initState();
    // BlocProvider.of<ClassroomsBloc>(context).getClassCollection();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240.0,
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
          HeaderCollection(
            title: 'Classroom',
            qunatity: classrooms.length,
            onPressMore: goToClassRoomList,
          ),
          SPACING.M.vertical,
          SizedBox(
            height: 160.0,
            width: double.infinity,
            child: BlocConsumer<ClassroomsBloc, ClassroomState>(
              listener: (context, state) {
                if (state is ClassroomFailState) {
                  BlocProvider.of<AppBloc>(context)
                      .showError(context, state.messenger.mess);
                  setState(() => classrooms = []);
                }
                if (state is ClassroomLoadedState) {
                  setState(() => classrooms = state.classrooms);
                }
              },
              builder: (context, state) {
                if (state is ClassroomLoadingState && classrooms.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is ClassroomFailState) {
                  return ClassroomCollectionEmpty(
                    onStateHandle:
                        BlocProvider.of<ClassroomsBloc>(context).refresh,
                    messneger: 'An error occurred loading data.'
                        'please wait a few minutes and click refresh',
                    title: 'Refresh',
                  );
                }

                return ListBuilder(
                    scrollDirection: Axis.horizontal,
                    emptyList: ClassroomCollectionEmpty(
                      onStateHandle: goToClassRoomList,
                    ),
                    shirinkWrap: true,
                    scrollBehavior: NormalScollBehavior(),
                    datas: classrooms,
                    itemBuilder: (Classroom classroom) {
                      return GestureDetector(
                        onTap: () => goToDetail(classroom),
                        child: ClassroomCollectionItem(
                          name: classroom.name,
                          exams: classroom.exams.length,
                          members: classroom.size,
                        ),
                      );
                    });
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> goToDetail(Classroom classroom) async {
    final isNeedChagne = await adapter.goToClassroomDetail(
      context,
      uid: classroom.id,
      classname: classroom.name,
      exams: classroom.exams.length,
      members: classroom.members.length,
    );
    if (isNeedChagne) _refresh();
  }

  Future<void> goToClassRoomList() async {
    final isNeedRefresh = await Home.adapter.goToClassroom(context);
    if (isNeedRefresh) _refresh();
  }

  void _refresh() async {
    Future.wait([
      BlocProvider.of<TopicBloc>(context).refresh(),
      BlocProvider.of<AppBloc>(context).refreshUser(),
      BlocProvider.of<ClassroomsBloc>(context).refresh(),
      BlocProvider.of<ExamsBloc>(context).refresh(),
    ]);
  }
}
