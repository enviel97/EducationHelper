import 'package:education_helper/models/members.model.dart';
import 'package:education_helper/views/member/dialogs/member_dialog.dart';
import 'package:education_helper/views/member/pages/member_confirm_csv/widgets/members_detail_item.dart';
import 'package:flutter/material.dart';

class MembersDetailList extends StatefulWidget {
  final List<Member> members;
  const MembersDetailList({
    required this.members,
    Key? key,
  }) : super(key: key);

  @override
  State<MembersDetailList> createState() => _MembersDetailListState();
}

class _MembersDetailListState extends State<MembersDetailList> {
  late List<Member> members;
  int index = 0;

  @override
  void initState() {
    super.initState();
    members = widget.members;
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      shrinkWrap: true,
      itemCount: widget.members.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemBuilder: _buildMember,
    );
  }

  Widget _buildMember(BuildContext context, int index) {
    final member = widget.members[index];
    return GestureDetector(
      onTap: () {
        this.index = index;
        _editTap(context, member);
      },
      key: UniqueKey(),
      child: MembersDetailItem(
        member: member,
        removeMember: () {
          _removeMember(index);
        },
      ),
    );
  }

  Future<void> _editTap(BuildContext context, Member member) async {
    final editedMember = await editMemberBottemSheetStatic(context, member);
    if (editedMember != null && mounted) {
      setState(() => members[index] = editedMember);
    }
  }

  Future<void> _removeMember(int index) async {
    setState(() => members.removeAt(index));
  }
}
