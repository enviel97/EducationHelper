import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final transparentStatusBar =
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  statusBarColor: Colors.transparent,
));

// ignore: prefer_function_declarations_over_variables, non_constant_identifier_names
final CircleDecoration =
    ({Color color = const Color(0xFF000000)}) => BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        );
