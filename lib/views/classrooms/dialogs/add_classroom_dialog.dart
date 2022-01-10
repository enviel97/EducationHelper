import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:education_helper/views/classrooms/bloc/classroom/classroom_bloc.dart';
import 'package:education_helper/views/widgets/button/custom_text_button.dart';
import 'package:education_helper/views/widgets/form/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

void addClassroom(BuildContext builder, {String initialName = ''}) {
  const borderRadius = BorderRadius.only(
    topLeft: Radius.circular(40.0),
    topRight: Radius.circular(40.0),
  );

  showModalBottomSheet(
    context: builder,
    elevation: 15.0,
    shape: const RoundedRectangleBorder(borderRadius: borderRadius),
    builder: (context) {
      String name = initialName;
      return BlocProvider.value(
        value: BlocProvider.of<ClassroomBloc>(builder),
        child: GestureDetector(
          onTap: builder.disableKeyBoard,
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Container(
              padding: EdgeInsets.only(
                  top: 20.0,
                  left: 20.0,
                  right: 20.0,
                  bottom: MediaQuery.of(builder).viewInsets.bottom),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  KTextField(
                    iconData: MaterialCommunityIcons.google_classroom,
                    hintText: 'name',
                    textInputAction: TextInputAction.go,
                    onChange: (value) => name = value,
                    onSubmit: (value) => BlocProvider.of<ClassroomBloc>(builder)
                        .createClassroom(value)
                        .then((_) => builder.goBack()),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      KTextButton(
                          width: 125.0,
                          onPressed: () =>
                              BlocProvider.of<ClassroomBloc>(builder)
                                  .createClassroom(name)
                                  .then((_) => builder.goBack()),
                          text: 'Create'),
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
        ),
      );
    },
  );
}
