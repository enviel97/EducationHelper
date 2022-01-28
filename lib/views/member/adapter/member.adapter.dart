import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:education_helper/models/members.model.dart';
import 'package:education_helper/roots/app_root.dart';
import 'package:education_helper/roots/parts/adapter.dart';
import 'package:education_helper/views/member/bloc/member_bloc.dart';
import 'package:education_helper/views/member/members.dart';
import 'package:education_helper/views/member/pages/member_confirm_csv/member_confirm_csv.dart';
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
      child: Members(
        classname: params!['classname'],
        totalExams: params['exams'],
        totalMembers: params['members'],
      ),
    );
  }

  void goToMembersAdd(BuildContext context,
      {required String classname, required List<Member> members}) {
    context.goTo(
      BlocProvider.value(
        value: BlocProvider.of<MemberBloc>(context),
        child: MemberConfirmCSV(classname: classname, members: members),
      ),
    );
  }
}
