import 'package:education_helper/models/classroom.model.dart';
import 'package:education_helper/models/user.model.dart';
import 'package:education_helper/views/home/pages/classrooms/widgets/user_avatar.dart';
import 'package:flutter/material.dart';

class ClassroomDetail extends StatefulWidget {
  final String id;

  const ClassroomDetail({
    required this.id,
    Key? key,
  }) : super(key: key);

  @override
  _ClassroomDetailState createState() => _ClassroomDetailState();
}

class _ClassroomDetailState extends State<ClassroomDetail> {
  late Classroom classroom;
  @override
  void initState() {
    super.initState();
    classroom = Classroom.fake();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [UserAvatar()],
      ),
    );
  }
}
