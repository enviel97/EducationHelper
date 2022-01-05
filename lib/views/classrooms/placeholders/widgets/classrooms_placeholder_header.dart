import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/views/classrooms/widgets/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ClassroomPlaceHeader extends StatelessWidget {
  const ClassroomPlaceHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const UserAvatar(url: ''),
        SPACING.M.horizontal,
        Expanded(
          child: Shimmer.fromColors(
            baseColor: kPrimaryColor,
            highlightColor: kPlaceholderDarkColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: double.infinity,
                  height: SPACING.LG.size,
                  color: Colors.white,
                ),
                SPACING.S.vertical,
                Container(
                  width: double.infinity,
                  height: SPACING.M.size,
                  color: Colors.white,
                ),
                SPACING.S.vertical,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 50.0,
                      height: SPACING.M.size,
                      color: Colors.white,
                    ),
                    SizedBox(
                        height: SPACING.M.size,
                        child: const VerticalDivider(color: kPrimaryColor)),
                    Container(
                      width: 50.0,
                      height: SPACING.M.size,
                      color: Colors.white,
                    )
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
