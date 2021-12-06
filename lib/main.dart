import 'dart:async';

import 'package:education_helper/helpers/ultils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'roots/app_root.dart';
import 'roots/bloc/app_bloc.dart';
import 'views/routes.dart';
import 'views/auth/auth.dart';

Future<void> main() async {
  transparentStatusBar;
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Root.ins.config();
    runApp(
      MultiBlocProvider(
          providers: [BlocProvider(create: (context) => AppBloc())],
          child: const Routes(
            firstScreen: Auth(),
          )),
    );
  }, (error, trace) {
    // Splash in time
  });
}
