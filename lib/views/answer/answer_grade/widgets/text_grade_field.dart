import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/views/answer/answer_grade/typings/hint_grade.dart';
import 'package:flutter/material.dart';

class TextGradeField extends StatefulWidget {
  final void Function(String value) onChanged;
  const TextGradeField({
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  State<TextGradeField> createState() => _TextGradeFieldState();
}

class _TextGradeFieldState extends State<TextGradeField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10.0),
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: kPrimaryColor, width: 1.0))),
      child: Focus(
        onFocusChange: _onFocusChange,
        child: TextField(
          controller: _controller,
          maxLines: 1,
          cursorColor: kPrimaryColor,
          cursorWidth: 2.0,
          cursorHeight: 20.0,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.number,
          autofillHints: hintGrade,
          scrollPadding: const EdgeInsets.all(2.0),
          textAlign: TextAlign.right,
          textAlignVertical: TextAlignVertical.center,
          style: TextStyle(
            color: kPrimaryColor,
            fontSize: SPACING.M.size,
          ),
          decoration: const InputDecoration(
            hintText: '0.00',
            hintStyle: TextStyle(color: kPlaceholderDarkColor),
            contentPadding: EdgeInsets.all(4.0),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
          ),
          onEditingComplete: _onEditingComplete,
          onChanged: _onChanged,
        ),
      ),
    );
  }

  void _onChanged(String value) {
    widget.onChanged(value);
  }

  void _limitValue() {
    final value = _controller.text;
    final grade = double.tryParse(value) ?? 0.0;
    if (grade > 10.0) {
      _controller.text = '10.0';
      widget.onChanged(_controller.text);
    } else if (grade < 0.0) {
      _controller.text = '0.0';
      widget.onChanged(_controller.text);
    }
  }

  void _onEditingComplete() {
    _limitValue();
  }

  void _onFocusChange(bool value) {
    if (!value) _limitValue();
  }
}
