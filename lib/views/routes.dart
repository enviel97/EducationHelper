// ignore_for_file: file_names
import 'package:education_helper/constants/app_theme.dart';
import 'package:flutter/material.dart';

class Routes extends StatefulWidget {
  final Widget firstScreen;

  const Routes({
    required this.firstScreen,
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
        title: 'Gaming Gear Store',
        theme: AppTheme.lightTheme(context),
        darkTheme: AppTheme.darkTheme(context),
        home: widget.firstScreen);
  }
}
