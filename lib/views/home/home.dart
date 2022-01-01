import 'package:education_helper/helpers/widgets/circle_animation.dart';
import 'package:education_helper/models/user.model.dart';
import 'package:education_helper/roots/bloc/app_bloc.dart';
import 'package:education_helper/views/home/pages/classrooms/classrooms.dart';
import 'package:education_helper/views/home/placeholders/classrooms_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimationCircleLayout(
        child: FutureBuilder<User?>(
          future: BlocProvider.of<AppBloc>(context).getUser(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final user = snapshot.data;
              if (user != null) return Classrooms(user: user);
            }
            return const ClassroomsHeaderPlaceholder();
          },
        ),
      ),
    );
  }
}
