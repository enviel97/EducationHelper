import 'package:education_helper/models/members.model.dart';
import 'package:education_helper/views/classrooms/bloc/member/member_bloc.dart';
import 'package:education_helper/views/member/widgets/member_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void addMemberBottemSheet(BuildContext builder) {
  const borderRadius = BorderRadius.only(
    topLeft: Radius.circular(40.0),
    topRight: Radius.circular(40.0),
  );
  showModalBottomSheet(
    elevation: 1,
    context: builder,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(borderRadius: borderRadius),
    builder: (context) {
      return BlocProvider.value(
        value: BlocProvider.of<MemberBloc>(builder),
        child: MemberForm(
          onConfirm: (Member member) {},
          addWithCSV: () {},
        ),
      );
    },
  );
}
