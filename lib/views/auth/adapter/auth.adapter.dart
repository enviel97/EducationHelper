import 'package:education_helper/helpers/widgets/router_animation.dart';
import 'package:education_helper/roots/app_root.dart';
import 'package:education_helper/roots/miragate/injection.dart';
import 'package:education_helper/roots/parts/adapter.dart';
import 'package:education_helper/views/auth/bloc/auth_bloc.dart';
import 'package:education_helper/views/home/adapters/home.adapter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../auth.dart';

const String authAdpater = 'AuthAdapter';

class AuthAdpater extends IAdapter {
  @override
  AuthAdpater() {
    Root.ins.adapter.injectAdapter('AuthAdapter', this);
  }

  IAdapter get _homeAdapter => AppAdapter().getAdapter(homeAdapter);

  @override
  Widget layout() {
    final localStorage = Root.ins.localStorage;
    final authBloc = AuthBloc(localStorage);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => authBloc),
      ],
      child: const Auth(),
    );
  }

  Future<void> goToHome(BuildContext context) async {
    Navigator.of(context).pushReplacement(
      RouterAnimation(child: _homeAdapter.layout()),
    );
  }
}
