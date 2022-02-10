import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/widgets/error_authenticate.dart';
import 'package:education_helper/models/classroom.model.dart';
import 'package:education_helper/roots/bloc/app_bloc.dart';
import 'package:education_helper/roots/bloc/app_state.dart';
import 'package:education_helper/views/classrooms/adapter/classroom.adapter.dart';
import 'package:education_helper/views/classrooms/dialogs/classroom_dialog.dart';
import 'package:education_helper/views/widgets/form/custom_search_field.dart';
import 'package:education_helper/views/widgets/header/appbar_bottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/classroom_bloc.dart';
import 'bloc/classroom_state.dart';
import 'pages/classroom_list.dart';
import 'pages/widgets/classrooms_header.dart';
import 'placeholders/p_classrooms_header.dart';

class Classrooms extends StatefulWidget {
  static final adapter = ClassroomAdapter();
  const Classrooms({Key? key}) : super(key: key);

  @override
  _ClassroomsState createState() => _ClassroomsState();
}

class _ClassroomsState extends State<Classrooms> {
  List<Classroom> classrooms = [];
  bool isNeedRefresh = false;
  int totalClass = 0;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AppBloc>(context).getUser();
    BlocProvider.of<ClassroomBloc>(context).getListClassroom();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: _onGoBack,
        ),
        title: const Text('Classroom'),
        bottom: const AppbarBottom(),
        elevation: 0,
      ),
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
          elevation: 10.0,
          onPressed: () => addClassroom(context),
          tooltip: 'Add Classroom',
          child: const Icon(Icons.add),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 20.0,
                bottom: 10.0,
              ),
              child: _buildUser(),
            ),
            SPACING.M.vertical,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: KSearchText(
                hintText: 'Search classroom with name',
                onSearch: (String value) {
                  BlocProvider.of<ClassroomBloc>(context)
                      .searchClassroom(value);
                },
              ),
            ),
            SPACING.M.vertical,
            Expanded(child: _buildListClassroom()),
            SPACING.XXL.vertical,
          ],
        ),
      ),
    );
  }

  Widget _buildListClassroom() {
    return BlocListener<ClassroomBloc, ClassroomState>(
      listener: (context, state) {
        if (state is ClassroomFailureState) {
          BlocProvider.of<AppBloc>(context).showError(context, state.messenger);
        }
        if (state is ClassroomGetAllSuccessState) {
          setState(() => totalClass = state.classrooms.length);
        }
        if (state is ClassroomEditSuccessState ||
            state is ClassroomDeleteSuccessState ||
            state is ClassroomCreateSuccessState ||
            state is ClassroomRefreshState) {
          isNeedRefresh = true;
        }
        if (state is ClassroomDeleteSuccessState) {
          setState(() => totalClass -= 1);
        }
        if (state is ClassroomCreateSuccessState) {
          setState(() => totalClass += 1);
        }
      },
      child: const ClassroomList(),
    );
  }

  Widget _buildUser() {
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
          return ClassroomHeader(
              ungradeExams: 0,
              totalExams: 0,
              totalClassroom: totalClass,
              avatar: state.user.avatar ?? '',
              email: state.user.email,
              name: state.user.name);
        }
        return const PClassroomHeader();
      },
    );
  }

  Future<void> _onGoBack() async {
    Navigator.of(context).pop(isNeedRefresh);
  }
}
