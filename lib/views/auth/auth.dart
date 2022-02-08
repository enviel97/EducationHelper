import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:education_helper/helpers/extensions/state.x.dart';
import 'package:education_helper/helpers/widgets/circle_animation.dart';
import 'package:education_helper/helpers/widgets/scroller_grow_disable.dart';
import 'package:education_helper/views/auth/widgets/page_controll_button.dart';
import 'package:flutter/material.dart';

import 'pages/topic_form.dart';
import 'widgets/decorate_header.dart';
import 'widgets/expanded_signup.dart';
import 'pages/siginin.dart';
import 'pages/signup.dart';

class Auth extends StatefulWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  _Auth createState() => _Auth();
}

class _Auth extends State<Auth> with SingleTickerProviderStateMixin {
  late bool isExpanded;
  late AnimationController _animationController;
  late PageController _controller;
  late String title = 'SIGN IN', label = 'TOPIC';
  int currentIndex = 0;
  final duration = const Duration(milliseconds: 250);

  @override
  void initState() {
    super.initState();
    isExpanded = false;
    _animationController = AnimationController(vsync: this, duration: duration);
    _controller = PageController(initialPage: currentIndex);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: context.disableKeyBoard,
        child: AnimationCircleLayout(
          child: Stack(children: [
            PageView(
              clipBehavior: Clip.none,
              scrollBehavior: NormalScollBehavior(),
              controller: _controller,
              children: [
                Stack(
                  children: [
                    const SignInPage(),
                    _animationSignUp(),
                  ],
                ),
                const TopicForm()
              ],
            ),
            PageControllButton(
              currentIndex: currentIndex,
              label: label,
              onPressed: _onPressed,
            ),
            DecorateHeader(title: title),
          ]),
        ),
      ),
    );
  }

  void handleClickSignUp() {
    context.disableKeyBoard();
    if (mounted) {
      if (isExpanded) {
        _animationController.forward();
        setState(() {
          isExpanded = !isExpanded;
          title = 'SIGN IN';
        });
      } else {
        _animationController.reverse();
        setState(() {
          isExpanded = !isExpanded;
          title = 'SIGN UP';
        });
      }
    }
  }

  Widget _animationSignUp() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (BuildContext context, Widget? child) {
        if (!isExpanded) {
          return ExpandedSignUp(
            height: size.height * .05,
            epandedSignup: handleClickSignUp,
          );
        }
        return SignUpPage(
          containerSize: size.height * .8,
          goLogin: handleClickSignUp,
        );
      },
    );
  }

  void _onPressed() async {
    final index = (_controller.offset / size.width).round() + 1;
    currentIndex = index % 2;
    setState(() {
      if (currentIndex == 0) {
        label = 'TOPIC';
      } else {
        label = 'SIGN IN';
      }
    });
    await _controller.animateToPage(index % 2,
        duration: duration, curve: Curves.easeInOutCubic);
  }
}
