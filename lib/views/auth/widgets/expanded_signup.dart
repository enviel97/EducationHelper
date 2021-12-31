import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class ExpandedSignUp extends StatelessWidget {
  final VoidCallback epandedSignup;
  final double height;

  const ExpandedSignUp({
    required this.epandedSignup,
    required this.height,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLightTheme = context.isLightTheme;
    final backgoundColor = isLightTheme ? kPrimaryColor : kSecondaryDarkColor;
    return GestureDetector(
      onTap: epandedSignup,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: double.infinity,
          height: height,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          decoration: BoxDecoration(
            color: backgoundColor,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                  text: TextSpan(children: <TextSpan>[
                TextSpan(
                    text: "Don't have account? ",
                    style: TextStyle(
                        color: kWhiteColor, fontSize: SPACING.M.size)),
                TextSpan(
                    text: 'Sign Up',
                    style: TextStyle(
                        color: isLightTheme ? kBlackColor : kSecondaryColor,
                        fontSize: SPACING.M.size * 1.1,
                        fontWeight: FontWeight.bold))
              ])),
              CircleAvatar(
                backgroundColor: backgoundColor,
                child: const Icon(AntDesign.upcircle, color: kWhiteColor),
              )
            ],
          ),
        ),
      ),
    );
  }
}
