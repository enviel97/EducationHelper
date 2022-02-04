import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/views/topic/typings/color_schema.dart';
import 'package:flutter/material.dart';

import '../../../topics.dart';

class OpenExamButton extends StatelessWidget {
  final String type;
  final String id;
  final double size;
  final bool disable;

  const OpenExamButton({
    required this.type,
    required this.id,
    this.size = 60.0,
    Key? key,
    this.disable = false,
  }) : super(key: key);

  ColorSchema get colorSchema => ColorSchema.industry(type);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => disable ? null : _goToDetail(context),
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          color:
              disable ? colorSchema.color.withOpacity(0.5) : colorSchema.color,
          border: Border.all(color: colorSchema.light, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(size * 0.2)),
        ),
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            type.isEmpty
                ? const CircularProgressIndicator()
                : Text(
                    '.$type',
                    style: TextStyle(
                      color: kWhiteColor,
                      fontSize: size * .3,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Future<void> _goToDetail(BuildContext context) async {
    Topics.adapter.gotoExam(context, id);
  }
}
