import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/helpers/extensions/datetime_x.dart';
import 'package:education_helper/helpers/extensions/state.x.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class KDatePickerSearch extends StatefulWidget {
  final String hintText;
  final bool isClearButton;
  final DateTime? initDate;
  final String formatDate;
  final Function(String date) onChange;
  final DateTime? minDate;
  final DateTime? maxDate;
  final KDatePickerSearchController? controller;
  final double fontSize;
  final double iconSize;
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
    this.fontSize = 16.0,
    this.iconSize = 32.0,
  }) : super(key: key);

  @override
  _KDatePickerSearchState createState() => _KDatePickerSearchState();
}

class _KDatePickerSearchState extends State<KDatePickerSearch> {
  late String value;
  DateTime? selected, first, last;
  late String format;
  @override
  void initState() {
    super.initState();
    value = widget.initDate?.toStringFormat(format: widget.formatDate) ?? '';
    format = widget.formatDate;
    selected = widget.initDate;
    first = widget.minDate;
    last = widget.maxDate;
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Icon(
                Icons.date_range_outlined,
                color: kWhiteColor,
                size: widget.iconSize,
              ),
            ),
            Expanded(
              child: Text(
                value.isEmpty ? widget.hintText : value,
                style: TextStyle(
                  color: kWhiteColor,
                  fontSize: widget.fontSize,
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
        initialDate: selected ?? DateTime.now(),
        firstDate: first ?? DateTime(1700),
        lastDate: last ?? DateTime(2500),
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

    if (picked != null && picked != selected) _setValue(picked);
  }

  void _setValue(DateTime value) {
    if (!mounted) return;
    setState(() {
      selected = value;
      this.value = DateFormat(widget.formatDate).format(value);
    });
    widget.onChange(value.toString());
  }

  void _clearValue() {
    if (!mounted) return;
    setState(() {
      value = '';
      selected = null;
      first = null;
      last = null;
    });
  }
}

class KDatePickerSearchController {
  _KDatePickerSearchState? _state;
  void _setState(_KDatePickerSearchState state) {
    _state = state;
  }

  DateTime? get date => _state!.selected;
  String get format => _state!.format;

  void dispose() {
    if (_state != null) {
      _state = null;
    }
  }

  void clear() {
    if (_state == null) return;
    _state!._clearValue();
  }

  void set(DateTime date, {DateTime? start, DateTime? end}) {
    if (_state == null) return;
    _state!._setValue(date);
    _state!.first = start ?? _state!.first;
    _state!.last = end ?? _state!.last;
  }
}
