import 'dart:io';

import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:education_helper/helpers/extensions/string_x.dart';
import 'package:education_helper/helpers/ultils/validation.dart';
import 'package:education_helper/helpers/widgets/scroller_grow_disable.dart';
import 'package:education_helper/views/widgets/form/custom_text_field.dart';
import 'package:flutter/material.dart';

class ConfirmStep extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final String password;
  final String name;
  final String phoneNumber;
  final String email;
  final File? avatar;
  const ConfirmStep({
    required this.formKey,
    this.password = '',
    this.name = '',
    this.phoneNumber = '',
    this.email = '',
    this.avatar,
    Key? key,
  }) : super(key: key);

  Widget get _buildAvatar {
    if (avatar != null) {
      return Image.file(avatar!, fit: BoxFit.cover);
    }
    const style = TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold);
    if (name.isEmpty) {
      return const Tooltip(
        message: 'Name is empty',
        child: Text('?', style: style),
      );
    }
    return Text(name.split(' ').last[0].toUpperCase(), style: style);
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        context.isLightTheme ? kSecondaryColor : kPrimaryColor;
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                Container(
                  width: 125.0,
                  height: 125.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: backgroundColor,
                      border: Border.all(color: kPrimaryColor, width: 4.0)),
                  child: _buildAvatar,
                ),
                SPACING.S.horizontal,
                if (email.isNotEmpty ||
                    name.isNotEmpty ||
                    phoneNumber.isNotEmpty)
                  Expanded(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                        _nullableWidget(context,
                            label: Icons.email_rounded, value: email),
                        _nullableWidget(context,
                            label: Icons.account_circle_rounded, value: name),
                        _nullableWidget(context,
                            label: Icons.phone_android_outlined,
                            value: phoneNumber.toPhone())
                      ]))
              ])),
          SPACING.S.vertical,
          KTextField(
            iconData: Icons.lock_rounded,
            hintText: 'Password confirm',
            isSecurity: true,
            keyboardType: TextInputType.text,
            validation: (value) => isEqual(value, password),
          ),
        ],
      ),
    );
  }

  Widget _nullableWidget(
    BuildContext context, {
    required IconData label,
    required String value,
  }) {
    if (value.isEmpty) {
      return const SizedBox.shrink();
    }
    return Padding(
        padding: const EdgeInsets.only(bottom: 5.0),
        child: Row(children: [
          CircleAvatar(
              radius: 16.0,
              backgroundColor: kWhiteColor,
              child: Icon(label, color: kPrimaryColor, size: SPACING.LG.size)),
          SPACING.S.horizontal,
          Expanded(
              child: Tooltip(
            message: value,
            child: NormalScroll(
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(value,
                        style: TextStyle(
                            fontSize: SPACING.M.size, color: kWhiteColor)))),
          ))
        ]));
  }
}
