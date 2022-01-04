// ignore_for_file: constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const normalStyle = TextStyle(fontWeight: FontWeight.normal, fontSize: 16.0);

const headerStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0);

const titleStyle = TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold);

enum SPACING {
  /// S:  8.0
  S,

  /// SM: 12.0
  SM,

  /// M:  16.0
  M,

  /// LG: 24.0
  LG,

  /// XL: 32.0
  XL,

  /// XXL: 40.0
  XXL,
}

extension SPACINGX on SPACING {
  double get size {
    switch (this) {
      case SPACING.S:
        return 8.0;
      case SPACING.SM:
        return 12.0;
      case SPACING.M:
        return 16.0;
      case SPACING.LG:
        return 24.0;
      case SPACING.XL:
        return 32.0;
      case SPACING.XXL:
        return 40.0;
    }
  }

  SizedBox get vertical {
    switch (this) {
      case SPACING.S:
        return const SizedBox(height: 8.0);
      case SPACING.SM:
        return const SizedBox(height: 12.0);
      case SPACING.M:
        return const SizedBox(height: 16.0);
      case SPACING.LG:
        return const SizedBox(height: 24.0);
      case SPACING.XL:
        return const SizedBox(height: 32.0);
      case SPACING.XXL:
        return const SizedBox(height: 40.0);
    }
  }

  SizedBox get horizontal {
    switch (this) {
      case SPACING.S:
        return const SizedBox(width: 8.0);
      case SPACING.SM:
        return const SizedBox(width: 12.0);
      case SPACING.M:
        return const SizedBox(width: 16.0);
      case SPACING.LG:
        return const SizedBox(width: 24.0);
      case SPACING.XL:
        return const SizedBox(width: 32.0);
      case SPACING.XXL:
        return const SizedBox(width: 40.0);
    }
  }
}
