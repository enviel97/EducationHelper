import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:education_helper/models/members.model.dart';
import 'package:education_helper/views/widgets/button/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'classroom_member_short.dart';

class ClassroomItemBody extends StatelessWidget {
  final List<Member> members;
  final Function() addMember;
  const ClassroomItemBody({
    required this.members,
    required this.addMember,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.mediaSize.width,
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 12.0,
      ),
      decoration: BoxDecoration(
          color: kWhiteColor,
          border: Border.all(),
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(25),
            bottomLeft: Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(
              color: context.isLightTheme ? kBlackColor : kWhiteColor,
              offset: const Offset(2, 4),
              blurRadius: 4.0,
              spreadRadius: 0.0,
            )
          ]),
      child: Wrap(
        spacing: SPACING.SM.size,
        runSpacing: SPACING.SM.size,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          ..._buildMember(),
          KIconButton(
            icon: const Icon(AntDesign.adduser, color: kBlackColor),
            backgroundColor: kPlaceholderDarkColor,
            sideColor: kBlackColor,
            size: const Size(32, 32),
            onPressed: addMember,
          )
        ],
      ),
    );
  }

  List<Widget> _buildMember() {
    final List<Widget> widget = members
        .map<Widget>((e) => ClassroomMemberShort(
            firstname: e.firstName,
            lastname: e.lastName,
            info: e.phoneNumber ?? e.mail ?? '',
            size: 45))
        .toList();
    return widget;
  }
}
