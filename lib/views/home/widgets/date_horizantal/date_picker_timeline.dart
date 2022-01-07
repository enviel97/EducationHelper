import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/helpers/extensions/datetime_x.dart';
import 'package:education_helper/helpers/extensions/state.x.dart';
import 'package:education_helper/views/home/widgets/date_horizantal/date_picker_horizantal_item.dart';
import 'package:flutter/material.dart';
part './date_picker_horizantal.controller.dart';

/// clone
class DatePickerTimeLine extends StatefulWidget {
  final DateTime startDate;
  final List<DateTime> note;

  final DateTime? initialSelectedDate;
  final DatePickerTimelineControler? controler;
  final void Function(DateTime date) onDateChange;
  final double height = 125.0;
  final double width = 60.0;

  const DatePickerTimeLine({
    required this.startDate,
    required this.onDateChange,
    Key? key,
    this.initialSelectedDate,
    this.controler,
    this.note = const [],
  }) : super(key: key);

  @override
  _DatePickerTimeLineState createState() => _DatePickerTimeLineState();
}

class _DatePickerTimeLineState extends State<DatePickerTimeLine> {
  DateTime selectedDate = DateTime.now();
  late DateTime _selectedDate;
  late ScrollController _controller;
  final List<String> items = List.generate(20, (index) => 'Hello $index');
  late double intitOffset = 0.0;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialSelectedDate ?? DateTime.now();
    if (widget.controler != null) {
      widget.controler!._setView(this);
    }
    final offSetScroller =
        _selectedDate.difference(widget.startDate).inDays + 1;
    intitOffset = offSetScroller * (widget.width + 10.0);
    _controller = ScrollController(initialScrollOffset: intitOffset)
      ..addListener(_scollListenter);
  }

  @override
  void dispose() {
    _controller.removeListener(_scollListenter);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: items.length,
        addAutomaticKeepAlives: false,
        scrollDirection: Axis.horizontal,
        controller: _controller,
        itemBuilder: (context, index) {
          final _date = widget.startDate.add(Duration(days: index));
          final date = DateTime(_date.year, _date.month, _date.day);
          final isSelected = date.isEqual(_selectedDate);
          final isOutline =
              widget.note.where((note) => note.isEqual(date)).isNotEmpty;

          return DatePickerHorizantalItem(
            isSelected: isSelected,
            date: date,
            isOutline: isOutline,
            selectionColor: isLightTheme ? kPrimaryLightColor : kPrimaryColor,
            height: widget.height,
            width: widget.width,
            onDateSelected: (selectedDate) {
              widget.onDateChange(selectedDate);
              setState(() {
                _selectedDate = selectedDate;
              });
            },
          );
        },
      ),
    );
  }

  void _scollListenter() {
    if (_controller.position.extentAfter < 500) {
      setState(() {
        items.addAll(List.generate(42, (index) => 'Inserted $index'));
      });
    }
  }
}
