import 'dart:async';
import 'package:education_helper/helpers/ultils/widgets.dart';
import 'package:education_helper/helpers/widgets/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'roots/bloc/app_bloc.dart';
import 'views/routes.dart';

Future<void> main() async {
  transparentStatusBar;
  WidgetsFlutterBinding.ensureInitialized();
  debugPrint('[Inititial App]');
  runZonedGuarded(() async {
    return runApp(MultiBlocProvider(
        providers: [BlocProvider(create: (context) => AppBloc())],
        child: const Routes(firstScreen: Splash())));
  }, (error, trace) {
    // Splash in time
  });
}
