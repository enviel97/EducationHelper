import 'package:flutter/material.dart';

class CircularButton extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final Widget icon;
  final Function()? onClick;
  final String? tooltip;
  const CircularButton({
    required this.width,
    required this.height,
    required this.color,
    required this.icon,
    required this.onClick,
    Key? key,
    this.tooltip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      width: width,
      height: height,
      child: IconButton(
        enableFeedback: true,
        tooltip: tooltip,
        icon: icon,
        visualDensity: VisualDensity.comfortable,
        onPressed: onClick,
      ),
    );
  }
}
