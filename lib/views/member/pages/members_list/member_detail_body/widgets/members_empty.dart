import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:flutter/material.dart';

class MembersEmpty extends StatelessWidget {
  const MembersEmpty({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              style: TextStyle(
                color: context.isLightTheme ? kWhiteColor : kBlackColor,
                fontSize: SPACING.LG.size,
              ),
              children: [
                const TextSpan(text: "You don't have any member\nClick"),
                TextSpan(
                  text: ' Add Member ',
                  style: TextStyle(
                    color: kBlackColor,
                    fontWeight: FontWeight.bold,
                    fontSize: SPACING.LG.size,
                  ),
                ),
                const TextSpan(text: 'to set more')
              ]),
        ),
      ],
    );
  }
}
