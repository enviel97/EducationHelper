import 'dart:math';

import 'package:education_helper/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:vector_math/vector_math_64.dart';

import 'circular_button.dart';
part 'menu_controller.dart';

class MenuButton extends StatefulWidget {
  final MenuController? controler;
  final Function() onClickClassroom;
  final Function() onClickExam;
  final Function() onClickTopic;
  final bool autoClose;
  const MenuButton({
    required this.onClickClassroom,
    required this.onClickExam,
    required this.onClickTopic,
    Key? key,
    this.controler,
    this.autoClose = true,
  }) : super(key: key);

  @override
  State<MenuButton> createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> with TickerProviderStateMixin {
  late AnimationController _controller, _iconController;
  late Animation<double> _movementController180,
      _movementController225,
      _movementController270,
      _rotationController;

  @override
  void initState() {
    if (widget.controler != null) {
      widget.controler!._setView(this);
    }
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _iconController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 225),
    );
    _movementController180 = _initMoveController(1.2, 75.0, 25.0);
    _movementController225 = _initMoveController(1.4, 55.0, 45.0);
    _movementController270 = _initMoveController(1.75, 35.0, 65.0);
    _rotationController = Tween(begin: 180.0, end: 0.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInCubic,
    ));
    super.initState();
    _controller.addListener(_listenSetState);
  }

  @override
  void dispose() {
    _controller.removeListener(_listenSetState);
    _controller.dispose();
    _iconController.dispose();
    super.dispose();
  }

  Animation<double> _initMoveController(
      double scale, double weightStart, double weightEnd) {
    return TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween(begin: 0.0, end: scale), weight: weightStart),
      TweenSequenceItem<double>(
          tween: Tween(begin: scale, end: 1.0), weight: weightEnd)
    ]).animate(_controller);
  }

  double getRadiansFromDegree(double deg) {
    const unitRadian = 180 / pi;
    return deg / unitRadian;
  }

  Offset offset() {
    return Offset.fromDirection(
      getRadiansFromDegree(180.0),
      100.0,
    );
  }

  Widget menuItem(
    Widget button, {
    required double deg,
    required Animation<double> controller,
    double spacing = 100.0,
  }) {
    return Transform.translate(
      offset: Offset.fromDirection(
        getRadiansFromDegree(deg),
        controller.value * spacing,
      ),
      child: Transform(
        transform:
            Matrix4.rotationZ(getRadiansFromDegree(_rotationController.value))
              ..scale(controller.value),
        alignment: Alignment.center,
        child: button,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200.0,
      height: 200.0,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          menuItem(
            CircularButton(
              color: kSecondaryColor,
              width: 50.0,
              height: 50.0,
              icon: const Icon(MaterialCommunityIcons.google_classroom),
              tooltip: 'Classrooms',
              onClick: () async {
                if (widget.autoClose) _closeMenu();
                widget.onClickClassroom();
              },
            ),
            deg: 180.0,
            controller: _movementController180,
          ),
          menuItem(
            CircularButton(
              color: kSecondaryColor,
              width: 50.0,
              height: 50.0,
              icon: const Icon(MaterialCommunityIcons.file_document_edit),
              tooltip: 'Exams',
              onClick: () async {
                if (widget.autoClose) _closeMenu();
                widget.onClickExam();
              },
            ),
            deg: 225.0,
            controller: _movementController225,
          ),
          menuItem(
            CircularButton(
              color: kSecondaryColor,
              width: 50.0,
              height: 50.0,
              icon: const Icon(MaterialIcons.topic),
              tooltip: 'Topics',
              onClick: () async {
                if (widget.autoClose) _closeMenu();
                widget.onClickTopic();
              },
            ),
            deg: 270.0,
            controller: _movementController270,
          ),
          Transform(
            transform: Matrix4.rotationZ(
              getRadiansFromDegree(_rotationController.value),
            ),
            alignment: Alignment.center,
            child: CircularButton(
              color: kPrimaryColor,
              width: 60.0,
              height: 60.0,
              icon: AnimatedIcon(
                icon: AnimatedIcons.menu_close,
                color: kWhiteColor,
                progress: _iconController,
                semanticLabel: 'Show menu',
              ),
              onClick: _primaryClick,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _closeMenu() async {
    await Future.wait([
      _controller.reverse(),
      _iconController.reverse(),
    ]);
  }

  Future<void> _openMenu() async {
    await Future.wait([
      _controller.forward(),
      _iconController.forward(),
    ]);
  }

  void _primaryClick() {
    if (_controller.isAnimating) return;
    if (_controller.isCompleted) {
      _closeMenu();
    } else {
      _openMenu();
    }
  }

  void _listenSetState() {
    setState(() {});
  }
}
