import 'dart:ui';

import 'package:education_helper/constants/colors.dart';

class ColorSchema {
  final Color dark;
  final Color light;
  final Color color;

  const ColorSchema(
    this.color, {
    this.dark = kNone,
    this.light = kNone,
  });

  factory ColorSchema.industry(String type) {
    if (type.isEmpty) {
      return const ColorSchema(
        kPlaceholderDarkColor,
        light: kPlaceholderLightColor,
        dark: kPlacehoderSuperDarkColor,
      );
    }

    switch (type.toUpperCase()) {
      case 'PDF':
        return ColorSchema.pdf();
      case 'RAR':
        return ColorSchema.rar();
      case 'ZIP':
        return ColorSchema.zip();
      default:
        return ColorSchema.image();
    }
  }

  List<Color> get gradient => [color, color, light];

  factory ColorSchema.pdf() {
    return const ColorSchema(
      Color(0xFFF20000),
      dark: Color(0xFFa90000),
      light: Color(0xFFff6666),
    );
  }

  factory ColorSchema.rar() {
    return const ColorSchema(
      Color(0xFF16772b),
      dark: Color(0xFF0b3414),
      light: Color(0xFF25c347),
    );
  }

  factory ColorSchema.zip() {
    return const ColorSchema(
      Color(0xFF3b3da3),
      dark: Color(0xFF232463),
      light: Color(0xFF5558ff),
    );
  }

  factory ColorSchema.image() {
    return const ColorSchema(
      kPrimaryColor,
      dark: kPrimaryDarkColor,
      light: kPrimaryLightColor,
    );
  }
}
