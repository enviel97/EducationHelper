import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/widgets/circle_animation.dart';

import 'package:education_helper/roots/app_root.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Splash extends StatefulWidget {
  final bool isComplete;
  const Splash({
    Key? key,
    this.isComplete = false,
  }) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    gotoScreen();
  }

  void gotoScreen() async {
    final lastScreens =
        await Future.wait(Root.ins.config()).then((_) => Root.ins.getScreens());

    await Future.delayed(
      const Duration(milliseconds: 1500),
      () => Navigator.of(context).pushReplacement(
        AnimationCircleSource(lastScreens),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SpinKitFadingCube(color: kWhiteColor, size: 60.0),
            SPACING.XXL.vertical,
            const Text(
              'Welcome',
              style: TextStyle(
                color: kWhiteColor,
                fontWeight: FontWeight.bold,
                fontSize: 40.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
