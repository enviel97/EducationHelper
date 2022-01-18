import 'package:education_helper/constants/typing.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

class AppTheme {
  AppTheme._();
  static final AppTheme theme = AppTheme._();
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
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: kPrimaryColor,
      selectionColor: kPrimaryColor.withOpacity(.7),
      selectionHandleColor: kPrimaryColor.withOpacity(.7),
    ),
  );

  AppBarTheme get _appBarTheme => AppBarTheme(
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: SPACING.LG.size,
          fontWeight: FontWeight.bold,
          color: kWhiteColor,
        ),
        elevation: 0.0,
        shadowColor: Colors.transparent,
        iconTheme: const IconThemeData(color: kWhiteColor),
        shape: const RoundedRectangleBorder(
            borderRadius:
                BorderRadius.only(bottomRight: Radius.circular(25.0))),
      );

  static TextTheme defaultFonts(BuildContext context) {
    return GoogleFonts.robotoTextTheme(Theme.of(context).textTheme);
  }

  static ThemeData lightTheme(context) {
    return theme.defaultTheme.copyWith(
      colorScheme: theme.scheme(
        backgroundColor: kWhiteColor,
        brightness: Brightness.light,
        onBack: kBlackColor,
      ),
      dialogBackgroundColor: kBlackColor,
      scaffoldBackgroundColor: kWhiteColor,
      backgroundColor: kWhiteColor,
      hintColor: kPlaceholderDarkColor,
      dividerColor: kDividerColor,
      iconTheme: Theme.of(context).iconTheme.copyWith(color: kBlackColor),
      textTheme: defaultFonts(context).apply(
        bodyColor: kBlackColor,
        displayColor: kBlackColor,
      ),
      appBarTheme: theme._appBarTheme.copyWith(
        backgroundColor: kPrimaryLightColor,
      ),
      cardColor: kWhiteColor,
    );
  }

  static ThemeData darkTheme(context) {
    return theme.defaultTheme.copyWith(
      colorScheme: theme.scheme(
        backgroundColor: kBlackColor,
        brightness: Brightness.dark,
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
      selectedRowColor: kBlackColor,
      appBarTheme: theme._appBarTheme.copyWith(
        backgroundColor: kPrimaryColor,
      ),
      cardColor: kBlackColor,
    );
  }
}
