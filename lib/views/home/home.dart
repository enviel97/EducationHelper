import 'package:education_helper/helpers/widgets/circle_animation.dart';
import 'package:education_helper/views/home/pages/classrooms/classrooms.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimationCircleLayout(child: const Classrooms()),
    );
  }
}
