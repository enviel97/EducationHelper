part of './date_picker_timeline.dart';

class DatePickerTimelineControler {
  late _DatePickerTimeLineState? _state;

  DatePickerTimelineControler();

  void _setView(_DatePickerTimeLineState view) {
    _state = view;
  }

  void jumpToSelection() {
    if (_state == null) return;
    _state!._controller.jumpTo(_calculateDateOffset(_state!._selectedDate));
  }

  void animateToSelection({
    Duration duration = const Duration(milliseconds: 500),
    Curve curve = Curves.easeInOutCubic,
  }) {
    if (_state == null) return;
    _state!._controller.animateTo(_calculateDateOffset(_state!._selectedDate),
        duration: duration, curve: curve);
  }

  void animateToDate(DateTime date,
      {duration = const Duration(milliseconds: 500),
      curve = Curves.easeInOutCubic}) {
    if (_state == null) return;
    _state!._controller.animateTo(_calculateDateOffset(date),
        duration: duration, curve: curve);
  }

  double _calculateDateOffset(DateTime date) {
    if (_state == null) return 0.0;
    final startDate = DateTime(
      _state!.widget.startDate.year,
      _state!.widget.startDate.month,
      _state!.widget.startDate.day,
    );

    final position = _state!._controller.position;
    final offset = date.difference(startDate).inDays;
    print(offset);
    print(position);
    return offset * (_state!.widget.width + 10);
  }
}
