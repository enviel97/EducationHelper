// ignore_for_file: file_names
import 'package:education_helper/constants/app_theme.dart';
import 'package:flutter/material.dart';

import 'splash/splash.dart';

class Routes extends StatefulWidget {
  const Routes({
    Key? key,
  }) : super(key: key);

  @override
  _RoutesState createState() => _RoutesState();
}

class _RoutesState extends State<Routes> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Education Helper',
      theme: AppTheme.lightTheme(context),
      darkTheme: AppTheme.darkTheme(context),
      home: const Splash(),
    );
  }
}
