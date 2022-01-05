import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'widgets/classrooms_placeholder_header.dart';

class ClassroomsPlaceholder extends StatelessWidget {
  const ClassroomsPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const ClassroomPlaceHeader(),
            SPACING.LG.vertical,
            Shimmer.fromColors(
              baseColor: kPrimaryColor,
              highlightColor: kPlaceholderDarkColor,
              child: Container(
                width: double.infinity,
                height: 200.0,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
