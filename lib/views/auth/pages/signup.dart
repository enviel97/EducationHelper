import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/state.x.dart';
import 'package:education_helper/helpers/ultils/funtions.dart';
import 'package:education_helper/models/user.model.dart';
import 'package:education_helper/roots/bloc/app_bloc.dart';
import 'package:education_helper/views/auth/bloc/auth_bloc.dart';
import 'package:education_helper/views/auth/bloc/auth_state.dart';
import 'package:education_helper/views/auth/widgets/sign_up_stepper/sign_up_stepper.dart';
import 'package:education_helper/views/widgets/clippart/notch_custom_clip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class SignUpPage extends StatefulWidget {
  final double containerSize;
  final VoidCallback goLogin;

  const SignUpPage({
    required this.containerSize,
    required this.goLogin,
    Key? key,
  }) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (BuildContext context, AuthState state) {
        final appBloc = BlocProvider.of<AppBloc>(context);

        if (state is AuthSignupSuccessState) {
          appBloc.hiddenLoading(context);
          appBloc.showSuccess(context, 'Welcome');
          widget.goLogin();
        }
      },
      child: _mainUI(),
    );
  }

  Widget _mainUI() {
    final spacing = SPACING.M.vertical;
    const paddingRight = 30.0;
    const iconSize = 50.0;

    return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
            margin: const EdgeInsets.only(top: 25.0),
            width: double.infinity,
            height: widget.containerSize,
            child: Stack(children: [
              Align(
                  alignment: Alignment.bottomCenter,
                  child: ClipPath(
                      clipper: NotchedCustomClippath(
                        Offset(size.width - paddingRight - iconSize / 2, 0.0),
                      ),
                      child: Container(
                          padding: const EdgeInsets.only(
                              top: 10.0, left: 10.0, right: 10.0),
                          width: double.infinity,
                          height: widget.containerSize - 25.0,
                          decoration: BoxDecoration(
                            color: isLightTheme
                                ? kPrimaryColor
                                : kSecondarySuperDarkColor,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(25.0),
                                topRight: Radius.circular(25.0)),
                          ),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  ImageFromLocal.asPng('auth_welcome'),
                                  width: size.width * .5,
                                  fit: BoxFit.fitWidth,
                                ),
                                spacing,
                                const Expanded(child: SignUpStepper())
                              ])))),
              Align(
                  alignment: Alignment.topRight,
                  child: Container(
                      margin: const EdgeInsets.only(right: paddingRight),
                      height: iconSize,
                      width: iconSize,
                      decoration: BoxDecoration(
                          color: isLightTheme ? kSecondaryColor : kPrimaryColor,
                          shape: BoxShape.circle),
                      child: IconButton(
                          icon: const Icon(AntDesign.downcircleo),
                          color: kWhiteColor,
                          onPressed: widget.goLogin)))
            ])));
  }
}
