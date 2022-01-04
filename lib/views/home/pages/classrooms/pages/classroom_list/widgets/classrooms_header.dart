import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/int_x.dart';
import 'package:education_helper/views/home/pages/classrooms/widgets/user_avatar.dart';
import 'package:flutter/material.dart';

class ClassroomHeader extends StatelessWidget {
  final String avatar;
  final String name;
  final String email;
  final int totalClassroom;
  final int ungradeExams;
  final int totalExams;

  const ClassroomHeader({
    required this.avatar,
    required this.name,
    required this.email,
    required this.ungradeExams,
    required this.totalExams,
    required this.totalClassroom,
    Key? key,
  }) : super(key: key);

  String quantity(int quantity, String ext) {
    final String extention = ' $ext${quantity > 1 ? 's' : ''}';
    return '${quantity.str} $extention';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        UserAvatar(url: avatar),
        SPACING.M.horizontal,
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: SPACING.LG.size,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SPACING.S.vertical,
              Text(
                email,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: SPACING.M.size,
                ),
              ),
              SPACING.S.vertical,
              Flexible(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${ungradeExams.str} / ${quantity(ungradeExams, 'exam')}',
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: SPACING.M.size,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                      height: SPACING.M.size,
                      child: const VerticalDivider(color: kPrimaryColor)),
                  Text(
                    quantity(totalClassroom, 'classroom'),
                    style: TextStyle(
                      fontSize: SPACING.M.size,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ))
            ],
          ),
        ),
      ],
    );
  }
}
