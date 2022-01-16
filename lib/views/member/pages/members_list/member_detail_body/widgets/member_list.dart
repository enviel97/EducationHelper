import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:education_helper/helpers/extensions/string_x.dart';
import 'package:education_helper/helpers/ultils/funtions.dart';
import 'package:education_helper/models/members.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'members_detail.dart';

class MemberList extends StatelessWidget {
  final List<Member> members;
  const MemberList({
    required this.members,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 20.0),
      itemCount: members.length,
      itemBuilder: (context, index) {
        final member = members[index];
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0),
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 10.0,
          ),
          decoration: BoxDecoration(
              color: context.isLightTheme
                  ? kSecondarySuperDarkColor
                  : kSecondaryDarkColor,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: kBlackColor),
              boxShadow: [
                BoxShadow(
                    color: kBlackColor.withOpacity(.5),
                    offset: const Offset(0, 4),
                    blurRadius: 4.0)
              ]),
          child: MemberDetail(
            member: member,
            content: _staticContent(member),
          ),
        );
      },
    );
  }

  Widget _nullableWidget(String? value) {
    if (value?.isEmpty ?? true) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: Text(value!,
          style: TextStyle(
            color: kWhiteColor,
            fontSize: SPACING.M.size,
          )),
    );
  }

  Widget _iconNotice(IconData icon, String tooltip) {
    return Tooltip(
      message: tooltip,
      child: DecoratedBox(
        decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
          BoxShadow(
            color: kPrimaryDarkColor.withOpacity(1),
            offset: const Offset(0.0, 0.0),
            blurRadius: 4.0,
          ),
        ]),
        child: Icon(
          icon,
          color: kWhiteColor,
          size: SPACING.LG.size * .9,
        ),
      ),
    );
  }

  Widget _staticContent(Member member) {
    return Row(children: [
      Container(
          height: 70.0,
          width: 70.0,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: kWhiteColor,
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          child: Text(getLastName(member.lastName),
              style: TextStyle(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: SPACING.LG.size))),
      SPACING.SM.horizontal,
      Expanded(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
            Text(
              '${member.firstName} ${member.lastName}',
              style: TextStyle(
                color: kWhiteColor,
                fontWeight: FontWeight.bold,
                fontSize: SPACING.M.size + 1.5,
              ),
            ),
            _nullableWidget(member.mail),
            _nullableWidget(member.phoneNumber?.toPhone() ?? ''),
            _nullableWidget(member.birth?.toDateString() ?? ''),
          ])),
      Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _iconNotice(
            member.gender.toLowerCase() == 'male'
                ? Fontisto.male
                : Fontisto.female,
            member.gender,
          ),
          SPACING.LG.vertical,
          _iconNotice(
            MaterialIcons.swipe,
            'Edit/Delete',
          ),
        ],
      )
    ]);
  }
}
