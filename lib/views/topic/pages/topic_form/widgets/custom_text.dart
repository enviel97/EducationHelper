import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:flutter/material.dart';

class KText extends StatelessWidget {
  final String label;
  final Color colorLabel;
  final String text;
  final Color colorText;
  final MainAxisAlignment mainAxisAlignment;
  final Function()? onTap;
  const KText({
    required this.label,
    required this.text,
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    Key? key,
    this.onTap,
    this.colorLabel = kBlackColor,
    this.colorText = kPrimaryDarkColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        Text(
          '$label:',
          style: TextStyle(
            color: colorLabel,
            fontSize: SPACING.M.size * 1.2,
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: onTap,
            child: Text(
              text,
              maxLines: 2,
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: TextStyle(
                color: colorText,
                fontSize: SPACING.M.size * 1.2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
