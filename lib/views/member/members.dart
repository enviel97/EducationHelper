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
import 'package:education_helper/views/member/placeholders/p_member_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'placeholders/p_member_header.dart';

class Members extends StatefulWidget {
  const Members({
    Key? key,
  }) : super(key: key);

  @override
  _MembersState createState() => _MembersState();
}

class _MembersState extends State<Members> {
  late Classroom classroom;
  bool isNeedRefresh = false;
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
              _buildBody(),
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
    return BlocConsumer<MemberBloc, MemberState>(
      listener: (context, state) {
        if (state is MemberFailureState) {
          BlocProvider.of<AppBloc>(context).showError(context, state.messenger);
        }
      },
      builder: (context, state) {
        if (state is MemberLoadedState) {
          return MembersBody(
            nameClass: state.clasroomName,
            exams: state.exams,
            members: state.members,
          );
        }
        return const PMemberBody();
      },
    );
  }
}
