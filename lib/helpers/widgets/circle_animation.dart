// ignore_for_file: non_constant_identifier_names

import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:flutter/material.dart';

PageRouteBuilder AnimationCircleSource(Widget secondScreen) => PageRouteBuilder(
    pageBuilder: (context, _, __) => secondScreen, opaque: false);

LayoutBuilder AnimationCircleLayout({required Widget child}) =>
    LayoutBuilder(builder: (context, __) {
      final color = context.isLightTheme ? kBlackColor : kWhiteColor;
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
        child: child,
      );
    });
