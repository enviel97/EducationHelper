import 'package:education_helper/models/user.model.dart';
import 'package:education_helper/views/home/pages/classrooms/widgets/user_avatar.dart';
import 'package:flutter/material.dart';

class Classrooms extends StatefulWidget {
  final User user;

  const Classrooms({
    required this.user,
    Key? key,
  }) : super(key: key);

  @override
  _ClassroomsState createState() => _ClassroomsState();
}

class _ClassroomsState extends State<Classrooms> {
  late User user;

  @override
  void initState() {
    super.initState();
    user = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Flexible(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40.0),
                ),
                child: UserAvatar(url: user.avatar ?? ''),
              ),
            )
          ],
        )
      ],
    );
  }
}
