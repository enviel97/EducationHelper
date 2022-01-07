import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerHorizantalItem extends StatelessWidget {
  final DateTime date;
  final Color selectionColor;
  final Function(DateTime date) onDateSelected;
  final bool isSelected;
  final bool isOutline;
  final String? locale;
  final double height;
  final double width;

  const DatePickerHorizantalItem({
    required this.date,
    required this.selectionColor,
    required this.onDateSelected,
    required this.height,
    required this.width,
    Key? key,
    this.locale,
    this.isSelected = false,
    this.isOutline = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final month = DateFormat('MMM', locale).format(date).toUpperCase();
    final day = date.day.toString();
    final dayInWeeks = DateFormat('E', locale).format(date).toUpperCase();
    final shape = BorderRadius.circular(20.0);
    return InkWell(
      onTap: () => onDateSelected(date),
      borderRadius: shape,
      child: Container(
        width: width,
        height: height,
        margin: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color: isSelected ? selectionColor : Colors.transparent,
          borderRadius: shape,
          border: Border.all(
            color: isOutline ? selectionColor : Colors.transparent,
            width: 5.0,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(month,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: SPACING.M.size,
                  )),
              Text(day,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: SPACING.XL.size,
                      color: context.isLightTheme
                          ? (isSelected ? kWhiteColor : kPrimaryLightColor)
                          : (isSelected ? kWhiteColor : kSecondaryLightColor))),
              Text(dayInWeeks,
                  style: TextStyle(
                    fontSize: SPACING.M.size,
                    fontWeight: FontWeight.bold,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
