import 'package:education_helper/models/members.model.dart';
import 'package:education_helper/views/member/bloc/member_bloc.dart';
import 'package:education_helper/views/member/widgets/member_form.dart';
import 'package:education_helper/views/widgets/deorate/custom_confirm_alert.dart';
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
        child: const MemberForm(),
      );
    },
  );
}

void editMemberBottemSheet(BuildContext builder, Member member) {
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
        child: MemberForm(initMember: member),
      );
    },
  );
}

void deleteMemberDialogConfirm(
  BuildContext builder,
  String id,
  String name,
) {
  showDialog(
    context: builder,
    builder: (context) {
      return BlocProvider.value(
        value: BlocProvider.of<MemberBloc>(builder),
        child: KConfirmAlert(
          content: name,
          notice: 'You want to remove member: ',
          title: 'Delete Classrooms',
          onConfirm: () {
            BlocProvider.of<MemberBloc>(builder)
                .deleteMember(id)
                .whenComplete(Navigator.of(context).pop);
          },
        ),
      );
    },
  );
}
