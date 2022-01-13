import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:education_helper/helpers/widgets/error_authenticate.dart';
import 'package:education_helper/helpers/widgets/scroller_grow_disable.dart';
import 'package:education_helper/models/classroom.model.dart';
import 'package:education_helper/roots/bloc/app_bloc.dart';
import 'package:education_helper/roots/bloc/app_state.dart';
import 'package:education_helper/views/member/bloc/member_bloc.dart';
import 'package:education_helper/views/member/bloc/member_state.dart';
import 'package:education_helper/views/member/pages/member_detail_body/members_body.dart';
import 'package:education_helper/views/member/pages/members_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'pages/member_detail_body/widgets/members_header.dart';
import 'placeholders/p_member_header.dart';

class Members extends StatefulWidget {
  final String classname;
  final int totalExams;
  final int totalMembers;
  const Members({
    required this.classname,
    required this.totalExams,
    required this.totalMembers,
    Key? key,
  }) : super(key: key);

  @override
  _MembersState createState() => _MembersState();
}

class _MembersState extends State<Members> {
  late Classroom classroom;
  bool isNeedRefresh = false;
  late String classname;
  late int totalExams, totalMembers;

  @override
  void initState() {
    super.initState();
    classname = widget.classname;
    totalExams = widget.totalExams;
    totalMembers = widget.totalMembers;
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
          return MembersHeader(user: state.user);
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
      },
      child: const MembersBody(),
    );
  }
}
