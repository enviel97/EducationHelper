import 'dart:io';
import 'dart:math';

import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:education_helper/helpers/extensions/state.x.dart';
import 'package:education_helper/helpers/widgets/scroller_grow_disable.dart';
import 'package:education_helper/models/user.model.dart';
import 'package:education_helper/roots/bloc/app_bloc.dart';
import 'package:education_helper/views/auth/bloc/auth_bloc.dart';
import 'package:education_helper/views/auth/widgets/sign_up_stepper/steps/confirm_step.dart';
import 'package:education_helper/views/auth/widgets/sign_up_stepper/steps/info_step.dart';
import 'package:education_helper/views/widgets/button/custom_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'steps/account_step.dart';

class SignUpStepper extends StatefulWidget {
  const SignUpStepper({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpStepper> createState() => _SignUpStepperState();
}

class _SignUpStepperState extends State<SignUpStepper> {
  String email = '';
  String name = '';
  String password = '';
  String phoneNumber = '';
  File? avatar;

  int _currentStep = 0;

  final _formKeySteps = [
    GlobalKey<FormState>(debugLabel: 'Account form'),
    GlobalKey<FormState>(debugLabel: 'Info form'),
    GlobalKey<FormState>(debugLabel: 'Confirm form'),
  ];

  final _stepState = <StepState>[
    StepState.indexed,
    StepState.indexed,
    StepState.indexed
  ];

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return NormalScroll(
      child: SingleChildScrollView(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Theme(
            data: themeData.copyWith(
              canvasColor: themeData.backgroundColor,
              colorScheme: const ColorScheme.light(),
            ),
            child: Stepper(
              elevation: 20.0,
              currentStep: _currentStep,
              type: StepperType.horizontal,
              onStepTapped: _goStep,
              onStepContinue: _onStepContinue,
              onStepCancel: () {
                setState(() => _currentStep = max(_currentStep - 1, 0));
              },
              controlsBuilder: _controlsBuilder,
              steps: [
                Step(
                  isActive: _currentStep >= 0,
                  title: const Text('Acount'),
                  state: _stepState[0],
                  content: AccountStep(
                    formKey: _formKeySteps[0],
                    onEmailChange: (value) => onEdited('email', value),
                    onPasswordChange: (value) => onEdited('password', value),
                  ),
                ),
                Step(
                    isActive: _currentStep >= 1,
                    title: const Text('Info'),
                    state: _stepState[1],
                    content: InfoStep(
                      formKey: _formKeySteps[1],
                      onPhoneChanged: (value) => onEdited('phone', value),
                      onNameChanged: (value) => onEdited('name', value),
                      onAvatarChanged: _getFile,
                    )),
                Step(
                  isActive: _currentStep >= 2,
                  title: const Text('Confirm'),
                  content: ConfirmStep(
                    formKey: _formKeySteps[2],
                    password: password,
                    email: email,
                    name: name,
                    phoneNumber: phoneNumber,
                    avatar: avatar,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _controlsBuilder(BuildContext context, ControlsDetails details) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (_currentStep > 0)
          KTextButton(
            onPressed: details.onStepCancel,
            isOutline: true,
            backgroudColor: kWhiteColor,
            color: kBlackColor,
            text: 'Previous',
            width: 100.0,
          ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: KTextButton(
            isDisable: _stepState[_currentStep] == StepState.error,
            onPressed: details.onStepContinue,
            text: _currentStep < 2 ? 'Next' : 'Sign Up',
            width: 100.0,
          ),
        ),
      ],
    );
  }

  bool _isValid(int step) {
    return _formKeySteps[step].currentState?.validate() ?? false;
  }

  void _goStep(int step) {
    for (int i = 0; i < step; ++i) {
      _stepState[i] = _isValid(i) ? StepState.complete : StepState.error;
    }
    setState(() => _currentStep = step);
  }

  void _onStepContinue() {
    final validOnStep = _isValid(_currentStep);
    _stepState[_currentStep] =
        validOnStep ? StepState.complete : StepState.error;
    if (validOnStep) {
      if (_currentStep == 2) {
        context.disableKeyBoard();
        BlocProvider.of<AppBloc>(context).showLoading(context, 'Sign Up');
        BlocProvider.of<AuthBloc>(context).signUp(
          User(name: name, email: email, phoneNumber: phoneNumber),
          password,
          avatar: avatar,
        );
      } else {
        _goStep(_currentStep + 1);
      }
    }
  }

  void _getFile(File? image) {
    avatar = image;
  }

  void onEdited(String label, String value) {
    switch (label) {
      case 'email':
        email = value;
        break;
      case 'password':
        password = value;
        break;
      case 'name':
        name = value;
        break;
      case 'phone':
        phoneNumber = value;
        break;
    }

    if (value.isNotEmpty) {
      setState(
        () => _stepState[_currentStep] = StepState.editing,
      );
    }
  }
}
