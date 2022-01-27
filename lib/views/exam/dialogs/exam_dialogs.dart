import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:education_helper/views/exam/bloc/exam_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void deleteExam(
  BuildContext builder,
  String name,
  String id,
) {
  showDialog(
    context: builder,
    builder: (context) {
      final highlightColor =
          context.isLightTheme ? kPrimaryLightColor : kSecondaryLightColor;
      final textColor = context.isLightTheme ? kBlackColor : kWhiteColor;
      return BlocProvider.value(
        value: BlocProvider.of<ExamBloc>(builder),
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
                BlocProvider.of<ExamBloc>(builder)
                    .delete(id)
                    .then((_) => Navigator.of(context).pop());
              },
            ),
            IconButton(
                icon: const Icon(Icons.close, color: kWhiteColor),
                onPressed: Navigator.of(context).pop)
          ],
        ),
      );
    },
  );
}
