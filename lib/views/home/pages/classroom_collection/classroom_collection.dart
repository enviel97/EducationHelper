import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/state.x.dart';
import 'package:education_helper/helpers/widgets/scroller_grow_disable.dart';
import 'package:education_helper/models/classroom.model.dart';
import 'package:education_helper/roots/bloc/app_bloc.dart';
import 'package:education_helper/views/home/adapters/home.adapter.dart';
import 'package:education_helper/views/home/bloc/classrooms/classroom.bloc.dart';
import 'package:education_helper/views/home/bloc/classrooms/classroom.state.dart';
import 'package:education_helper/views/home/widgets/header_collections.dart';
import 'package:education_helper/views/widgets/button/custom_link_button.dart';
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
  String errorMessenger = '';
  List<Classroom> classrooms = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ClassroomsBloc>(context).getClassCollection();
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
                  setState(() => errorMessenger = 'Classroom loading error!');
                }
                if (state is ClassroomLoadedState) {
                  setState(() => classrooms = state.classrooms);
                }
              },
              builder: (context, state) {
                if (state is ClassroomLoadingState) {
                  return Center(
                    child: errorMessenger.isEmpty
                        ? const CircularProgressIndicator()
                        : Text(
                            errorMessenger,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: kPlaceholderDarkColor,
                              fontSize: SPACING.LG.size,
                            ),
                          ),
                  );
                }
                return ListBuilder(
                    scrollDirection: Axis.horizontal,
                    emptyList: ClassroomCollectionEmpty(
                      goToClassrooms: goToClassRoomList,
                    ),
                    shirinkWrap: true,
                    scrollBehavior: NormalScollBehavior(),
                    datas: classrooms,
                    itemBuilder: (index) {
                      final classroom = classrooms[index];
                      return GestureDetector(
                        onTap: () => goToDetail(classroom),
                        child: ClassroomCollectionItem(
                          name: classroom.name,
                          exams: classroom.exams.length,
                          members: classroom.members.length,
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
    await adapter.goToClassroomDetail(
      context,
      uid: classroom.id,
      classname: classroom.name,
      exams: classroom.exams.length,
      members: classroom.members.length,
    );
  }

  void goToClassRoomList() {
    Home.adapter.goToClassroom(context);
  }
}
