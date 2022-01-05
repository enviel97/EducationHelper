import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/ultils/funtions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class ClassroomMemberShort extends StatelessWidget {
  final double size;
  final String firstname;
  final String lastname;
  final String info;
  final double thinkness;
  final Color borderColor;
  const ClassroomMemberShort({
    required this.firstname,
    required this.lastname,
    required this.info,
    Key? key,
    this.size = 32.0,
    this.thinkness = 1.0,
    this.borderColor = kBlackColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      iconSize: size,
      tooltip: '\n$firstname $lastname ${info.isEmpty ? '' : '\n$info'}\n',
      onPressed: () {},
      icon: CircleAvatar(
        radius: size / 2 + thinkness,
        backgroundColor: kBlackColor,
        child: CircleAvatar(
          backgroundColor: kPrimaryColor,
          radius: size / 2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              getLastName(lastname),
              style: TextStyle(
                fontSize: SPACING.M.size,
                color: kWhiteColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
