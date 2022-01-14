import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/models/members.model.dart';
import 'package:education_helper/views/member/dialogs/member_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class MemberDetail extends StatelessWidget {
  final Member member;
  final Widget content;

  const MemberDetail({
    required this.content,
    required this.member,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      child: content,
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          CustomSlidableAction(
            onPressed: (_) => _editPressed(context),
            backgroundColor: Colors.transparent,
            child: const CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 32.0,
              child: Icon(
                Feather.edit,
                size: 32.0,
                color: kWhiteColor,
              ),
            ),
          ),
          CustomSlidableAction(
            onPressed: (_) => _removePressed(context),
            backgroundColor: Colors.transparent,
            child: const CircleAvatar(
              backgroundColor: kErrorColor,
              radius: 32.0,
              child: Icon(
                Feather.x_square,
                size: 32.0,
                color: kWhiteColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _editPressed(BuildContext context) {
    editMemberBottemSheet(context, member);
  }

  void _removePressed(BuildContext context) {
    deleteMemberDialogConfirm(context, member.uid, member.toString());
  }
}
