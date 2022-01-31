import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/int_x.dart';
import 'package:education_helper/views/widgets/form/custom_date_picker_search.dart';
import 'package:education_helper/views/widgets/form/custom_multi_text_field.dart';
import 'package:education_helper/views/widgets/form/custom_time_field.dart';
import 'package:flutter/material.dart';

class TopicInfo extends StatefulWidget {
  final void Function(String note) onChangeNote;
  final void Function(DateTime date) onChangeDate;
  final void Function(String hours) onChangeHours;
  final void Function(String minutes) onChangeMinutes;
  final int hours;
  final int minutes;
  final DateTime? date;

  const TopicInfo({
    required this.onChangeNote,
    required this.onChangeDate,
    required this.onChangeHours,
    required this.onChangeMinutes,
    Key? key,
    this.hours = 12,
    this.minutes = 0,
    this.date,
  }) : super(key: key);

  @override
  State<TopicInfo> createState() => _TopicInfoState();
}

class _TopicInfoState extends State<TopicInfo> {
  final _controller = KDatePickerSearchController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  BoxShadow get shadow {
    return BoxShadow(
      color: kBlackColor.withOpacity(.8),
      offset: const Offset(-5.0, 5.0),
      blurRadius: 10.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 15.0,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(40.0),
        ),
        boxShadow: [shadow],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          KDatePickerSearch(
            controller: _controller,
            minDate: DateTime.now(),
            hintText: 'Expired',
            formatDate: 'dd/MM/yyyy',
            onChange: _onDatePicker,
          ),
          SPACING.S.vertical,
          Flexible(
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Time: ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  KTimeField(
                    intiMinute: widget.minutes.str,
                    initHour: widget.hours.str,
                    onChangeHours: widget.onChangeHours,
                    onChangeMinutes: widget.onChangeMinutes,
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            child: KMultiTextField(
              labelText: 'Note: ',
              onChange: widget.onChangeNote,
            ),
          )
        ],
      ),
    );
  }

  void _onDatePicker(String date) {
    final expired = DateTime.tryParse(date);
    if (expired != null) widget.onChangeDate(expired);
  }
}
