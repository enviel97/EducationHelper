import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:flutter/material.dart';

class KIconButton extends StatelessWidget {
  final Widget icon;
  final void Function() onPressed;
  final Color? backgroundColor;
  final String? text;
  final TextStyle? textStyle;
  final Size? size;
  final EdgeInsets padding;
  final Color? sideColor;
  final bool isDisable;

  const KIconButton({
    required this.icon,
    required this.onPressed,
    Key? key,
    this.text,
    this.textStyle,
    this.size,
    this.backgroundColor,
    this.padding = const EdgeInsets.all(5.0),
    this.sideColor,
    this.isDisable = false,
  }) : super(key: key);

  OutlinedBorder getShape(Color sideColor) {
    if (text?.isEmpty ?? true) {
      return CircleBorder(side: BorderSide(color: sideColor, width: 2.0));
    }
    return RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
        side: BorderSide(color: sideColor, width: 2.0));
  }

  @override
  Widget build(BuildContext context) {
    final backColor = backgroundColor ??
        (context.isLightTheme ? kSecondaryColor : kPrimaryColor);

    final sideColor = this.sideColor ??
        (context.isLightTheme ? kSecondaryLightColor : kPrimaryLightColor);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: size,
        primary: backColor, // backgroundColor
        onPrimary: kWhiteColor, // textColor
        onSurface: kErrorColor, // disableColor
        shadowColor: backColor,
        elevation: 4,
        padding: padding,
        shape: getShape(sideColor),
      ),
      onPressed: isDisable ? null : onPressed,
      child: text?.isEmpty ?? true
          ? CircleAvatar(
              backgroundColor: backColor.withOpacity(.75),
              child: icon,
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                icon,
                SPACING.SM.horizontal,
                Text(text!,
                    style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.0)
                        .merge(textStyle))
              ],
            ),
    );
  }
}
