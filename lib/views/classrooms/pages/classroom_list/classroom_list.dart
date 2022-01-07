import 'package:education_helper/helpers/widgets/scroller_grow_disable.dart';
import 'package:education_helper/models/classroom.model.dart';
import 'package:education_helper/models/user.model.dart';
import 'package:flutter/material.dart';

import 'widgets/classrooms_header.dart';
import 'widgets/classrooms_item/classrooms_item.dart';

class ClassroomList extends StatefulWidget {
  final User user;

  const ClassroomList({
    required this.user,
    Key? key,
  }) : super(key: key);

  @override
  _ClassroomListState createState() => _ClassroomListState();
}

class _ClassroomListState extends State<ClassroomList> {
  late User user;
  late List<Classroom> classrooms;
  final int numOfClass = 3;

  @override
  void initState() {
    super.initState();
    user = widget.user;
    classrooms = List.generate(numOfClass, (index) => Classroom.fake());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              bottom: 10.0,
            ),
            child: ClassroomHeader(
              avatar: user.avatar ?? '',
              name: user.name,
              email: user.email,
              ungradeExams: 0,
              totalExams: 0,
              totalClassroom: numOfClass,
            ),
          ),
          Expanded(
            child: NormalScroll(
              child: ListView.builder(
                padding: const EdgeInsets.only(
                  bottom: 20,
                  left: 10,
                  right: 10,
                ),
                shrinkWrap: true,
                itemCount: classrooms.length,
                itemBuilder: _buildItem,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    final classroom = classrooms[index];
    return GestureDetector(
      onTap: gotoDetail,
      child: ClassroomItem(classroom: classroom),
    );
  }

  void gotoDetail() {
    print('gotoDetail');
  }
}
