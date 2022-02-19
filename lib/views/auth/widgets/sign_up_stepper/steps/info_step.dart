import 'dart:io';

import 'package:education_helper/helpers/ultils/validation.dart';
import 'package:education_helper/views/widgets/form/custom_select_image.dart';
import 'package:education_helper/views/widgets/form/custom_text_field.dart';
import 'package:flutter/material.dart';

class InfoStep extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final Function(String value) onPhoneChanged;
  final Function(String value) onNameChanged;
  final Function(File? file) onAvatarChanged;

  const InfoStep({
    required this.formKey,
    required this.onPhoneChanged,
    required this.onNameChanged,
    required this.onAvatarChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: KSelectImage(
            imageWidth: 125.0,
            imageHeight: 125.0,
            onAvatarChanged: onAvatarChanged,
          ),
        ),
        Expanded(
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                KTextField(
                  iconData: Icons.account_circle_rounded,
                  hintText: 'Name',
                  keyboardType: TextInputType.text,
                  validation: isNotEmpty,
                  onChange: onNameChanged,
                ),
                KTextField(
                  iconData: Icons.phone_android_outlined,
                  hintText: 'Phone',
                  keyboardType: TextInputType.phone,
                  validation: isPhone,
                  onChange: onPhoneChanged,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
