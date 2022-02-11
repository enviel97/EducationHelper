import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:education_helper/helpers/extensions/datetime_x.dart';
import 'package:education_helper/models/exam.model.dart';
import 'package:education_helper/roots/bloc/app_bloc.dart';
import 'package:education_helper/views/topic/blocs/member/topic_members_bloc.dart';
import 'package:education_helper/views/topic/blocs/topic/topic_bloc.dart';
import 'package:education_helper/views/topic/blocs/topic/topic_state.dart';
import 'package:education_helper/views/topic/pages/topic_detail/widgets/open_exam_button.dart';
import 'package:education_helper/views/topic/pages/topic_form/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopicExamInfo extends StatefulWidget {
  final String id;
  const TopicExamInfo({
    required this.id,
    Key? key,
  }) : super(key: key);

  @override
  State<TopicExamInfo> createState() => _TopicExamInfoState();
}

class _TopicExamInfoState extends State<TopicExamInfo> {
  int quantityRecored = 0;
  String note = '';
  DateTime? createAt, expiredAt;
  String classname = '';
  Exam? exam;

  String dateToString(DateTime? date) =>
      date?.toStringFormat(format: 'MMM dd,yyyy  -  hh:mm') ?? 'Loading...';

  @override
  Widget build(BuildContext context) {
    final highlightColor =
        context.isLightTheme ? kSecondaryDarkColor : kSecondaryLightColor;
    return BlocConsumer<TopicBloc, TopicState>(
      listener: (context, state) {
        if (state is TopicLoaded) {
          setState(() {
            createAt = state.topic.createDate;
            expiredAt = state.topic.expiredDate;
            classname = state.topic.classroom.name;
            note = state.topic.note ?? '';
            exam = state.topic.exam;
          });
          BlocProvider.of<TopicMembersBloc>(context).getMembers(state.topic.id);
        }
        if (state is TopicFailure) {
          if (quantityRecored < 10) {
            Future.delayed(const Duration(milliseconds: 200),
                () => BlocProvider.of<TopicBloc>(context).getOnce(widget.id));
            setState(() => quantityRecored += 1);
            BlocProvider.of<AppBloc>(context)
                .showNotice(context, 'Loading fail, reload');
          } else {
            BlocProvider.of<AppBloc>(context)
                .showError(context, state.error.mess);
          }
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildContent(
                color: highlightColor,
                classname: classname,
                exam: exam,
              ),
              SPACING.S.vertical,
              KText(
                  text: dateToString(createAt),
                  colorText: highlightColor,
                  label: 'Create date',
                  colorLabel: context.isLightTheme ? kBlackColor : kWhiteColor,
                  sizeLabel: SPACING.M.size),
              SPACING.S.vertical,
              KText(
                text: dateToString(expiredAt),
                colorText: highlightColor,
                label: 'Expired date',
                colorLabel: context.isLightTheme ? kBlackColor : kWhiteColor,
                sizeLabel: SPACING.M.size,
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildContent({
    required Color color,
    String classname = '',
    Exam? exam,
  }) {
    return Flexible(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    classname,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: SPACING.M.size * 1.2,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    exam?.name ?? 'Loading...',
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    style: TextStyle(
                        color: color,
                        fontSize: SPACING.LG.size,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  'Subject: '
                  '${exam?.subject ?? 'Loading...'}',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: SPACING.M.size),
                )
              ],
            ),
          ),
          OpenExamButton(
            disable: exam == null,
            type: exam?.type ?? '',
            id: exam?.id ?? '',
          ),
          note.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.sticky_note_2),
                  onPressed: () {
                    const radius = BorderRadius.only(
                      topLeft: Radius.circular(25.0),
                      topRight: Radius.circular(25.0),
                    );
                    showModalBottomSheet(
                      elevation: 20.0,
                      context: context,
                      shape: const RoundedRectangleBorder(borderRadius: radius),
                      builder: (builder) {
                        return Container(
                          decoration: const BoxDecoration(borderRadius: radius),
                          padding: const EdgeInsets.only(
                              top: 20.0, left: 15.0, right: 15.0, bottom: 10.0),
                          child: Wrap(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Note:',
                                    style: TextStyle(
                                        color: kPrimaryColor,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Expanded(
                                    child: Text(
                                      note,
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: kBlackColor,
                                        fontSize: SPACING.M.size * 1.2,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
