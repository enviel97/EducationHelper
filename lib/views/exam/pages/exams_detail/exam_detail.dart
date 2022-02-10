import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/state.x.dart';
import 'package:education_helper/models/exam.model.dart';
import 'package:education_helper/roots/bloc/app_bloc.dart';
import 'package:education_helper/views/exam/bloc/exam_bloc.dart';
import 'package:education_helper/views/exam/bloc/exam_state.dart';
import 'package:education_helper/views/exam/pages/exams_detail/widgets/exam_appbar_bottom.dart';
import 'package:education_helper/views/widgets/header/appbar_bottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/exam_detail_content.dart';

class ExamDetail extends StatefulWidget {
  final String id;
  const ExamDetail({
    required this.id,
    Key? key,
  }) : super(key: key);

  @override
  _ExamDetailState createState() => _ExamDetailState();
}

class _ExamDetailState extends State<ExamDetail> {
  double process = 0.0;
  late String path;
  String originName = '';
  String download = '';
  String public = '';

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ExamBloc>(context).getOnce(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Topic detail'),
        bottom: AppbarBottom(
          height: 105,
          child: ExamAppbarBottom(
            name: originName,
            downloadLink: download,
            publicLink: public,
          ),
        ),
      ),
      body: BlocConsumer<ExamBloc, ExamState>(
        listener: (context, state) {
          if (state is ExamGetState) {
            setState(() {
              originName = state.exam.content.originName;
              download = state.exam.content.download;
              public = state.exam.content.public;
            });
          }

          if (state is ExamFailureState) {
            BlocProvider.of<AppBloc>(context)
                .showError(context, state.error.mess);
          }
        },
        builder: (context, state) {
          if (state is ExamGetState) {
            return _builderFile(state.exam);
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget _builderFile(Exam exam) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Subject:',
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: SPACING.M.size,
                          fontWeight: FontWeight.bold)),
                  Text(exam.subject,
                      maxLines: 1,
                      style: TextStyle(
                          color: isLightTheme ? kPrimaryColor : kSecondaryColor,
                          fontSize: SPACING.M.size * 1.2,
                          fontWeight: FontWeight.bold))
                ])),
        Expanded(child: ExamDetailContent(content: exam.content)),
      ],
    );
  }
}
