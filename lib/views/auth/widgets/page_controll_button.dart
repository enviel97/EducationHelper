import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class PageControllButton extends StatelessWidget {
  final int currentIndex;
  final String label;
  final void Function() onPressed;
  const PageControllButton({
    required this.currentIndex,
    required this.label,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = context.mediaSize.width * 0.4;
    return Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: Align(
        alignment: Alignment.topRight,
        child: SafeArea(
          child: Container(
            width: width,
            decoration: const BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.all(Radius.circular(25.0))),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.spaceBetween,
              children: [
                SPACING.M.horizontal,
                Text(
                  label,
                  style: const TextStyle(
                    color: kWhiteColor,
                  ),
                ),
                SPACING.S.horizontal,
                CircleAvatar(
                  backgroundColor: kPrimaryLightColor,
                  child: IconButton(
                    icon: Icon(
                      currentIndex == 1 ? Entypo.graduation_cap : Icons.login,
                      color: kWhiteColor,
                    ),
                    onPressed: onPressed,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
