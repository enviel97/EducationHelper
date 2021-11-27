import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension BuildContextX on BuildContext {
  // get size
  Size get mediaSize => MediaQuery.of(this).size;

  // get theme style
  bool get isLightTheme =>
      MediaQuery.of(this).platformBrightness == Brightness.light;

  // styles
  TextTheme get getTextStyle => Theme.of(this).textTheme;

  // navigator
  Route _route(Widget nextScreens) =>
      MaterialPageRoute(builder: (_) => nextScreens);

  goTo(Widget nextScreens) => Navigator.of(this).push(_route(nextScreens));

  goBack() => Navigator.of(this, rootNavigator: true).pop();

  replace(Widget nextScreens, {Map<String, dynamic>? arguments}) =>
      Navigator.of(this)
          .pushReplacement(_route(nextScreens), result: arguments);

  Future<void> disableKeyBoard() async {
    final scope = FocusScope.of(this);
    if (scope.hasFocus) {
      scope.requestFocus(FocusNode());
    }
  }

  Color colorWithBackground({bool? isDarkBackground}) {
    final bool backgroundIsDark = isDarkBackground ?? !isLightTheme;
    return backgroundIsDark ? Colors.white : Colors.black;
  }
}
