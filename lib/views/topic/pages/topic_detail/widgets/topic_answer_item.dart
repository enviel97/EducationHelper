import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:education_helper/helpers/extensions/string_x.dart';
import 'package:education_helper/models/members.model.dart';
import 'package:education_helper/models/topic.model.dart';
import 'package:education_helper/views/topic/pages/topic_detail/widgets/answer_grade.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class TopicAnswerItem extends StatelessWidget {
  final Member member;
  final StatusAnswer? status;
  final double grade;
  const TopicAnswerItem({
    required this.member,
    this.status,
    this.grade = 0.0,
    Key? key,
  }) : super(key: key);

  Widget _nullableText(String value) {
    if (value.isEmpty) return const SizedBox(height: 0.0, width: 0.0);
    return Text(value);
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.isLightTheme
            ? kSecondarySuperDarkColor
            : kSecondaryDarkColor,
        borderRadius: const BorderRadius.all(Radius.circular(25.0)),
      ),
      child: ListTile(
        onTap: status == StatusAnswer.empty
            ? null
            : () {
                print(1234);
              },
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 10.0,
        ),
        style: ListTileStyle.list,
        minLeadingWidth: 0,
        leading: CircleAvatar(
          radius: 21.0,
          backgroundColor: kWhiteColor,
          child: CircleAvatar(
            radius: 20.0,
            backgroundColor:
                context.isLightTheme ? kPrimaryLightColor : kPrimaryDarkColor,
            child: Icon(
              member.gender.toLowerCase() == 'male'
                  ? Fontisto.male
                  : Fontisto.female,
              color: kWhiteColor,
            ),
          ),
        ),
        title: Text(
          '$member',
          style: const TextStyle(
            color: kWhiteColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _nullableText(member.phoneNumber?.toPhone() ?? ''),
            _nullableText(member.mail ?? ''),
            _nullableText(member.birth?.toDateString() ?? ''),
          ],
        ),
        trailing: AnswerGrade(
          grade: grade,
          status: status ?? StatusAnswer.empty,
        ),
      ),
    );
  }
}
