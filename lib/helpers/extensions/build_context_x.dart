import 'package:education_helper/helpers/widgets/router_animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension BuildContextX on BuildContext {
  // get size
  Size get mediaSize => MediaQuery.of(this).size;

  // get theme style
  bool get isLightTheme =>
      MediaQuery.of(this).platformBrightness == Brightness.light;

  Color get backgroundColor => Theme.of(this).backgroundColor;
  // styles
  TextTheme get getTextStyle => Theme.of(this).textTheme;

  // navigator
  Route _route(Widget nextScreens) =>
      MaterialPageRoute(builder: (_) => nextScreens);

  goTo(Widget nextScreens) => Navigator.of(this).push(_route(nextScreens));

  goBack() => Navigator.of(this, rootNavigator: true).pop();

  replace(Widget nextScreens, {Map<String, dynamic>? arguments}) {
    return Navigator.of(this).pushReplacement(
        RouterAnimation(child: nextScreens),
        result: arguments);
  }

  Future<void> disableKeyBoard() async {
    final currentFocus = FocusScope.of(this);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  Color colorWithBackground({bool? isDarkBackground}) {
    final bool backgroundIsDark = isDarkBackground ?? !isLightTheme;
    return backgroundIsDark ? Colors.white : Colors.black;
  }
}
