import 'package:education_helper/helpers/widgets/error_authenticate.dart';
import 'package:education_helper/models/user.model.dart';
import 'package:education_helper/roots/bloc/app_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'pages/classroom_list/classroom_list.dart';
import 'placeholders/classrooms_placeholder.dart';

class Classrooms extends StatefulWidget {
  const Classrooms({
    Key? key,
  }) : super(key: key);

  @override
  _ClassroomsState createState() => _ClassroomsState();
}

class _ClassroomsState extends State<Classrooms> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: BlocProvider.of<AppBloc>(context).getUser(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return ErrorAuthenticate(messenger: snapshot.error.toString());
        }
        if (snapshot.hasData && snapshot.data != null) {
          return ClassroomList(user: snapshot.data!);
        }
        return const ClassroomsPlaceholder();
      },
    );
  }
}
