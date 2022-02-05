import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:education_helper/helpers/extensions/int_x.dart';
import 'package:education_helper/views/widgets/button/custom_text_button.dart';
import 'package:education_helper/views/widgets/form/custom_date_picker_search.dart';
import 'package:education_helper/views/widgets/form/custom_multi_text_field.dart';
import 'package:education_helper/views/widgets/form/custom_time_field.dart';
import 'package:flutter/material.dart';

class TopicEditForm extends StatefulWidget {
  final DateTime expired;
  final String note;
  const TopicEditForm({
    required this.expired,
    required this.note,
    Key? key,
  }) : super(key: key);

  @override
  State<TopicEditForm> createState() => _TopicEditFormState();
}

class _TopicEditFormState extends State<TopicEditForm> {
  final _controller = KDatePickerSearchController();
  late DateTime expired;
  String hours = '';
  String minutes = '';
  String note = '';

  @override
  void initState() {
    super.initState();
    expired = widget.expired;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    return Padding(
      padding: media.viewInsets,
      child: Container(
        height: context.mediaSize.height * 0.4,
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                'Edit: ',
                style: TextStyle(
                  color: kBlackColor,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              _topicInfo,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  KTextButton(
                    width: 150.0,
                    onPressed: _confirm,
                    text: 'Edit',
                  ),
                  KTextButton(
                    width: 150.0,
                    onPressed: Navigator.of(context).pop,
                    text: 'Cancel',
                    backgroudColor: kWhiteColor,
                    isOutline: true,
                  )
                ],
              ),
            ]),
      ),
    );
  }

  Widget get _topicInfo {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        KDatePickerSearch(
          controller: _controller,
          initDate: widget.expired,
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
                  intiMinute: expired.minute.str,
                  initHour: expired.hour.str,
                  onChangeHours: (hour) => hours = hour,
                  onChangeMinutes: (minute) => minutes = minute,
                ),
              ],
            ),
          ),
        ),
        Flexible(
          child: KMultiTextField(
            labelText: 'Note: ',
            initValue: widget.note,
            onChange: (note) => this.note = note,
          ),
        )
      ],
    );
  }

  void _onDatePicker(String date) {
    final expired = DateTime.tryParse(date);
    if (expired != null) this.expired = expired;
  }

  void _confirm() {
    final date = DateTime.utc(
      expired.year,
      expired.month,
      expired.day,
      int.tryParse(hours) ?? expired.hour,
      int.tryParse(minutes) ?? expired.minute,
    );

    Navigator.of(context).pop({
      'expiredDate': date.isAtSameMomentAs(widget.expired) ? null : date,
      'note': note,
    });
  }
}
