import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:education_helper/helpers/widgets/error_authenticate.dart';
import 'package:education_helper/helpers/widgets/scroller_grow_disable.dart';
import 'package:education_helper/models/classroom.model.dart';
import 'package:education_helper/roots/app_root.dart';
import 'package:education_helper/roots/bloc/app_bloc.dart';
import 'package:education_helper/roots/bloc/app_state.dart';
import 'package:education_helper/views/classrooms/bloc/classroom_bloc.dart';
import 'package:education_helper/views/member/adapter/member.adapter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/member_bloc.dart';
import 'bloc/member_state.dart';
import 'pages/members_list/member_detail_body/members_body.dart';
import 'pages/members_list/member_detail_body/widgets/members_header.dart';
import 'pages/members_list/members_header.dart';
import 'placeholders/p_member_header.dart';

class Members extends StatefulWidget {
  static final adapter =
      Root.ins.adapter.getAdapter(memberAdapter).cast<MemberAdapter>();
  const Members({
    Key? key,
  }) : super(key: key);

  @override
  _MembersState createState() => _MembersState();
}

class _MembersState extends State<Members> {
  late Classroom classroom;
  bool isNeedRefresh = false;
  String classname = '';
  int totalExams = 0, totalMembers = 0;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AppBloc>(context).getUser();
    BlocProvider.of<MemberBloc>(context).getMembers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: context.disableKeyBoard,
        child: NormalScroll(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildHeader(),
              SPACING.SM.vertical,
              Column(
                children: [
                  MemberBodyHeader(
                    name: classname,
                    numExams: totalExams,
                    numMembers: totalMembers,
                  ),
                  SPACING.SM.vertical,
                  _buildBody(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {
        if (state is UserStateFailure) {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return ErrorAuthenticate(messenger: state.messenger);
              });
        }
      },
      builder: (context, state) {
        if (state is UserStateSuccess) {
          return MembersHeader(
            user: state.user,
            onGoBack: _onGoBack,
          );
        }

        return const PMemberHeader();
      },
    );
  }

  Widget _buildBody() {
    return BlocListener<MemberBloc, MemberState>(
      listener: (context, state) {
        if (state is MemberFailureState) {
          BlocProvider.of<AppBloc>(context).showError(context, state.messenger);
        }
        if (state is MemberDeleteSuccessState) {
          setState(() => totalMembers--);
        }
        if (state is MemberCreateState) {
          setState(() => totalMembers++);
        }
        if (state is MembersCreateState) {
          setState(() => totalMembers += state.members.length);
        }
        if (state is MemberDeleteSuccessState ||
            state is MemberCreateState ||
            state is MemberEditSuccessState ||
            state is MembersCreateState) isNeedRefresh = true;

        if (state is MemberLoadedState) {
          setState(() {
            classname = state.clasname;
            totalExams = state.totalExams;
            totalMembers = state.members.length;
          });
        }
      },
      child: MembersBody(classname: classname),
    );
  }

  Future<void> refreshClassroom() async {
    try {
      await BlocProvider.of<ClassroomBloc>(context).refreshClassroom();
    } catch (_) {}
  }

  Future<void> _onGoBack() async {
    Navigator.of(context).pop(isNeedRefresh);
  }
}
