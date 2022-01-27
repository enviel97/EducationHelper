import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:education_helper/helpers/extensions/string_x.dart';
import 'package:education_helper/models/members.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class MembersDetailItem extends StatelessWidget {
  final Member member;
  final Function() removeMember;
  const MembersDetailItem({
    required this.member,
    required this.removeMember,
    Key? key,
  }) : super(key: key);

  Widget _nullableBuild(String? value) {
    if (value?.isEmpty ?? true) {
      return const SizedBox.shrink();
    }
    return Tooltip(
      message: value!,
      child: Text(
        value,
        maxLines: 1,
        softWrap: false,
        textAlign: TextAlign.center,
        overflow: TextOverflow.fade,
        style: const TextStyle(
          color: kWhiteColor,
          fontSize: 16.0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
            margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
            decoration: BoxDecoration(
                color: context.isLightTheme
                    ? kSecondarySuperDarkColor
                    : kPrimaryDarkColor,
                borderRadius: BorderRadius.circular(40.0),
                boxShadow: [
                  BoxShadow(
                      color: kPrimaryLightColor.withOpacity(0.5),
                      offset: const Offset(5.0, 5.0),
                      blurRadius: 5.0)
                ]),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(children: [
                    Expanded(
                        child: Text('${member.lastName} ${member.firstName}',
                            style: const TextStyle(
                                color: kWhiteColor,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold))),
                    Tooltip(
                        message: member.gender,
                        child: Icon(
                            member.gender == 'male'
                                ? Fontisto.male
                                : Fontisto.female,
                            size: 16.0,
                            color: kWhiteColor))
                  ]),
                  _nullableBuild(member.birth?.toDateString() ?? ''),
                  _nullableBuild(member.mail),
                  _nullableBuild(member.phoneNumber?.toPhone() ?? '')
                ])),
        Container(
          alignment: Alignment.topRight,
          margin: const EdgeInsets.only(right: 25),
          child: ClipOval(
            child: Material(
              color: kSecondaryColor,
              child: InkWell(
                splashColor: Colors.red, // Splash color
                onTap: removeMember,
                child: const SizedBox(
                  width: 24,
                  height: 24,
                  child: Icon(Feather.x, size: 20),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
