import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:education_helper/helpers/widgets/scroller_grow_disable.dart';
import 'package:education_helper/models/classroom.model.dart';
import 'package:education_helper/models/exam.model.dart';
import 'package:education_helper/roots/app_root.dart';
import 'package:education_helper/roots/bloc/app_bloc.dart';
import 'package:education_helper/views/topic/adapter/topic.adapter.dart';
import 'package:education_helper/views/topic/blocs/topic/topic_bloc.dart';
import 'package:education_helper/views/topic/blocs/topic/topic_state.dart';
import 'package:education_helper/views/topic/pages/topic_form/pages/topic_info.dart';
import 'package:education_helper/views/topic/pages/topic_form/pages/topic_selected_classroom.dart';
import 'package:education_helper/views/widgets/button/custom_text_button.dart';
import 'package:education_helper/views/widgets/header/appbar_bottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'pages/topic_selected_exam.dart';

class TopicForm extends StatefulWidget {
  static TopicAdapter adapter =
      Root.ins.adapter.getAdapter(topicAdapter).cast<TopicAdapter>();

  final String? id;
  final Classroom? classroom;
  final Exam? exam;
  final String? note;
  final DateTime? expired;
  const TopicForm({
    Key? key,
    this.id,
    this.classroom,
    this.exam,
    this.note,
    this.expired,
  }) : super(key: key);

  @override
  State<TopicForm> createState() => _TopicFormState();
}

class _TopicFormState extends State<TopicForm> {
  bool get isEdit => widget.id != null;
  int hours = 12, minutes = 0;
  String examId = '', classroomId = '', note = '';
  DateTime? date;

  @override
  void initState() {
    super.initState();
    examId = widget.exam?.id ?? '';
    classroomId = widget.classroom?.id ?? '';
    date = widget.expired;
    note = widget.note ?? '';
    hours = widget.expired?.hour ?? 12;
    minutes = widget.expired?.minute ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Create topic' : 'Edit topic'),
        bottom: const AppbarBottom(),
      ),
      body: BlocListener<TopicBloc, TopicState>(
        listener: (BuildContext context, state) {
          final appBloc = BlocProvider.of<AppBloc>(context);
          if (state is TopicLoading) {
            appBloc.showLoading(context, 'Create');
          }
          if (state is TopicFailure) {
            appBloc.hiddenLoading(context);
          }
          if (state is TopicChanged) {
            appBloc.hiddenLoading(context);
            Navigator.of(context).pop(true);
          }
        },
        child: NormalScroll(
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
            child: GestureDetector(
              onTap: context.disableKeyBoard,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TopicSeclectExams(
                    exam: widget.exam,
                    onSelectExam: (id) => examId = id,
                  ),
                  SPACING.M.vertical,
                  TopicSelecetedClassroom(
                    classroom: widget.classroom,
                    onSelectedClassroom: (id) => classroomId = id,
                  ),
                  SPACING.M.vertical,
                  TopicInfo(
                    hours: hours,
                    minutes: minutes,
                    date: date,
                    onChangeDate: (date) => this.date = date,
                    onChangeHours: (hours) {
                      this.hours = int.tryParse(hours) ?? this.hours;
                    },
                    onChangeMinutes: (minutes) {
                      this.minutes = int.tryParse(minutes) ?? this.minutes;
                    },
                    onChangeNote: (note) => this.note = note,
                  ),
                  SPACING.M.vertical,
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        KTextButton(
                          width: 150,
                          onPressed: _onConfirm,
                          text: 'Confirm',
                        ),
                        KTextButton(
                          width: 150,
                          onPressed: _onCancel,
                          color: kSecondaryColor,
                          isOutline: true,
                          text: 'Cancel',
                        ),
                      ],
                    ),
                  ),
                  SPACING.M.vertical,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onConfirm() {
    if (classroomId.isEmpty || examId.isEmpty || date == null) return;
    final expired =
        DateTime(date!.year, date!.month, date!.day, hours, minutes);

    BlocProvider.of<TopicBloc>(context).create(
      classroomId: classroomId,
      examId: examId,
      expiredDate: expired,
      note: note,
    );
  }

  void _onCancel() {
    Navigator.maybePop(context);
  }
}
