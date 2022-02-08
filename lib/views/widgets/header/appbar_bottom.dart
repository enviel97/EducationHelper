import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:flutter/material.dart';

class AppbarBottom extends StatelessWidget with PreferredSizeWidget {
  final double height;
  final Widget? child;
  final EdgeInsets padding;
  const AppbarBottom({
    Key? key,
    this.height = 25.0,
    this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: context.isLightTheme ? kWhiteColor : kBlackColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40.0),
        ),
      ),
      child: child,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
