import 'package:flutter/material.dart';

class NormalScollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
    BuildContext context,
    Widget child,
    AxisDirection axisDirection,
  ) =>
      child;
}

class NormalScroll extends StatelessWidget {
  final Widget child;
  const NormalScroll({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: NormalScollBehavior(),
      child: child,
    );
  }
}
