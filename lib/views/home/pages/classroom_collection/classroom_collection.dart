import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/state.x.dart';
import 'package:education_helper/helpers/widgets/scroller_grow_disable.dart';
import 'package:education_helper/roots/bloc/app_bloc.dart';
import 'package:education_helper/views/classrooms/bloc/classroom/classroom_bloc.dart';
import 'package:education_helper/views/classrooms/bloc/classroom/classroom_state.dart';
import 'package:education_helper/views/classrooms/dialogs/add_classroom_dialog.dart';
import 'package:education_helper/views/widgets/button/custom_link_button.dart';
import 'package:education_helper/views/widgets/button/custom_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../home.dart';
import 'widgets/classroom_collection_item.dart';

class ClassroomColection extends StatefulWidget {
  const ClassroomColection({Key? key}) : super(key: key);

  @override
  _ClassroomColectionState createState() => _ClassroomColectionState();
}

class _ClassroomColectionState extends State<ClassroomColection> {
  final adapter = Home.adapter;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ClassroomBloc>(context).getClassroomCollection();
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
          SPACING.M.vertical,
          SizedBox(
            height: 160.0,
            child: BlocConsumer<ClassroomBloc, ClassroomState>(
              listener: (context, state) {
                if (state is ClassroomFailureState) {
                  BlocProvider.of<AppBloc>(context)
                      .showError(context, state.messenger);
                }
              },
              builder: (context, state) {
                if (state is ClassroomCollectionState &&
                    state.classrooms.isNotEmpty) {
                  final classrooms = state.classrooms;
                  return NormalScroll(
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
                                    exams: classroom.exams.length,
                                    members: classroom.members.length));
                          }));
                }
                if (state is ClassroomFailureState ||
                    state is ClassroomCollectionState &&
                        state.classrooms.isEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "You don't have any classrooms",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: kPlaceholderDarkColor,
                          fontSize: SPACING.LG.size,
                        ),
                      ),
                      SPACING.LG.vertical,
                      KTextButton(
                          onPressed: () => addClassroom(context),
                          text: 'Create once'),
                    ],
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

  Future<void> goToDetail(String id) async {
    await adapter.goToClassroomDetail(context, id);
  }
}
