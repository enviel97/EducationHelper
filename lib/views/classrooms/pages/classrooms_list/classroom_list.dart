import 'package:education_helper/helpers/widgets/scroller_grow_disable.dart';
import 'package:education_helper/views/classrooms/bloc/classroom/classroom_bloc.dart';
import 'package:education_helper/views/classrooms/bloc/classroom/classroom_state.dart';
import 'package:education_helper/views/classrooms/placeholders/p_classrooims_list_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/classroom_list_empty.dart';
import 'widgets/classrooms_item/classrooms_item.dart';

class ClassroomList extends StatelessWidget {
  const ClassroomList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClassroomBloc, ClassroomState>(
      builder: (context, state) {
        if (state is ClassroomLoadingState) {
          return const PClassroomItem();
        }
        final classrooms = BlocProvider.of<ClassroomBloc>(context).classrooms;
        if (classrooms.isEmpty) {
          return const EmptyClassroomList();
        }
        return NormalScroll(
          child: ListView.builder(
            padding: const EdgeInsets.only(
              bottom: 20,
              left: 10,
              right: 10,
            ),
            shrinkWrap: true,
            itemCount: classrooms.length,
            itemBuilder: (builder, index) {
              final classroom = classrooms[index];
              return ClassroomItem(classroom: classroom);
            },
          ),
        );
      },
    );
  }
}
