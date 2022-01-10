import 'dart:math';

import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:education_helper/models/members.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'classroom_member_short.dart';

class ClassroomItemBody extends StatefulWidget {
  final List<Member> members;

  const ClassroomItemBody({
    required this.members,
    Key? key,
  }) : super(key: key);

  @override
  State<ClassroomItemBody> createState() => _ClassroomItemBodyState();
}

class _ClassroomItemBodyState extends State<ClassroomItemBody> {
  bool hasMore = false;
  late List<Member> members;
  @override
  void initState() {
    super.initState();
    members = widget.members;
  }

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
        children: _buildMember(),
      ),
    );
  }

  List<Widget> _buildMember() {
    final memberMax = members.getRange(0, min(members.length, 18));
    final List<Widget> widgets = memberMax
        .map<Widget>((e) => ClassroomMemberShort(
            firstname: e.firstName,
            lastname: e.lastName,
            info: e.phoneNumber ?? e.mail ?? '',
            size: 45))
        .toList();

    if (members.length > 18) {
      widgets.removeLast();
      widgets.add(const CircleAvatar(
        radius: 21.0,
        backgroundColor: kBlackColor,
        child: CircleAvatar(
          radius: 20.0,
          backgroundColor: kPlaceholderDarkColor,
          child: Icon(
            Feather.more_horizontal,
            color: kBlackColor,
          ),
        ),
      ));
    }
    return widgets;
  }
}
