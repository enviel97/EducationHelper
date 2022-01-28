import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:education_helper/roots/app_root.dart';
import 'package:education_helper/roots/parts/adapter.dart';
import 'package:education_helper/views/classrooms/bloc/classroom_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../classrooms.dart';

class ClassroomAdapter extends IAdapter {
  static final ClassroomAdapter _ins = ClassroomAdapter._internal();

  IAdapter get adapterMember => Root.ins.adapter.getAdapter(memberAdapter);

  factory ClassroomAdapter() {
    return _ins;
  }

  ClassroomAdapter._internal() {
    Root.ins.adapter.injectAdapter(classroomAdpater, this);
  }

  @override
  Widget layout({Map<String, dynamic>? params}) {
    return BlocProvider(
      create: (context) => ClassroomBloc(),
      child: const Classrooms(),
    );
  }

  Future<bool> goToMembers(
    BuildContext context, {
    required String uid,
  }) async {
    final isNeedChange =
        await context.goTo<bool>(adapterMember.layout(params: {'id': uid}));
    return isNeedChange ?? false;
  }
}
