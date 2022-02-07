import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/constant.dart';
import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:education_helper/helpers/extensions/state.x.dart';
import 'package:education_helper/roots/bloc/app_bloc.dart';
import 'package:education_helper/views/answer/bloc/answer_bloc.dart';
import 'package:education_helper/views/answer/bloc/answer_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'pages/answers_content.dart';
import 'pages/answers_grade.dart';

class AnswerGrade extends StatefulWidget {
  final String id;

  const AnswerGrade({
    required this.id,
    Key? key,
  }) : super(key: key);

  @override
  State<AnswerGrade> createState() => _AnswerGradeState();
}

class _AnswerGradeState extends State<AnswerGrade> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AnswerBloc>(context).getAnswer(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: context.disableKeyBoard,
        child: BlocListener<AnswerBloc, AnswerState>(
          listener: (context, state) {
            if (state is AnswerFailure || state is AnswerGradeFailure) {
              try {
                final error = state.props[0] as Messenger;
                BlocProvider.of<AppBloc>(context)
                    .showError(context, error.mess);
              } catch (e) {
                BlocProvider.of<AppBloc>(context).showError(
                  context,
                  'Error system',
                );
              }
            }
          },
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
      ),
    );
  }

  void _goBack() {
    Navigator.maybePop(context);
  }
}
