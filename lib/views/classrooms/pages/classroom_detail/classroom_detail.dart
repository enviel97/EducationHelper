import 'package:education_helper/helpers/widgets/error_authenticate.dart';
import 'package:education_helper/models/classroom.model.dart';
import 'package:education_helper/roots/bloc/app_bloc.dart';
import 'package:education_helper/roots/bloc/app_state.dart';
import 'package:education_helper/views/classrooms/pages/classroom_detail/widgets/classroom_detail_header.dart';
import 'package:education_helper/views/classrooms/placeholders/classrooms_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClassroomDetail extends StatefulWidget {
  final String id;

  const ClassroomDetail({
    required this.id,
    Key? key,
  }) : super(key: key);

  @override
  _ClassroomDetailState createState() => _ClassroomDetailState();
}

class _ClassroomDetailState extends State<ClassroomDetail> {
  late Classroom classroom;
  @override
  void initState() {
    super.initState();
    classroom = Classroom.fake();
    BlocProvider.of<AppBloc>(context).getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          BlocBuilder<AppBloc, AppState>(
            builder: (context, state) {
              if (state is UserStateSuccess) {
                return ClassroomDetailHeader(user: state.user);
              }
              if (state is UserStateFailure) {
                return ErrorAuthenticate(messenger: state.messenger);
              }
              return const ClassroomsPlaceholder();
            },
          ),
        ],
      ),
    );
  }
}
