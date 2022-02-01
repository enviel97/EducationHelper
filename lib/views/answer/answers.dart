import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:education_helper/helpers/extensions/state.x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'pages/answers_grade.dart';
import 'pages/answers_content.dart';

class Answers extends StatefulWidget {
  final String id;

  const Answers({
    required this.id,
    Key? key,
  }) : super(key: key);

  @override
  State<Answers> createState() => _AnswersState();
}

class _AnswersState extends State<Answers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: context.disableKeyBoard,
        child: Container(
          color: kBlackColor,
          child: Stack(
            children: [
              const Align(
                heightFactor: .8,
                child: AnswersContent(),
              ),
              SafeArea(
                child: IconButton(
                  iconSize: 32.0,
                  padding: const EdgeInsets.only(left: 20.0),
                  icon: Icon(
                    Ionicons.ios_chevron_back_circle,
                    color: isLightTheme ? kPrimaryDarkColor : kPrimaryColor,
                  ),
                  onPressed: _goBack,
                ),
              ),
              const Align(
                alignment: Alignment.bottomCenter,
                child: AnswersGrade(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _goBack() {
    Navigator.maybePop(context);
  }
}
