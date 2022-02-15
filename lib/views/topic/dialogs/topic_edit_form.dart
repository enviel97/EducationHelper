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
  DateTime? expired;
  String hours = '';
  String minutes = '';
  String note = '';
  bool datePickerOpen = false;

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
                    isDisable: expired == null &&
                        note.isEmpty &&
                        hours.isEmpty &&
                        minutes.isEmpty,
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
          prevChange: _prevChange,
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
                  intiMinute: widget.expired.minute.str,
                  initHour: widget.expired.hour.str,
                  onChangeHours: (hour) => setState(() => hours = hour),
                  onChangeMinutes: (minute) => setState(() => minutes = minute),
                ),
              ],
            ),
          ),
        ),
        Flexible(
          child: KMultiTextField(
            labelText: 'Note: ',
            hintText: widget.note,
            isDisable: datePickerOpen,
            hintStyle: TextStyle(color: kBlackColor.withOpacity(.7)),
            textStyle: const TextStyle(color: kBlackColor),
            onChange: (note) => setState(() => this.note = note),
          ),
        )
      ],
    );
  }

  void _onDatePicker(String date) {
    final expired = DateTime.tryParse(date);

    if (expired != null) {
      setState(() => this.expired = expired);
    }
  }

  void _confirm() {
    context.disableKeyBoard();
    DateTime? date;

    if (expired != null || hours.isNotEmpty || minutes.isNotEmpty) {
      date = DateTime(
        expired?.year ?? widget.expired.year,
        expired?.month ?? widget.expired.month,
        expired?.day ?? widget.expired.day,
        int.tryParse(hours) ?? expired?.hour ?? widget.expired.hour,
        int.tryParse(minutes) ?? expired?.minute ?? widget.expired.minute,
      );
    }
    Navigator.of(context).pop({
      'expiredDate': date,
      'note': note,
    });
  }

  void _prevChange(bool isOpen) {
    context.disableKeyBoard();
    setState(() => datePickerOpen = isOpen);
  }
}
