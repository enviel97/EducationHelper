import 'package:education_helper/constants/constant.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:flutter/material.dart';

class TopicListEmpty extends StatelessWidget {
  const TopicListEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: Text(
          "You don't have any topic right now, click $plus to add more",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: SPACING.LG.size,
          ),
        ),
      ),
    );
  }
}
