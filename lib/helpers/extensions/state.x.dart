import 'package:flutter/material.dart';

extension StateX on State {
  Size get size => MediaQuery.of(context).size;
  EdgeInsets get inset => MediaQuery.of(context).viewInsets;
  bool get isLightTheme =>
      MediaQuery.of(context).platformBrightness == Brightness.light;
}
