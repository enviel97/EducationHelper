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
        primary: backColor,
        onSurface: backColor,
        shadowColor: backColor,
        elevation: 4,
        padding: padding,
        shape: getShape(sideColor),
      ),
      onPressed: onPressed,
      child: text?.isEmpty ?? true
          ? Container(padding: padding, child: icon)
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                icon,
                SPACING.LG.horizontal,
                Text(text!,
                    style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.0)
                        .merge(textStyle))
              ],
            ),
    );
  }
}
