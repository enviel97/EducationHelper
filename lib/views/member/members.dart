import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:education_helper/helpers/widgets/scroller_grow_disable.dart';
import 'package:education_helper/models/classroom.model.dart';
import 'package:education_helper/roots/bloc/app_bloc.dart';
import 'package:education_helper/roots/bloc/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Members extends StatefulWidget {
  final String id;
  const Members({
    required this.id,
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
                  _buildBody()
                ]))));
  }

  Widget _buildHeader() {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        if (state is UserStateSuccess) {
          return ClassroomDetailHeader(user: state.user);
        }
        if (state is UserStateFailure) {
          return ErrorAuthenticate(messenger: state.messenger);
        }
        return const PClassroomDetailHeader();
      },
    );
  }

  Widget _buildBody() {
    return ClassroomDetailBody(id: widget.id);
  }
}
