import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:flutter/material.dart';

class ExamImage extends StatelessWidget {
  final String public;
  final String name;
  const ExamImage({
    required this.public,
    required this.name,
    Key? key,
  }) : super(key: key);

  Color get color {
    switch (name.split('/').first.toUpperCase()) {
      case 'PDF':
        return Colors.red;
      case 'RAR':
        return const Color(0xFF16772b);
      case 'ZIP':
        return const Color(0xFF3b3da3);
      default:
        return kPrimaryDarkColor;
    }
  }

  String get getExts {
    final exts = name.split('/').first.toUpperCase();
    return exts.contains('IMAGE') ? 'IMG' : exts;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.0,
      width: 100.0,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(30.0)),
        child: Container(
          color: color,
          alignment: Alignment.center,
          child: Text(
            getExts,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: SPACING.XL.size,
            ),
          ),
        ),
      ),
    );
  }
}
