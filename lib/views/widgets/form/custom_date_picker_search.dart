import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/state.x.dart';
import 'package:education_helper/helpers/extensions/string_x.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class KDatePickerSearch extends StatefulWidget {
  final String hintText;
  final bool isClearButton;
  final String? initDate;
  final String formatDate;
  final Function(String date) onChange;
  final DateTime? minDate;
  final DateTime? maxDate;
  final KDatePickerSearchController? controller;
  const KDatePickerSearch({
    required this.hintText,
    required this.onChange,
    Key? key,
    this.isClearButton = true,
    this.initDate,
    this.formatDate = 'dd/MM/yyyy',
    this.minDate,
    this.maxDate,
    this.controller,
  }) : super(key: key);

  @override
  _KDatePickerSearchState createState() => _KDatePickerSearchState();
}

class _KDatePickerSearchState extends State<KDatePickerSearch> {
  late String value;
  DateTime? selectedDateTime;
  @override
  void initState() {
    super.initState();
    value = widget.initDate?.toDateString() ?? '';
    selectedDateTime =
        value.isEmpty ? DateTime.now() : DateTime.tryParse(value);
    if (widget.controller != null) {
      widget.controller!._setState(this);
    }
  }

  Color get iconColor => isLightTheme ? kWhiteColor : kWhiteColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _selectedDatePicker,
      child: Container(
        constraints: const BoxConstraints(minWidth: 200.0, minHeight: 48.0),
        decoration: BoxDecoration(
          color: isLightTheme ? kPrimaryDarkColor : kPrimaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(40.0)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: Icon(
                Icons.date_range_outlined,
                color: kWhiteColor,
              ),
            ),
            Expanded(
              child: Text(
                value.isEmpty ? widget.hintText : value,
                style: TextStyle(
                  color: kWhiteColor,
                  fontSize: SPACING.M.size,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: _buildClearButton(),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildClearButton() {
    if (!widget.isClearButton || value.isEmpty) {
      return const SizedBox.shrink();
    }
    return CircleAvatar(
        backgroundColor: Colors.transparent,
        child: IconButton(
          icon: const Icon(Icons.cancel_rounded),
          color: kWhiteColor,
          splashColor: kBlackColor,
          highlightColor: kBlackColor,
          onPressed: _clearValue,
        ));
  }

  Future<void> _selectedDatePicker() async {
    final picked = await showDatePicker(
        context: context,
        initialDate: selectedDateTime ?? DateTime.now(),
        firstDate: widget.minDate ?? DateTime(1700),
        lastDate: widget.maxDate ?? DateTime(2500),
        initialEntryMode: DatePickerEntryMode.calendar,
        helpText: widget.hintText,
        cancelText: 'Cancel',
        confirmText: 'Set',
        fieldHintText: widget.formatDate,
        builder: (_, __) {
          final ColorScheme colorScheme = isLightTheme
              ? const ColorScheme.light()
              : const ColorScheme.dark();
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: colorScheme,
              dialogBackgroundColor: colorScheme.background,
            ),
            child: SizedBox.shrink(child: __),
          );
        });

    if (picked != null && picked != selectedDateTime) {
      setState(() {
        selectedDateTime = picked;
        value = DateFormat(widget.formatDate).format(picked);
      });
      widget.onChange(picked.toString());
    }
  }

  void _clearValue() {
    if (mounted) {
      setState(() {
        value = '';
        selectedDateTime = null;
      });
    }
  }
}

class KDatePickerSearchController {
  _KDatePickerSearchState? _state;
  void _setState(_KDatePickerSearchState state) {
    _state = state;
  }

  void dispose() {
    if (_state != null) {
      _state = null;
    }
  }

  void clear() {
    if (_state == null) return;
    _state!._clearValue();
  }
}
