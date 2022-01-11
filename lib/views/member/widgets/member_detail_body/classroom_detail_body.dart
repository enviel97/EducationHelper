import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/state.x.dart';
import 'package:education_helper/models/classroom.model.dart';
import 'package:education_helper/models/members.model.dart';
import 'package:education_helper/views/member/dialogs/member_dialog.dart';

import 'package:education_helper/views/widgets/button/custom_icon_button.dart';
import 'package:education_helper/views/widgets/button/custom_text_button.dart';
import 'package:education_helper/views/widgets/form/custom_search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'widgets/classroom_detail_header.dart';
import 'widgets/classroom_detail_list_members_item.dart';

class ClassroomDetailBody extends StatefulWidget {
  final String id;
  const ClassroomDetailBody({
    required this.id,
    Key? key,
  }) : super(key: key);

  @override
  _ClassroomDetailBodyState createState() => _ClassroomDetailBodyState();
}

class _ClassroomDetailBodyState extends State<ClassroomDetailBody> {
  late Classroom classroom;
  String searchText = '';
  List<Member> members = [];

  @override
  void initState() {
    super.initState();
    classroom = Classroom.fake();
    members.addAll(classroom.members);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClassroomDetailHeader(
          name: classroom.name,
          numExams: classroom.exams.length,
          numMembers: classroom.members.length,
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
                    onPressed: () => addMember(context),
                  ),
                  KTextButton(
                    text: 'Add With CSV',
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
    if (members.isEmpty) return const SizedBox.shrink();
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 20.0),
      itemCount: members.length,
      itemBuilder: (context, index) {
        final member = members[index];
        return ClassroomDetailListMemberItem(member: member);
      },
    );
  }

  void _onSearch(String value) {
    if (value.isEmpty) {
      members = classroom.members;
      return;
    }
    members = classroom.members.where((member) {
      final bool isMail = member.mail?.contains(value) ?? false;
      final bool isPhonenumber = member.phoneNumber?.contains(value) ?? false;
      return member.firstName.contains(value) ||
          member.lastName.contains(value) ||
          isMail ||
          isPhonenumber;
    }).toList();
  }
}
