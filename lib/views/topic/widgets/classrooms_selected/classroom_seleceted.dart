import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/state.x.dart';
import 'package:education_helper/models/classroom.model.dart';
import 'package:education_helper/views/classrooms/bloc/classroom_bloc.dart';
import 'package:education_helper/views/classrooms/bloc/classroom_state.dart';
import 'package:education_helper/views/widgets/button/custom_text_button.dart';
import 'package:education_helper/views/widgets/form/custom_search_field.dart';
import 'package:education_helper/views/widgets/list/list_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../topics.dart';
import 'widgets/classroom_list_error.dart';
import 'widgets/classroom_list_tile.dart';

class ClassroomSelected extends StatefulWidget {
  final String? id;
  const ClassroomSelected({Key? key, this.id}) : super(key: key);

  @override
  State<ClassroomSelected> createState() => _ClassroomSelectedState();
}

class _ClassroomSelectedState extends State<ClassroomSelected> {
  List<Classroom> classrooms = [];
  bool isNeedReload = false;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ClassroomBloc>(context).getListClassroom();
  }

  Color get shadowColor =>
      isLightTheme ? kSecondaryDarkColor : kSecondaryLightColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.0,
      shadowColor: shadowColor,
      color: kWhiteColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0))),
      margin: const EdgeInsets.symmetric(
        horizontal: 15.0,
        vertical: 30.0,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            KSearchText(
              hintText: 'Serach with id, subject or exma name',
              onSearch: _search,
            ),
            SPACING.LG.vertical,
            Expanded(
              child: BlocConsumer<ClassroomBloc, ClassroomState>(
                listener: (context, state) {
                  if (state is ClassroomGetAllSuccessState) {
                    setState(() => classrooms = state.classrooms);
                  }
                },
                builder: (context, state) {
                  if (state is ClassroomLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is ClassroomFailureState) {
                    return const ClassroomListError();
                  }

                  return ListBuilder<Classroom>(
                    datas: classrooms,
                    shirinkWrap: true,
                    itemBuilder: (data) => ClassroomListTile(
                      data: data,
                      isSelected: data.id == widget.id,
                    ),
                    margin: const EdgeInsets.only(bottom: 10.0),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                KTextButton(
                  width: 150.0,
                  onPressed: _onGoToclassrooms,
                  text: 'Go to classrooms',
                ),
                KTextButton(
                  width: 150.0,
                  isOutline: true,
                  backgroudColor: kWhiteColor,
                  onPressed: _onCancel,
                  text: 'Cancel',
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void _search(String value) {
    BlocProvider.of<ClassroomBloc>(context).searchClassroom(value);
  }

  void _onGoToclassrooms() async {
    isNeedReload = await Topics.adapter.goToClassrooms(context);
    if (isNeedReload) {
      BlocProvider.of<ClassroomBloc>(context).refreshClassroom();
    }
  }

  void _onCancel() {
    if (isNeedReload && (widget.id?.isNotEmpty ?? false)) {
      final index = classrooms.indexWhere((cls) => cls.id == widget.id);
      final classroom = index < 0 ? null : classrooms[index];
      Navigator.maybePop(context, classroom);
      return;
    }
    Navigator.maybePop(context);
  }
}
