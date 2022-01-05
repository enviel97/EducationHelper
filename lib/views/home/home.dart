import 'package:education_helper/helpers/widgets/circle_animation.dart';
import 'package:education_helper/models/classroom.model.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<Classroom> classrooms;
  @override
  void initState() {
    super.initState();
    classrooms = List<Classroom>.generate(10, (index) => Classroom.fake());
  }

  @override
  Widget build(BuildContext context) {
    return AnimationCircleLayout(
      child: Scaffold(
        body: Center(
          child: Text('Home'),
        ),
      ),
    );
  }
}
