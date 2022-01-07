import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:education_helper/helpers/ultils/funtions.dart';
import 'package:education_helper/models/members.model.dart';
import 'package:flutter/material.dart';

class ClassroomCollectionItem extends StatelessWidget {
  final String name;
  final List<dynamic> exams;
  final List<Member> members;
  const ClassroomCollectionItem({
    required this.name,
    required this.exams,
    required this.members,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(
            right: 10.0,
            left: 10.0,
            bottom: 10.0,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 2.0),
          width: 135.0,
          decoration: BoxDecoration(
            color: context.isLightTheme ? kWhiteColor : kBlackColor,
            borderRadius: const BorderRadius.all(Radius.circular(40)),
            boxShadow: [
              const BoxShadow(
                color: kPrimaryColor,
                offset: Offset(5, 5),
                blurRadius: 5.0,
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                name,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: SPACING.M.size,
                  color: context.isLightTheme
                      ? kPrimaryColor
                      : kSecondaryLightColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                quantity(exams.length, 'exam'),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: SPACING.M.size,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                quantity(members.length, 'member'),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: SPACING.M.size,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
        exams.isEmpty
            ? const SizedBox.shrink()
            : Positioned(
                right: 5.0,
                top: 0.0,
                child: CircleAvatar(
                  radius: 15.0,
                  backgroundColor: kErrorColor,
                  child: Text(
                    '${exams.length}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              )
      ],
    );
  }
}
