import 'package:education_helper/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class KTimeField extends StatefulWidget {
  final Color textColor;
  final String initHour;
  final String intiMinute;
  final void Function(String value) onChangeHours;
  final void Function(String value) onChangeMinutes;
  const KTimeField({
    required this.onChangeHours,
    required this.onChangeMinutes,
    Key? key,
    this.textColor = kBlackColor,
    this.initHour = '12',
    this.intiMinute = '00',
  }) : super(key: key);

  @override
  State<KTimeField> createState() => _KTimeFieldState();
}

class _KTimeFieldState extends State<KTimeField> {
  bool hasError = false;
  String currentText = '';
  late TextEditingController _hoursController;
  late TextEditingController _minutesController;

  @override
  void initState() {
    _hoursController = TextEditingController(text: widget.initHour);
    _minutesController = TextEditingController(text: widget.intiMinute);
    super.initState();
  }

  PinTheme get theme => PinTheme(
        fieldOuterPadding: const EdgeInsets.symmetric(
          vertical: 2.0,
          horizontal: 5.0,
        ),
        shape: PinCodeFieldShape.underline,
        selectedColor: kPlacehoderSuperDarkColor,
        errorBorderColor: kPlacehoderSuperDarkColor,
        activeColor: kPlacehoderSuperDarkColor,
        inactiveColor: kPlacehoderSuperDarkColor,
        fieldHeight: 32,
        fieldWidth: 24,
      );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 100.0,
          height: 48.0,
          child: PinCodeTextField(
            appContext: context,
            controller: _hoursController,
            length: 2,
            mainAxisAlignment: MainAxisAlignment.end,
            animationType: AnimationType.fade,
            textStyle: TextStyle(color: widget.textColor),
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            pinTheme: theme,
            onCompleted: (value) {
              if (value.isEmpty) return;
              final hours = int.tryParse(value);
              if (hours == null) return;
              if (hours > 23) {
                _hoursController.text = '23';
              }
            },
            onChanged: widget.onChangeHours,
          ),
        ),
        const Text(
          ' : ',
          textAlign: TextAlign.center,
          style: TextStyle(color: kBlackColor, fontSize: 16.0),
        ),
        SizedBox(
          width: 100.0,
          height: 48.0,
          child: PinCodeTextField(
            appContext: context,
            controller: _minutesController,
            length: 2,
            mainAxisAlignment: MainAxisAlignment.start,
            animationType: AnimationType.fade,
            textStyle: TextStyle(color: widget.textColor),
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.number,
            pinTheme: theme,
            onCompleted: (value) {
              if (value.isEmpty) return;
              final hours = int.tryParse(value);
              if (hours == null) return;
              if (hours > 59) {
                _minutesController.text = '59';
              }
            },
            onChanged: widget.onChangeMinutes,
          ),
        ),
      ],
    );
  }
}
