import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PClassroomItem extends StatelessWidget {
  const PClassroomItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Shimmer.fromColors(
          baseColor: kPrimaryColor,
          highlightColor: kPlaceholderDarkColor,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 125.0,
                    height: SPACING.M.size,
                    color: kWhiteColor,
                  ),
                  SizedBox(
                    height: SPACING.SM.size,
                    child: const VerticalDivider(thickness: 2.0),
                  ),
                  Container(
                    width: 60.0,
                    height: SPACING.SM.size,
                    color: kWhiteColor,
                  )
                ],
              ),
              Container(
                width: 54.0,
                height: 27.0,
                color: kWhiteColor,
              )
            ],
          ),
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: SPACING.S.size)),
        Container(
          width: context.mediaSize.width,
          height: 70.0,
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
          child: Shimmer.fromColors(
            baseColor: kPrimaryColor,
            highlightColor: kPlaceholderDarkColor,
            child: Wrap(
              spacing: SPACING.SM.size,
              runSpacing: SPACING.SM.size,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: List<Widget>.generate(
                  5,
                  (index) => Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: kWhiteColor,
                        ),
                        height: 32.0,
                        width: 32.0,
                      )),
            ),
          ),
        )
      ],
    );
  }
}
