import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:flutter/material.dart';

class KToast extends StatelessWidget {
  final String error;
  const KToast({Key? key, required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return error.isEmpty
        ? const SizedBox.shrink()
        : Container(
            width: double.infinity,
            height: SPACING.LG.size,
            alignment: Alignment.center,
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                color: kErrorColor,
                borderRadius: const BorderRadius.all(Radius.circular(40.0)),
                boxShadow: [
                  BoxShadow(
                    color: kPrimaryColor.withOpacity(.6),
                    offset: const Offset(4.0, 4.0),
                    blurRadius: 4.0,
                  )
                ]),
            child: Text(
              'errortext',
              style: TextStyle(
                color: kWhiteColor,
                fontSize: SPACING.LG.size,
              ),
            ),
          );
  }
}
