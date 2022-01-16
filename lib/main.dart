import 'dart:async';
import 'package:education_helper/helpers/ultils/widgets.dart';
import 'package:education_helper/views/classrooms/bloc/classroom_bloc.dart';
import 'package:education_helper/views/exam/bloc/exam_bloc.dart';
import 'package:education_helper/views/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'roots/bloc/app_bloc.dart';
import 'views/routes.dart';

Future<void> main() async {
  transparentStatusBar;
  WidgetsFlutterBinding.ensureInitialized();
  debugPrint('[Inititial App]');
  runZonedGuarded(() async {
    return runApp(MultiBlocProvider(providers: [
      BlocProvider(create: (context) => AppBloc()),
      BlocProvider(create: (context) => HomeBloc()),
      BlocProvider(create: (context) => ClassroomBloc()),
      BlocProvider(create: (context) => ExamBloc())
    ], child: const Routes()));
  }, (error, trace) {
    // Splash in time
  });
}
