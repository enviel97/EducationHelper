import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/state.x.dart';
import 'package:education_helper/helpers/modules/csv_modules.dart';
import 'package:education_helper/helpers/modules/file_picker.dart';
import 'package:education_helper/models/members.model.dart';
import 'package:education_helper/views/member/bloc/member_bloc.dart';
import 'package:education_helper/views/member/bloc/member_state.dart';
import 'package:education_helper/views/member/dialogs/member_dialog.dart';
import 'package:education_helper/views/member/members.dart';
import 'package:education_helper/views/member/placeholders/p_member_body.dart';
import 'package:education_helper/views/widgets/button/custom_icon_button.dart';
import 'package:education_helper/views/widgets/button/custom_text_button.dart';
import 'package:education_helper/views/widgets/form/custom_search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'widgets/member_list.dart';
import 'widgets/members_empty.dart';

class MembersBody extends StatefulWidget {
  final String classname;
  const MembersBody({
    required this.classname,
    Key? key,
  }) : super(key: key);

  @override
  _MembersBodyState createState() => _MembersBodyState();
}

class _MembersBodyState extends State<MembersBody> {
  String searchText = '';
  List<Member> members = [];
  List<Member> dynamicMembers = [];
  final filePicker = FilePickerController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                    onPressed: () => addMembersWithCSV(context),
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
    return BlocConsumer<MemberBloc, MemberState>(listener: (context, state) {
      if (state is MemberLoadedState) {
        setState(() {
          members = state.members;
          dynamicMembers = state.members;
        });
      }
    }, builder: (context, state) {
      if (state is MemberLoadingState) {
        return const PMemberBody();
      }

      return dynamicMembers.isEmpty
          ? const MembersEmpty()
          : MemberList(members: dynamicMembers);
    });
  }

  void _onSearch(String value) {
    if (value.isEmpty) {
      dynamicMembers = members;
      return;
    }
    dynamicMembers = members.where((member) {
      final bool isMail = member.mail?.contains(value) ?? false;
      final bool isPhonenumber = member.phoneNumber?.contains(value) ?? false;
      return member.firstName.toLowerCase().contains(value.toLowerCase()) ||
          member.lastName.toLowerCase().contains(value.toLowerCase()) ||
          isMail ||
          isPhonenumber;
    }).toList();
  }

  Future<void> addMembersWithCSV(BuildContext context) async {
    try {
      final file = await filePicker.getFilePicker();
      if (file == null) return;
      final csvHandle = CSVController(file);
      final sheet = await csvHandle.readFileCSV();
      if (sheet == null) return;
      final jsons = csvHandle.toJsons(sheet);
      final members =
          List.generate(jsons.length, (index) => Member.fromJson(jsons[index]));

      Members.adapter.goToMembersAdd(
        context,
        classname: widget.classname,
        members: members,
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
