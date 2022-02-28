import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/widgets/circle_animation.dart';

import 'package:education_helper/roots/app_root.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {
  late AnimationController _splashController;

  @override
  void initState() {
    super.initState();
    _splashController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _splashController.addListener(gotoScreen);
    _splashController.forward();
  }

  void gotoScreen() async {
    await Future.wait(Root.ins.config()).then((result) {
      debugPrint(result.join('\n'));
      Future.delayed(
        const Duration(milliseconds: 1500),
        () async {
          final firstScreens = await Root.ins.getScreens();
          Navigator.of(context).pushReplacement(
            AnimationCircleSource(firstScreens),
          );
        },
      );
    }).whenComplete(() {
      _splashController.stop();
    });
  }

  @override
  void dispose() {
    _splashController.removeListener(gotoScreen);
    _splashController.dispose();
    super.dispose();
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
              'Education Helper',
              style: TextStyle(
                color: kWhiteColor,
                fontWeight: FontWeight.bold,
                fontSize: 40.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
