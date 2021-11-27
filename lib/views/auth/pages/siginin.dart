import 'package:education_helper/helpers/extensions/state.x.dart';
import 'package:flutter/material.dart';

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
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: SizedBox(
              width: size.width,
              height: height,
              child: Column(
                children: [
                  Text('Welcome Back'),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
