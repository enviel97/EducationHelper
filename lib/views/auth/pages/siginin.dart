import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/state.x.dart';
import 'package:education_helper/helpers/ultils/funtions.dart';
import 'package:education_helper/views/widgets/custom_text_button.dart';
import 'package:education_helper/views/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignInPage extends StatefulWidget {
  final void Function() onSigin;
  const SignInPage({
    required this.onSigin,
    Key? key,
  }) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  double get height => size.height * .8;

  @override
  Widget build(BuildContext context) {
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
              SvgPicture.asset(
                ImageFromLocal.asSvg('logo'),
                width: size.width * .6,
                fit: BoxFit.fitWidth,
              ),
              SPACING.XL.vertical,
              Column(
                children: [
                  const KTextField(
                    iconData: Icons.email_outlined,
                    hintText: 'Username',
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const KTextField(
                    iconData: Icons.lock_rounded,
                    hintText: 'Password',
                    isSecurity: true,
                    textInputAction: TextInputAction.done,
                  )
                ],
              ),
              SPACING.LG.vertical,
              KTextButton(
                text: 'Sign In',
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
