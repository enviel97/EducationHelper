import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:education_helper/helpers/ultils/validation.dart';
import 'package:education_helper/models/user.model.dart';
import 'package:education_helper/views/classrooms/widgets/user_avatar.dart';
import 'package:flutter/material.dart';

class MembersHeader extends StatelessWidget {
  final User user;
  const MembersHeader({
    required this.user,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                UserAvatar(url: user.avatar ?? ''),
                SPACING.SM.vertical,
                Text(
                  user.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: SPACING.LG.size,
                  ),
                ),
                SPACING.SM.vertical,
                Text(
                  user.email,
                  style: TextStyle(
                    fontSize: SPACING.M.size,
                  ),
                ),
                if (isPhone(user.phoneNumber) == null)
                  Text(
                    user.phoneNumber,
                    style: TextStyle(
                      fontSize: SPACING.M.size,
                    ),
                  ),
              ],
            ),
          ),
          Positioned(
            top: SPACING.SM.size,
            left: SPACING.SM.size,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              color: context.isLightTheme ? kBlackColor : kWhiteColor,
              onPressed: Navigator.of(context).pop,
            ),
          )
        ],
      ),
    );
  }
}
