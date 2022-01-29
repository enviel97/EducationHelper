import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:flutter/material.dart';

class KSelected extends StatelessWidget {
  final Function() onSelected;
  final String hintText;
  final String? value;
  final IconData icon;
  const KSelected({
    required this.onSelected,
    Key? key,
    this.value,
    this.hintText = 'Select',
    this.icon = Icons.document_scanner,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLight = context.isLightTheme;
    final backgroundColor = isLight ? kSecondaryColor : kPrimaryColor;
    const color = kWhiteColor;
    return GestureDetector(
      onTap: onSelected,
      child: Container(
        height: 48.0,
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 10.0,
        ),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(40.0)),
          color: backgroundColor,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: color,
              size: SPACING.LG.size,
            ),
            SPACING.LG.horizontal,
            Expanded(
                child: Text(
              value?.isEmpty ?? true ? hintText : value!,
              maxLines: 1,
              softWrap: false,
              overflow: TextOverflow.fade,
              style: TextStyle(
                color: color,
                fontSize: SPACING.M.size,
                fontWeight: FontWeight.bold,
              ),
            )),
            Icon(
              Icons.keyboard_arrow_right_rounded,
              color: kWhiteColor,
              size: SPACING.LG.size,
            )
          ],
        ),
      ),
    );
  }
}
