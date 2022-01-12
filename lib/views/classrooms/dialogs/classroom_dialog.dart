import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:education_helper/views/classrooms/bloc/classroom_bloc.dart';
import 'package:education_helper/views/classrooms/widgets/classroom_form%20.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void addClassroom(BuildContext builder) {
  const borderRadius = BorderRadius.only(
    topLeft: Radius.circular(40.0),
    topRight: Radius.circular(40.0),
  );

  showModalBottomSheet(
    context: builder,
    elevation: 15.0,
    shape: const RoundedRectangleBorder(borderRadius: borderRadius),
    builder: (context) {
      return BlocProvider.value(
          value: BlocProvider.of<ClassroomBloc>(builder),
          child: const ClassroomForm());
    },
  );
}

void editClassroom(
  BuildContext builder,
  String name,
  String id,
) {
  const borderRadius = BorderRadius.only(
    topLeft: Radius.circular(40.0),
    topRight: Radius.circular(40.0),
  );

  showModalBottomSheet(
    context: builder,
    elevation: 15.0,
    shape: const RoundedRectangleBorder(borderRadius: borderRadius),
    builder: (context) {
      return BlocProvider.value(
        value: BlocProvider.of<ClassroomBloc>(builder),
        child: ClassroomForm(
          name: name,
          id: id,
        ),
      );
    },
  );
}

void deleteClassroom(
  BuildContext builder,
  String name,
  String id,
) {
  showDialog(
    context: builder,
    builder: (context) {
      final highlightColor =
          context.isLightTheme ? kPrimaryColor : kSecondaryLightColor;
      final textColor = context.isLightTheme ? kBlackColor : kWhiteColor;
      return BlocProvider.value(
        value: BlocProvider.of<ClassroomBloc>(builder),
        child: AlertDialog(
          titleTextStyle: TextStyle(color: highlightColor),
          elevation: 20.0,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: textColor.withOpacity(0.2), width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
          ),
          title: const Text('Delete Classroom'),
          content: RichText(
            text: TextSpan(children: [
              TextSpan(
                text: 'You sure you want to delete ',
                style: TextStyle(fontSize: SPACING.M.size),
              ),
              TextSpan(
                  text: name,
                  style: TextStyle(
                    color: highlightColor,
                    fontSize: SPACING.M.size * 1.2,
                  )),
            ]),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.check, color: kErrorColor),
              onPressed: () {
                BlocProvider.of<ClassroomBloc>(builder)
                    .deleteClassroom(id)
                    .then((_) => Navigator.of(context).pop());
              },
            ),
            IconButton(
                icon: Icon(Icons.close, color: textColor),
                onPressed: Navigator.of(context).pop)
          ],
        ),
      );
    },
  );
}
