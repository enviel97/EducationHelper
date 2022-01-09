import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:flutter/material.dart';

class KTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final TextStyle? style;
  final Color color;
  final bool isOutline;
  final bool isDisable;
  final double? width;
  final Color? backgroudColor;

  const KTextButton({
    required this.onPressed,
    required this.text,
    this.isDisable = false,
    this.isOutline = false,
    this.style,
    this.color = kPrimaryDarkColor,
    this.width,
    Key? key,
    this.backgroudColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = Size(width ?? context.mediaSize.width / 2, SPACING.LG.size);
    final primaryColor =
        context.isLightTheme ? kSecondaryLightColor : kPrimaryLightColor;

    final backgoundColor =
        isOutline ? (backgroudColor ?? context.backgroundColor) : color;
    final textColor = isOutline ? color : kWhiteColor;
    return TextButton(
        style: TextButton.styleFrom(
            minimumSize: size,
            primary: primaryColor,
            onSurface: primaryColor,
            backgroundColor: backgoundColor,
            shadowColor: primaryColor,
            elevation: 4,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(
                  color: color,
                  width: 2.0,
                ))),
        onPressed: isDisable ? null : onPressed,
        child: Text(text,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: SPACING.M.size,
            ).merge(style)));
  }
}
