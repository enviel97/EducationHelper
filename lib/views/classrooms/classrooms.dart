import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/helpers/extensions/state.x.dart';
import 'package:education_helper/helpers/widgets/error_authenticate.dart';
import 'package:education_helper/roots/bloc/app_bloc.dart';
import 'package:education_helper/roots/bloc/app_state.dart';
import 'package:education_helper/views/widgets/header/appbar_bottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'pages/classroom_list/classroom_list.dart';
import 'placeholders/classrooms_placeholder.dart';

class Classrooms extends StatefulWidget {
  const Classrooms({Key? key}) : super(key: key);

  @override
  _ClassroomsState createState() => _ClassroomsState();
}

class _ClassroomsState extends State<Classrooms> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AppBloc>(context).getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: Navigator.of(context).pop,
        ),
        title: const Text('CLASSROOM'),
        bottom: const AppbarBottom(),
      ),
      body: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          if (state is UserStateSuccess) {
            return ClassroomList(user: state.user);
          }
          if (state is UserStateFailure) {
            return ErrorAuthenticate(messenger: state.messenger);
          }
          return const ClassroomsPlaceholder();
        },
      ),
    );
  }
}
