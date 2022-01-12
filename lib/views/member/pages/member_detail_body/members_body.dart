import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/state.x.dart';
import 'package:education_helper/models/members.model.dart';
import 'package:education_helper/views/member/bloc/member_bloc.dart';
import 'package:education_helper/views/member/bloc/member_state.dart';
import 'package:education_helper/views/member/dialogs/member_dialog.dart';
import 'package:education_helper/views/widgets/button/custom_icon_button.dart';
import 'package:education_helper/views/widgets/button/custom_text_button.dart';
import 'package:education_helper/views/widgets/form/custom_search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'widgets/members_detail.dart';
import 'widgets/members_empty.dart';
import 'widgets/members_header.dart';

class MembersBody extends StatefulWidget {
  final String nameClass;
  final List<dynamic> exams;
  final List<Member> members;
  const MembersBody({
    required this.nameClass,
    required this.exams,
    required this.members,
    Key? key,
  }) : super(key: key);

  @override
  _MembersBodyState createState() => _MembersBodyState();
}

class _MembersBodyState extends State<MembersBody> {
  String searchText = '';
  List<Member> members = [];
  List<dynamic> exams = [];
  String name = '';
  int totalMember = 0;
  int totalExam = 0;

  @override
  void initState() {
    super.initState();
    exams = widget.exams;
    members = widget.members;
    name = widget.nameClass;
    totalMember = widget.members.length;
    totalExam = widget.exams.length;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MemberBodyHeader(
          name: name,
          numExams: totalExam,
          numMembers: totalMember,
        ),
        SPACING.SM.vertical,
        Container(
          width: double.infinity,
          height: size.height * 3 / 5,
          margin: const EdgeInsets.symmetric(horizontal: 10.0),
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
          decoration: BoxDecoration(
              color: kWhiteColor,
              border: Border.all(color: kBlackColor, width: 1),
              boxShadow: [
                BoxShadow(
                  color: isLightTheme ? kBlackColor : kWhiteColor,
                  offset: const Offset(2.0, 4.0),
                  blurRadius: 4.0,
                )
              ],
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              KSearchText(
                hintText: 'Search',
                onSearch: _onSearch,
              ),
              SPACING.SM.vertical,
              Expanded(child: _buildListView()),
              SPACING.SM.vertical,
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  KIconButton(
                    icon: const Icon(
                      AntDesign.adduser,
                      color: kBlackColor,
                    ),
                    backgroundColor: kPlaceholderDarkColor,
                    sideColor: kPlaceholderDarkColor,
                    text: 'Add Member',
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    textStyle: const TextStyle(color: kBlackColor),
                    onPressed: () => addMemberBottemSheet(context),
                  ),
                  KTextButton(
                    text: 'Add Multiple',
                    isOutline: true,
                    color: kBlackColor,
                    backgroudColor: kWhiteColor,
                    width: 150.0,
                    onPressed: () {},
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _buildListView() {
    return BlocListener<MemberBloc, MemberState>(
        listener: (context, state) {
          if (state is MemberCreateState) {
            members.add(state.member);
            setState(() => totalMember += 1);
          }

          if (state is MemberCreateState) {
            members.add(state.member);
            setState(() => totalMember += 1);
          }
        },
        child: (members.isEmpty)
            ? const MembersEmpty()
            : ListView.builder(
                padding: const EdgeInsets.only(bottom: 20.0),
                itemCount: members.length,
                itemBuilder: (context, index) {
                  final member = members[index];
                  return MemberDetail(member: member);
                }));
  }

  void _onSearch(String value) {
    if (value.isEmpty) {
      members = widget.members;
      return;
    }
    members = members.where((member) {
      final bool isMail = member.mail?.contains(value) ?? false;
      final bool isPhonenumber = member.phoneNumber?.contains(value) ?? false;
      return member.firstName.contains(value) ||
          member.lastName.contains(value) ||
          isMail ||
          isPhonenumber;
    }).toList();
  }
}
