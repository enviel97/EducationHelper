import 'package:education_helper/roots/app_root.dart';
import 'package:education_helper/roots/parts/adapter.dart';
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
}
