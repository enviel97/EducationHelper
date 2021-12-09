import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:education_helper/helpers/extensions/state.x.dart';
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
  final duration = const Duration(microseconds: 250);

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
    final color = isLightTheme ? kBlackColor : kWhiteColor;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GestureDetector(
        onTap: context.disableKeyBoard,
        child: LayoutBuilder(builder: (_, __) {
          return TweenAnimationBuilder(
            duration: const Duration(milliseconds: 5500),
            tween: Tween(begin: 0.0, end: 1.0),
            builder: (BuildContext context, double value, Widget? child) {
              return ShaderMask(
                blendMode: BlendMode.modulate,
                shaderCallback: (rect) {
                  return RadialGradient(
                    radius: value * 5,
                    colors: [color, color, color, kNone, kNone, kNone],
                    stops: [.0, .2, .4, .6, .8, 1],
                    center: const FractionalOffset(.5, .5),
                  ).createShader(rect);
                },
                child: child,
              );
            },
            child: Stack(children: [
              const DecorateHeader(),
              const SignInPage(),
              _animationSignUp()
            ]),
          );
        }),
      ),
    );
  }

  Widget _animationSignUp() {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget? child) {
        if (!isExpanded) {
          return ExpandedSignUp(
            height: size.height * .05,
            epandedSignup: () {
              context.disableKeyBoard();
              if (mounted) {
                animationController.forward();
                setState(() => isExpanded = !isExpanded);
              }
            },
          );
        }
        return SignUpPage(
          containerSize: size.height * .8,
          goLogin: () {
            context.disableKeyBoard();
            animationController.reverse();
            setState(() => isExpanded = !isExpanded);
          },
        );
      },
    );
  }
}
