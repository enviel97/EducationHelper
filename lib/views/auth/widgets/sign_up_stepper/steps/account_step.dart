import 'package:education_helper/helpers/ultils/validation.dart';
import 'package:education_helper/views/widgets/form/custom_text_field.dart';
import 'package:flutter/material.dart';

class AccountStep extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  final Function(String email) onEmailChange;

  final Function(String password) onPasswordChange;

  const AccountStep({
    required this.formKey,
    required this.onEmailChange,
    required this.onPasswordChange,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          KTextField(
            iconData: Icons.email_rounded,
            hintText: 'Email',
            validation: isEmail,
            keyboardType: TextInputType.emailAddress,
            onChange: onEmailChange,
          ),
          KTextField(
            iconData: Icons.lock_rounded,
            hintText: 'Password',
            isSecurity: true,
            keyboardType: TextInputType.text,
            validation: isPassword,
            onChange: onPasswordChange,
          ),
        ],
      ),
    );
  }
}
