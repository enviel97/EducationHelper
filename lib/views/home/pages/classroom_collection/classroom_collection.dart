import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/state.x.dart';
import 'package:education_helper/helpers/widgets/scroller_grow_disable.dart';
import 'package:education_helper/roots/bloc/app_bloc.dart';
import 'package:education_helper/views/home/adapters/home.adapter.dart';
import 'package:education_helper/views/home/bloc/home_bloc.dart';
import 'package:education_helper/views/home/bloc/home_state.dart';
import 'package:education_helper/views/widgets/button/custom_link_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../home.dart';
import 'widgets/classroom_collection_empty.dart';
import 'widgets/classroom_collection_item.dart';

class ClassroomColection extends StatefulWidget {
  const ClassroomColection({Key? key}) : super(key: key);

  @override
  _ClassroomColectionState createState() => _ClassroomColectionState();
}

class _ClassroomColectionState extends State<ClassroomColection> {
  HomeAdapter get adapter => Home.adapter;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeBloc>(context).getClassCollection();
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'CLASSROOM',
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: SPACING.M.size * 1.5,
                      fontWeight: FontWeight.bold),
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
          SPACING.M.vertical,
          SizedBox(
            height: 160.0,
            width: double.infinity,
            child: BlocConsumer<HomeBloc, HomeState>(
              listener: (context, state) {
                if (state is HomeFailureState) {
                  BlocProvider.of<AppBloc>(context)
                      .showError(context, state.messenger);
                }
              },
              builder: (context, state) {
                if (state is HClassCollectionSuccessState) {
                  final classrooms = state.classrooms;
                  if (classrooms.isEmpty) {
                    return ClassroomCollectionEmpty(
                      goToClassrooms: gotoClassList,
                    );
                  }
                  return NormalScroll(
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: classrooms.length,
                          itemBuilder: (_, index) {
                            final classroom = classrooms[index];
                            return GestureDetector(
                                onTap: () => goToDetail(
                                      classroom.id,
                                      classroom.name,
                                      classroom.exams.length,
                                      classroom.members.length,
                                    ),
                                child: ClassroomCollectionItem(
                                    name: classroom.name,
                                    exams: classroom.exams.length,
                                    members: classroom.members.length));
                          }));
                }
                if (state is HomeFailureState) {
                  return ClassroomCollectionEmpty(
                    goToClassrooms: gotoClassList,
                  );
                }

                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }

  void gotoClassList() {
    adapter.goToClassroom(context);
  }

  Future<void> goToDetail(
    String id,
    String classname,
    int exams,
    int members,
  ) async {
    await adapter.goToClassroomDetail(
      context,
      uid: id,
      classname: classname,
      exams: exams,
      members: members,
    );
  }
}
