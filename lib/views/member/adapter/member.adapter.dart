import 'package:education_helper/roots/app_root.dart';
import 'package:education_helper/roots/parts/adapter.dart';
import 'package:education_helper/views/member/bloc/member_bloc.dart';
import 'package:education_helper/views/member/members.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MemberAdapter extends IAdapter {
  static final MemberAdapter _ins = MemberAdapter._internal();

  factory MemberAdapter() {
    return _ins;
  }

  MemberAdapter._internal() {
    Root.ins.adapter.injectAdapter(memberAdapter, this);
  }

  @override
  Widget layout({Map<String, dynamic>? params}) {
    return BlocProvider(
      create: (context) => MemberBloc(params!['id']),
      child: const Members(),
    );
  }
}
