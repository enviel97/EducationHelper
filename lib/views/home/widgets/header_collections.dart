import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:education_helper/views/widgets/button/custom_link_button.dart';
import 'package:flutter/material.dart';

class HeaderCollection extends StatelessWidget {
  final String title;
  final Function() onPressMore;
  final Color? textColor;
  final Color? textMoreColor;
  final int qunatity;
  const HeaderCollection({
    required this.title,
    required this.onPressMore,
    required this.qunatity,
    Key? key,
    this.textColor,
    this.textMoreColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLightTheme = context.isLightTheme;
    final textColor =
        this.textColor ?? (isLightTheme ? kSecondaryColor : kPrimaryColor);
    final textMoreColor =
        this.textMoreColor ?? (isLightTheme ? kWhiteColor : kBlackColor);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      color: textColor,
                      fontSize: SPACING.M.size * 1.5,
                      fontWeight: FontWeight.bold),
                ),
                SPACING.S.horizontal,
                Text(
                  '($qunatity)',
                  style: TextStyle(
                      color: kPlaceholderDarkColor,
                      fontSize: SPACING.M.size * 1.1,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          KLinkButton(
            'More',
            onPress: onPressMore,
            color: textMoreColor,
            isBold: true,
            isUnderline: true,
          )
        ],
      ),
    );
  }
}
