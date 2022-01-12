import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:education_helper/views/classrooms/bloc/classroom_bloc.dart';
import 'package:education_helper/views/widgets/button/custom_text_button.dart';
import 'package:education_helper/views/widgets/form/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class ClassroomForm extends StatefulWidget {
  final String name;
  final String id;
  const ClassroomForm({
    Key? key,
    this.name = '',
    this.id = '',
  }) : super(key: key);

  @override
  _ClassroomFormState createState() => _ClassroomFormState();
}

class _ClassroomFormState extends State<ClassroomForm> {
  String name = '';
  bool isEdit = false;
  @override
  void initState() {
    super.initState();
    isEdit = widget.id.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final actionText = isEdit ? 'Edit' : 'Create';
    return GestureDetector(
      onTap: context.disableKeyBoard,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Container(
          padding: EdgeInsets.only(
              top: 20.0,
              left: 20.0,
              right: 20.0,
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              KTextField(
                iconData: MaterialCommunityIcons.google_classroom,
                hintText: 'name',
                initValue: widget.name,
                textInputAction: TextInputAction.go,
                onChange: (value) => name = value,
                onSubmit: _onSubmit,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  KTextButton(
                      width: 125.0,
                      onPressed: () => _onSubmit(name),
                      text: actionText),
                  KTextButton(
                    width: 125.0,
                    isOutline: true,
                    backgroudColor: kWhiteColor,
                    onPressed: Navigator.of(context).pop,
                    text: 'Cancel',
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onSubmit(String value) {
    if (isEdit && value != widget.name) {
      BlocProvider.of<ClassroomBloc>(context)
          .editClassroom(widget.id, value)
          .then((_) => context.goBack());
    } else {
      BlocProvider.of<ClassroomBloc>(context)
          .createClassroom(value)
          .then((_) => context.goBack());
    }
  }
}
