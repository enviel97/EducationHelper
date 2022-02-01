import 'dart:io';

import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:flutter/material.dart';

class ExamImage extends StatelessWidget {
  final File file;
  const ExamImage({
    required this.file,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: InteractiveViewer(
        child: Image.file(
          file,
          width: context.mediaSize.width,
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}
