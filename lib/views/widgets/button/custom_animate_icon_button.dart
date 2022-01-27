import 'dart:math';

import 'package:education_helper/constants/colors.dart';
import 'package:flutter/material.dart';

class AnimateIcons extends StatefulWidget {
  final IconData startIcon, endIcon;
  final Function() onStartIconPress, onEndIconPress;
  final double size;
  final Color? iconColor;
  final String? tooltip;

  const AnimateIcons({
    required this.startIcon,
    required this.endIcon,
    required this.onStartIconPress,
    required this.onEndIconPress,
    Key? key,
    this.size = 24.0,
    this.iconColor = kWhiteColor,
    this.tooltip,
  }) : super(key: key);

  @override
  _AnimateIconsState createState() => _AnimateIconsState();
}

class _AnimateIconsState extends State<AnimateIcons>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationController;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(microseconds: 250),
    );

    _rotationController = Tween(begin: 360.0, end: 0.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInCubic,
    ));

    _controller.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onPressIcon() {
    if (_controller.isAnimating) return;
    if (!mounted) return;
    if (_controller.isCompleted) {
      widget.onEndIconPress();
      _controller.reverse();
    }
    if (_controller.isDismissed) {
      widget.onStartIconPress();
      _controller.forward();
    }
  }

  double getRadiansFromDegree(double deg) {
    const unitRadian = 180 / pi;
    return deg / unitRadian;
  }

  Widget get first {
    return Transform(
      transform:
          Matrix4.rotationZ(getRadiansFromDegree(_rotationController.value)),
      alignment: Alignment.center,
      child: AnimatedOpacity(
        opacity: _rotationController.value / 360.0,
        duration: const Duration(microseconds: 200),
        child: Icon(widget.startIcon),
      ),
    );
  }

  Widget get second {
    return Transform(
      transform:
          Matrix4.rotationZ(getRadiansFromDegree(_rotationController.value)),
      alignment: Alignment.center,
      child: AnimatedOpacity(
        opacity: 1 - _rotationController.value / 360.0,
        duration: const Duration(microseconds: 200),
        child: Icon(widget.endIcon),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: widget.size,
      color: widget.iconColor,
      tooltip: widget.tooltip,
      padding: const EdgeInsets.all(0.0),
      splashColor: kNone,
      splashRadius: 10.0,
      icon: Stack(
        children: [first, second],
      ),
      onPressed: _controller.isAnimating ? null : _onPressIcon,
    );
  }
}
