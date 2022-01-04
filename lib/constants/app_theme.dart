import 'package:education_helper/constants/typing.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

class AppTheme {
  AppTheme._();
  ColorScheme scheme({
    required Color backgroundColor,
    required Color onBack,
    required Brightness brightness,
  }) =>
      ColorScheme(
        primary: kPrimaryColor,
        primaryVariant: kPrimaryDarkColor,
        secondary: kSecondaryColor,
        secondaryVariant: kSecondaryDarkColor,
        surface: kPlaceholderDarkColor,
        background: backgroundColor,
        error: kErrorColor,
        onPrimary: kWhiteColor,
        onSecondary: kBlackColor,
        onSurface: kPlaceholderColor,
        onBackground: onBack,
        onError: kErrorColor.withOpacity(.7),
        brightness: brightness,
      );

  final ThemeData defaultTheme = ThemeData(
    hintColor: kPlaceholderColor,
    focusColor: kSecondaryColor,
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: kPrimaryColor,
        textStyle: TextStyle(
          fontSize: SPACING.M.size,
          fontWeight: FontWeight.bold,
        ), // button text color
      ),
    ),
  );

  static TextTheme defaultFonts(BuildContext context) {
    return GoogleFonts.robotoTextTheme(Theme.of(context).textTheme).copyWith(
        headline1: GoogleFonts.architectsDaughter(
            fontWeight: FontWeight.bold, fontSize: 54.0),
        headline6: GoogleFonts.architectsDaughter(
            fontWeight: FontWeight.bold, fontSize: 36.0));
  }

  static final AppTheme theme = AppTheme._();

  static ThemeData lightTheme(context) {
    return theme.defaultTheme.copyWith(
      colorScheme: theme.scheme(
        backgroundColor: kWhiteColor,
        brightness: Brightness.dark,
        onBack: kBlackColor,
      ),
      dialogBackgroundColor: kWhiteColor,
      scaffoldBackgroundColor: kWhiteColor,
      backgroundColor: kWhiteColor,
      hintColor: kPlaceholderDarkColor,
      dividerColor: kDividerColor,
      iconTheme: Theme.of(context).iconTheme.copyWith(color: kBlackColor),
      textTheme: defaultFonts(context).apply(
        bodyColor: kBlackColor,
        displayColor: kBlackColor,
      ),
    );
  }

  static ThemeData darkTheme(context) {
    return theme.defaultTheme.copyWith(
      colorScheme: theme.scheme(
        backgroundColor: kBlackColor,
        brightness: Brightness.light,
        onBack: kWhiteColor,
      ),
      dialogBackgroundColor: kBlackColor,
      scaffoldBackgroundColor: kBlackColor,
      backgroundColor: kBlackColor,
      hintColor: kPlaceholderColor,
      dividerColor: kDividerColor,
      iconTheme: Theme.of(context).iconTheme.copyWith(color: kBlackColor),
      textTheme: defaultFonts(context).apply(
        bodyColor: kWhiteColor,
        displayColor: kWhiteColor,
      ),
    );
  }
}
