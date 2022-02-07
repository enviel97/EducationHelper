import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/ultils/funtions.dart';
import 'package:flutter/material.dart';

class FileErrorNotification extends StatelessWidget {
  final String mess;

  const FileErrorNotification({
    Key? key,
    this.mess = 'FILE NOT FOUND',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          ImageFromLocal.asPng('file_not_found'),
          fit: BoxFit.cover,
        ),
        Text(
          mess,
          style: TextStyle(
            fontSize: SPACING.LG.size,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
