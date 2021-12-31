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
    final widthScreens = context.mediaSize.width;
    const heightDecorate = 230.0;
    return Container(
      width: widthScreens * .6,
      height: heightDecorate,
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage(ImageFromLocal.asPng('header_decorate')),
        fit: BoxFit.fill,
      )),
      padding: const EdgeInsets.only(top: heightDecorate / 3, left: 20.0),
      child: Text(title, style: titleStyle),
    );
  }
}
