import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/string_x.dart';
import 'package:education_helper/helpers/ultils/funtions.dart';
import 'package:education_helper/models/members.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class ClassroomDetailListMemberItem extends StatelessWidget {
  final Member member;
  const ClassroomDetailListMemberItem({required this.member, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: kBlackColor),
          boxShadow: [
            BoxShadow(
                color: kBlackColor.withOpacity(.5),
                offset: const Offset(0, 4),
                blurRadius: 4.0)
          ]),
      child: Row(
        children: [
          Container(
            height: 70.0,
            width: 70.0,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: kWhiteColor,
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            child: Text(
              getLastName(member.lastName),
              style: TextStyle(
                color: kPrimaryColor,
                fontWeight: FontWeight.bold,
                fontSize: SPACING.LG.size,
              ),
            ),
          ),
          SPACING.SM.horizontal,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        '${member.firstName} ${member.lastName}',
                        style: TextStyle(
                          color: kWhiteColor,
                          fontWeight: FontWeight.bold,
                          fontSize: SPACING.M.size + 1.5,
                        ),
                      ),
                    ),
                    Tooltip(
                      message: member.gender,
                      child: Icon(
                          member.gender.toLowerCase() == 'male'
                              ? MaterialCommunityIcons.gender_male
                              : MaterialCommunityIcons.gender_female,
                          color: kWhiteColor,
                          size: SPACING.LG.size),
                    )
                  ],
                ),
                SPACING.S.vertical,
                if (member.mail != null)
                  Container(
                    padding: const EdgeInsets.only(right: 13.0),
                    child: Text(
                      '${member.mail}',
                      style: TextStyle(
                        color: kWhiteColor,
                        fontSize: SPACING.M.size,
                      ),
                    ),
                  ),
                SPACING.S.vertical,
                if (member.phoneNumber != null)
                  Text(
                    member.phoneNumber!.toPhone(),
                    style: TextStyle(
                      color: kWhiteColor,
                      fontSize: SPACING.M.size,
                    ),
                  ),
                SPACING.S.vertical,
                if (member.birth != null)
                  Text(
                    member.birth!.toDateString(),
                    style: TextStyle(
                      color: kWhiteColor,
                      fontSize: SPACING.M.size,
                    ),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
