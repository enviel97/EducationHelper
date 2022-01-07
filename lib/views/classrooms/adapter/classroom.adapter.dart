import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:education_helper/roots/app_root.dart';
import 'package:education_helper/roots/parts/adapter.dart';
import 'package:education_helper/views/classrooms/pages/classroom_detail/classroom_detail.dart';
import 'package:flutter/material.dart';

import '../classrooms.dart';

class ClassroomAdapter extends IAdapter {
  static final ClassroomAdapter _ins = ClassroomAdapter._internal();

  factory ClassroomAdapter() {
    return _ins;
  }

  ClassroomAdapter._internal() {
    Root.ins.adapter.injectAdapter(classroomAdpater, this);
  }

  @override
  Widget layout() {
    return const Classrooms();
  }

  Future<void> goToClassroomDetail(BuildContext context, String uid) async {
    await context.goTo(ClassroomDetail(id: uid));
  }
}
