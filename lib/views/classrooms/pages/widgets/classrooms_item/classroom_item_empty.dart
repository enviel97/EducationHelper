import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:flutter/material.dart';

class ClassroomItemEmpty extends StatelessWidget {
  const ClassroomItemEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.mediaSize.width,
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 12.0,
      ),
      decoration: BoxDecoration(
          color: kWhiteColor,
          border: Border.all(),
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(25),
            bottomLeft: Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(
              color: context.isLightTheme ? kBlackColor : kWhiteColor,
              offset: const Offset(2, 4),
              blurRadius: 4.0,
              spreadRadius: 0.0,
            )
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Classroom don't have member",
            style: TextStyle(
              color: kBlackColor,
              fontSize: SPACING.M.size,
            ),
          )
        ],
      ),
    );
  }
}
