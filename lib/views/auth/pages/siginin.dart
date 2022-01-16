import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:education_helper/helpers/extensions/state.x.dart';
import 'package:education_helper/helpers/ultils/funtions.dart';
import 'package:education_helper/roots/app_root.dart';
import 'package:education_helper/roots/bloc/app_bloc.dart';
import 'package:education_helper/views/auth/adapter/auth.adapter.dart';
import 'package:education_helper/views/auth/bloc/auth_bloc.dart';
import 'package:education_helper/views/auth/bloc/auth_state.dart';
import 'package:education_helper/views/widgets/button/custom_icon_button.dart';
import 'package:education_helper/views/widgets/button/custom_text_button.dart';
import 'package:education_helper/views/widgets/deorate/horizantal_divider.dart';
import 'package:education_helper/views/widgets/form/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({
    Key? key,
  }) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final adapter = Root.ins.adapter.getAdapter(authAdapter).cast<AuthAdpater>();
  double get height => size.height * .8;
  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (BuildContext context, AuthState state) {
        final appBloc = BlocProvider.of<AppBloc>(context);
        if (state is AuthLoadingState) {
          appBloc.showLoading(context, 'Sign In ...');
        }
        if (state is AuthErrorState) {
          appBloc.hiddenLoading(context);
          appBloc.showError(context, state.error);
        }
        if (state is AuthErrorsState) {
          appBloc.hiddenLoading(context);
          appBloc.showError(context, state.errors[0].values.first);
        }

        if (state is AuthSigninSuccessState) {
          appBloc.hiddenLoading(context);
          adapter.goToHome(context);
        }
      },
      child: _mainUI(),
    );
  }

  Widget _mainUI() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          width: size.width,
          height: height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                ImageFromLocal.asPng('auth_welcome'),
                width: size.width * .6,
                fit: BoxFit.fitWidth,
              ),
              SPACING.XL.vertical,
              Column(
                children: [
                  KTextField(
                    iconData: Icons.email_outlined,
                    hintText: 'Email',
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    onChange: (value) => username = value,
                  ),
                  KTextField(
                    iconData: Icons.lock_rounded,
                    hintText: 'Password',
                    isSecurity: true,
                    textInputAction: TextInputAction.done,
                    onChange: (value) => password = value,
                    onSubmit: _submit,
                  )
                ],
              ),
              SPACING.M.vertical,
              KTextButton(text: 'Sign In', onPressed: _signInWithEmail),
              SPACING.SM.vertical,
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 62.5),
                child: HorizantalDivider(text: 'Or'),
              ),
              SPACING.SM.vertical,
              KIconButton(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                icon: const Icon(Entypo.google_, color: kWhiteColor),
                onPressed: _signInWithGoogle,
                text: 'Sign in with google',
              ),
              SPACING.M.vertical,
            ],
          ),
        ),
      ),
    );
  }

  void _signInWithEmail() async {
    await context.disableKeyBoard();
    if (username.isEmpty || password.isEmpty) return;
    await BlocProvider.of<AuthBloc>(context)
        .signInWithEmail(username, password);
  }

  void _signInWithGoogle() async {
    context.disableKeyBoard();
    await BlocProvider.of<AuthBloc>(context).signInWithGoogle();
  }

  void _submit(String value) {
    _signInWithEmail();
  }
}
