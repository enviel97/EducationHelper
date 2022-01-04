import 'package:flutter/material.dart';

class KLinkButton extends StatelessWidget {
  final String content;
  final Color? color;
  final void Function() onPress;
  final double fontSize;
  final bool isUnderline;
  final bool isBold;
  final double maxWidth;

  const KLinkButton(
    this.content, {
    required this.onPress,
    Key? key,
    this.color,
    this.fontSize = 16.0,
    this.isUnderline = false,
    this.isBold = false,
    this.maxWidth = double.infinity,
  }) : super(key: key);

  FontWeight get weight => isBold ? FontWeight.bold : FontWeight.normal;
  TextDecoration get textDecorate =>
      isUnderline ? TextDecoration.underline : TextDecoration.none;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Text(
          content,
          maxLines: 1,
          style: TextStyle(
            color: color,
            fontSize: fontSize,
            fontWeight: weight,
            decoration: textDecorate,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
