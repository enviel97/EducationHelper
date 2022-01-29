import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/models/classroom.model.dart';
import 'package:education_helper/views/classrooms/bloc/classroom_bloc.dart';
import 'package:education_helper/views/topic/pages/topic_form/widgets/custom_selected.dart';
import 'package:education_helper/views/topic/pages/topic_form/widgets/custom_text_radius.dart';
import 'package:education_helper/views/topic/widgets/classrooms_selected/classroom_seleceted.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class TopicSelecetedClassroom extends StatefulWidget {
  final void Function(String id) onSelectedClassroom;
  final Classroom? classroom;
  const TopicSelecetedClassroom({
    required this.onSelectedClassroom,
    this.classroom,
    Key? key,
  }) : super(key: key);

  @override
  State<TopicSelecetedClassroom> createState() =>
      _TopicSelecetedClassroomState();
}

class _TopicSelecetedClassroomState extends State<TopicSelecetedClassroom> {
  String idClassroom = '';
  String name = '';
  int members = 0;

  @override
  void initState() {
    super.initState();
    if (widget.classroom != null) {
      idClassroom = widget.classroom!.id;
      name = widget.classroom!.name;
      members = widget.classroom?.members.length ?? 0;
    }
  }

  BoxShadow get shadow {
    return BoxShadow(
      color: kBlackColor.withOpacity(.8),
      offset: const Offset(-5.0, 5.0),
      blurRadius: 10.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 15.0,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(40.0),
          ),
          boxShadow: [shadow]),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          KSelected(
            icon: MaterialCommunityIcons.google_classroom,
            onSelected: _selectedClassroom,
            value: idClassroom,
          ),
          SPACING.S.vertical,
          Flexible(
            child: Row(
              children: [
                Flexible(
                  flex: 5,
                  child: KTextRadius(
                    label: 'Name',
                    value: name,
                  ),
                ),
                SPACING.S.horizontal,
                Flexible(
                  flex: 3,
                  child: KTextRadius(
                    label: 'Mems',
                    value: '$members',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _selectedClassroom() async {
    final classroom = await showDialog<Classroom?>(
        context: context,
        builder: (_) {
          return BlocProvider(
            create: (_) => ClassroomBloc(),
            child: ClassroomSelected(id: idClassroom),
          );
        });
    if (classroom == null) return;
    setState(() {
      idClassroom = classroom.id;
      name = classroom.name;
      members = classroom.members.length;
    });
    widget.onSelectedClassroom(classroom.id);
  }
}
