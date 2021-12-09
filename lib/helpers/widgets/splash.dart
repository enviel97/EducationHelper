import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:education_helper/helpers/widgets/circle_animation.dart';
import 'package:education_helper/roots/app_root.dart';
import 'package:flutter/cupertino.dart';
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
  }

// Root.ins.getScreens()
  Widget loading(isComplete) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SpinKitFadingCube(color: kWhiteColor, size: 60.0),
            SPACING.XXL.vertical,
            Text(
              isComplete ? 'Welcome' : 'Loading...',
              style: const TextStyle(
                color: kWhiteColor,
                fontWeight: FontWeight.bold,
                fontSize: 40.0,
              ),
            )
          ],
        ),
      );

  void gotoScreen() async {
    await Root.ins.getScreens().then((value) async {
      await Future.delayed(const Duration(milliseconds: 700)).whenComplete(() {
        Navigator.of(context).pushReplacement(AnimationCircleSource(value));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: FutureBuilder(
        future: Future.wait(Root.ins.config()),
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return loading(false);
          }
          Future.delayed(const Duration(seconds: 1), gotoScreen);
          return loading(true);
        },
      ),
    );
  }
}
