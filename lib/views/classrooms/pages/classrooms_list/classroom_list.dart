import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:education_helper/helpers/widgets/scroller_grow_disable.dart';
import 'package:education_helper/models/classroom.model.dart';
import 'package:education_helper/views/classrooms/pages/classroom_detail/classroom_detail.dart';
import 'package:flutter/material.dart';

import 'widgets/classrooms_item/classrooms_item.dart';

class ClassroomList extends StatelessWidget {
  const ClassroomList({
    required this.classrooms,
    Key? key,
  }) : super(key: key);

  final List<Classroom> classrooms;

  @override
  Widget build(BuildContext context) {
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
              return GestureDetector(
                  onTap: () => context.goTo(ClassroomDetail(id: classroom.id)),
                  child: ClassroomItem(classroom: classroom));
            }));
  }
}
