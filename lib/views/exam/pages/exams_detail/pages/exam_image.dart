import 'dart:io';

import 'package:education_helper/helpers/extensions/state.x.dart';
import 'package:flutter/material.dart';

class ExamImage extends StatefulWidget {
  final File file;

  const ExamImage({
    required this.file,
    Key? key,
  }) : super(key: key);

  @override
  _ExamImageState createState() => _ExamImageState();
}

class _ExamImageState extends State<ExamImage> {
  late File file;
  @override
  void initState() {
    super.initState();
    file = widget.file;
    debugPrint(file.toString());
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: InteractiveViewer(
        child: Image.file(
          file,
          width: size.width,
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}
