import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:education_helper/helpers/extensions/state.x.dart';
import 'package:education_helper/helpers/widgets/circle_animation.dart';
import 'package:education_helper/views/auth/pages/siginin.dart';
import 'package:education_helper/views/auth/pages/signup.dart';
import 'package:flutter/material.dart';

import 'widgets/decorate_header.dart';
import 'widgets/expanded_signup.dart';

class Auth extends StatefulWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  _Auth createState() => _Auth();
}

class _Auth extends State<Auth> with SingleTickerProviderStateMixin {
  late bool isExpanded;
  late AnimationController animationController;
  late String title = 'SIGN IN';
  final duration = const Duration(microseconds: 500);

  @override
  void initState() {
    super.initState();
    isExpanded = false;
    animationController = AnimationController(vsync: this, duration: duration);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: context.disableKeyBoard,
        child: AnimationCircleLayout(
          child: Stack(children: [
            const SignInPage(),
            _animationSignUp(),
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
        animationController.forward();
        setState(() {
          isExpanded = !isExpanded;
          title = 'SIGN IN';
        });
      } else {
        animationController.reverse();
        setState(() {
          isExpanded = !isExpanded;
          title = 'SIGN UP';
        });
      }
    }
  }

  Widget _animationSignUp() {
    return AnimatedBuilder(
      animation: animationController,
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
}
