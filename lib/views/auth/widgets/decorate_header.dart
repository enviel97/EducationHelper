import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:education_helper/helpers/ultils/funtions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DecorateHeader extends StatelessWidget {
  final String title;
  const DecorateHeader({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = context.mediaSize.width * .5;
    return Container(
      width: width,
      height: width,
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage(ImageFromLocal.asPng('header_decorate')),
        fit: BoxFit.fill,
      )),
      padding: const EdgeInsets.only(left: 10.0),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Text(title, style: titleStyle.copyWith(color: kWhiteColor)),
        ),
      ),
    );
  }
}
