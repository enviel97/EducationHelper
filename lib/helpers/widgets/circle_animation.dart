// ignore_for_file: non_constant_identifier_names

import 'package:education_helper/constants/colors.dart';
import 'package:flutter/material.dart';

PageRouteBuilder AnimationCircleSource(Widget secondScreen) => PageRouteBuilder(
    pageBuilder: (context, _, __) => secondScreen, opaque: false);

LayoutBuilder AnimationCircleLayout({required Widget child}) =>
    LayoutBuilder(builder: (context, __) {
      return TweenAnimationBuilder(
        duration: const Duration(milliseconds: 3500),
        tween: Tween(begin: 0.0, end: 1.0),
        builder: (BuildContext context, double value, Widget? currentChild) {
          return ShaderMask(
            blendMode: BlendMode.modulate,
            shaderCallback: (rect) {
              return RadialGradient(
                radius: value * 5,
                colors: [kWhiteColor, kWhiteColor, kNone],
                stops: [.0, .65, .99],
                center: const FractionalOffset(.5, .5),
              ).createShader(rect);
            },
            child: currentChild,
          );
        },
        child: child,
      );
    });
