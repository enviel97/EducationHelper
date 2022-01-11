import 'package:education_helper/roots/app_root.dart';
import 'package:education_helper/roots/parts/adapter.dart';
import 'package:flutter/cupertino.dart';

class MemberAdapter extends IAdapter {
  static final MemberAdapter _ins = MemberAdapter._internal();

  factory MemberAdapter() {
    return _ins;
  }

  MemberAdapter._internal() {
    Root.ins.adapter.injectAdapter(classroomAdpater, this);
  }

  @override
  Widget layout({Map<String, dynamic>? params}) {
    return Container();
  }
}
