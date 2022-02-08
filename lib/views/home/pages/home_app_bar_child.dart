import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/datetime_x.dart';
import 'package:education_helper/helpers/extensions/state.x.dart';
import 'package:education_helper/models/user.model.dart';
import 'package:education_helper/roots/bloc/app_bloc.dart';
import 'package:education_helper/roots/bloc/app_state.dart';
import 'package:education_helper/views/home/widgets/date_horizantal/date_picker_timeline.dart';
import 'package:education_helper/views/widgets/button/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../home.dart';

class HomeAppBarChild extends StatefulWidget {
  const HomeAppBarChild({Key? key}) : super(key: key);

  @override
  State<HomeAppBarChild> createState() => _HomeAppBarChildState();
}

class _HomeAppBarChildState extends State<HomeAppBarChild> {
  late DatePickerTimelineControler dtControll;
  List<DateTime> expiredDate = [];
  DateTime date = DateTime.now();
  List<ExamHome> examMap = [];

  @override
  void initState() {
    super.initState();
    dtControll = DatePickerTimelineControler();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Wrap(
          alignment: WrapAlignment.end,
          children: [
            SizedBox(
              width: 85.0,
              child: KIconButton(
                icon: const Icon(Icons.calendar_today, size: 20.0),
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                onPressed: () => dtControll.animateToDate(DateTime.now()),
                text: 'Now',
              ),
            ),
            SizedBox(
              width: 60.0,
              child: KIconButton(
                isDisable: DateTimeX.compare(date, DateTime.now()),
                icon: const Icon(MaterialCommunityIcons.check, size: 20.0),
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                onPressed: () => dtControll.animateToSelection(),
              ),
            ),
          ],
        ),
        BlocListener<AppBloc, AppState>(
          listener: (context, state) {
            if (state is UserStateSuccess) {
              setState(() {
                final _state = state.user;
                expiredDate = [..._state.exams.map((e) => e.expiredDate)];
                examMap = _state.exams;
              });
            }
          },
          child: DatePickerTimeLine(
            controler: dtControll,
            onDateChange: _onDateChanage,
            note: expiredDate,
            initialSelectedDate: DateTime.now(),
            startDate: DateTime.now().subtract(const Duration(days: 7)),
          ),
        ),
        SPACING.S.vertical,
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Wrap(
            children: examMap
                .where((exam) => DateTimeX.compare(date, exam.expiredDate))
                .map(_buildChip)
                .toList(),
          ),
        ),
      ],
    );
  }

  void _onDateChanage(DateTime selectedDate) {
    dtControll.animateToDate(selectedDate);
    setState(() => date = selectedDate);
  }

  void goToTopic(String id) {
    Home.adapter.goToTopic(context, id: id);
  }

  Widget _buildChip(ExamHome e) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ActionChip(
        side: const BorderSide(color: kSecondaryLightColor),
        tooltip: 'Press to go topic',
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        labelPadding: const EdgeInsets.only(right: 5.0),
        elevation: 10.0,
        shadowColor: isLightTheme ? kBlackColor : kWhiteColor,
        backgroundColor: kPrimaryColor,
        labelStyle: const TextStyle(
          color: kWhiteColor,
          fontSize: 16.0,
        ),
        label: Text(e.name),
        onPressed: () => goToTopic(e.id),
      ),
    );
  }
}
