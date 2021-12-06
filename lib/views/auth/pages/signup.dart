import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/state.x.dart';
import 'package:education_helper/helpers/ultils/funtions.dart';
import 'package:education_helper/views/widgets/clippart/notch_custom_clip.dart';
import 'package:education_helper/views/widgets/custom_text_button.dart';
import 'package:education_helper/views/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

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
    final spacing = SPACING.M.vertical;
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: const EdgeInsets.only(top: 25.0),
        width: double.infinity,
        height: widget.containerSize,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: ClipPath(
                clipper: NotchedCustomClippath(Offset(size.width - 95.0, 0.0)),
                child: SingleChildScrollView(
                  reverse: true,
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
                          SvgPicture.asset(
                            ImageFromLocal.asSvg('logo'),
                            width: size.width * .6,
                            fit: BoxFit.fitWidth,
                          ),
                          spacing,
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const KTextField(
                                iconData: Icons.email_rounded,
                                hintText: 'Email',
                                keyboardType: TextInputType.emailAddress,
                              ),
                              Row(
                                children: [
                                  const Flexible(
                                    child: KTextField(
                                      iconData: Icons.account_circle_rounded,
                                      hintText: 'Name',
                                      keyboardType: TextInputType.text,
                                    ),
                                  ),
                                  SPACING.M.horizontal,
                                  const Flexible(
                                    child: KTextField(
                                      iconData: Icons.phone_android_outlined,
                                      hintText: 'Phone',
                                      keyboardType: TextInputType.phone,
                                    ),
                                  ),
                                ],
                              ),
                              const KTextField(
                                iconData: Icons.lock_rounded,
                                hintText: 'Password',
                                isSecurity: true,
                                keyboardType: TextInputType.text,
                              ),
                              const KTextField(
                                iconData: Icons.lock_rounded,
                                hintText: 'Password Confirm',
                                isSecurity: true,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.done,
                              ),
                            ],
                          ),
                          spacing,
                          KTextButton(
                            text: 'Sign Up',
                            onPressed: () {},
                          )
                        ]),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                margin: const EdgeInsets.only(right: 70.0),
                height: 50.0,
                width: 50.0,
                decoration: BoxDecoration(
                  color: isLightTheme ? kSecondaryColor : kPrimaryColor,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.login_outlined),
                  color: kWhiteColor,
                  onPressed: widget.goLogin,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
