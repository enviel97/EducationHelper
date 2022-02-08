import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:flutter/material.dart';

class CircularButton extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final Widget icon;
  final Function()? onClick;
  final String? tooltip;
  final bool isAnimating;
  const CircularButton({
    required this.width,
    required this.height,
    required this.color,
    required this.icon,
    required this.onClick,
    Key? key,
    this.tooltip,
    this.isAnimating = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLighttheme = context.isLightTheme;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: isLighttheme ? kBlackColor : kWhiteColor),
        color: color,
        shape: BoxShape.circle,
      ),
      width: width,
      height: height,
      child: IgnorePointer(
        ignoring: isAnimating,
        child: IconButton(
          enableFeedback: true,
          tooltip: tooltip,
          icon: icon,
          visualDensity: VisualDensity.comfortable,
          onPressed: onClick,
        ),
      ),
    );
  }
}
