import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:education_helper/views/classrooms/widgets/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PMemberHeader extends StatelessWidget {
  const PMemberHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Shimmer.fromColors(
        baseColor: kPrimaryColor,
        highlightColor: kWhiteColor,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  const UserAvatar(url: ''),
                  SPACING.SM.vertical,
                  Container(
                    width: 100,
                    height: SPACING.LG.size,
                    color: kWhiteColor,
                  ),
                  SPACING.SM.vertical,
                  Container(
                    width: 200,
                    height: SPACING.M.size,
                    color: kWhiteColor,
                  )
                ],
              ),
            ),
            Positioned(
              top: SPACING.SM.size,
              left: SPACING.SM.size,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new),
                color: context.isLightTheme ? kBlackColor : kWhiteColor,
                onPressed: Navigator.of(context).pop,
              ),
            )
          ],
        ),
      ),
    );
  }
}
