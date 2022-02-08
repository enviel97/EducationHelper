import 'package:education_helper/models/exam.model.dart';
import 'package:education_helper/views/answer/answer_grade/widgets/answers_show_file/answers_show_file.dart';
import 'package:education_helper/views/answer/bloc/answer_bloc.dart';
import 'package:education_helper/views/answer/bloc/answer_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnswersContent extends StatefulWidget {
  const AnswersContent({Key? key}) : super(key: key);

  @override
  State<AnswersContent> createState() => _AnswersContentState();
}

class _AnswersContentState extends State<AnswersContent> {
  Content? content;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(25.0),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(25.0),
        ),
        child: BlocListener<AnswerBloc, AnswerState>(
          listener: (context, state) {
            if (state is AnswerLoaded) {
              setState(() => content = state.answer.content);
            }
          },
          child: content == null
              ? const Center(child: CircularProgressIndicator())
              : AnswersShowFile(content: content!.name),
        ),
      ),
    );
  }
}
