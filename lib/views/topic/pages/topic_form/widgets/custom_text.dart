import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:flutter/material.dart';

class KText extends StatelessWidget {
  final String label;
  final Color colorLabel;
  final String text;
  final Color colorText;
  final MainAxisAlignment mainAxisAlignment;
  final double? sizeText;
  final double? sizeLabel;
  final Function()? onTap;
  const KText({
    required this.label,
    required this.text,
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    Key? key,
    this.onTap,
    this.colorLabel = kBlackColor,
    this.colorText = kPrimaryDarkColor,
    this.sizeText,
    this.sizeLabel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label:',
          style: TextStyle(
            color: colorLabel,
            fontSize: sizeLabel ?? (SPACING.M.size * 1.2),
            fontWeight: FontWeight.bold,
          ),
        ),
        SPACING.S.horizontal,
        Expanded(
          child: GestureDetector(
            onTap: onTap,
            child: Text(
              text.isEmpty ? '...' : text,
              maxLines: 2,
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: TextStyle(
                color: colorText,
                fontSize: sizeText ?? (SPACING.M.size * 1.2),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
