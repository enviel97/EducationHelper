import 'package:flutter/material.dart';

class RemoveScrollGrowBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class RemoveScrollGrow extends StatelessWidget {
  final Widget scrollableView;
  const RemoveScrollGrow({required this.scrollableView, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: RemoveScrollGrowBehavior(),
      child: scrollableView,
    );
  }
}
