import 'package:education_helper/models/user.model.dart';
import 'package:education_helper/views/classrooms/widgets/user_avatar.dart';
import 'package:flutter/material.dart';

class ClassroomDetailHeader extends StatefulWidget {
  final User user;
  const ClassroomDetailHeader({
    required this.user,
    Key? key,
  }) : super(key: key);

  @override
  _ClassroomDetailHeaderState createState() => _ClassroomDetailHeaderState();
}

class _ClassroomDetailHeaderState extends State<ClassroomDetailHeader> {
  @override
  Widget build(BuildContext context) {
    return UserAvatar(
      url: widget.user.avatar ?? '',
    );
  }
}
