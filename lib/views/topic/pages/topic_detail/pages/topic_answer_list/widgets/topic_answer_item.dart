import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:education_helper/helpers/extensions/string_x.dart';
import 'package:education_helper/models/answer.model.dart';
import 'package:education_helper/models/members.model.dart';
import 'package:education_helper/roots/bloc/app_bloc.dart';
import 'package:education_helper/views/topic/blocs/member/topic_members_bloc.dart';
import 'package:education_helper/views/topic/blocs/topic/topic_bloc.dart';
import 'package:education_helper/views/topic/topics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'answer_grade.dart';

class TopicAnswerItem extends StatelessWidget {
  final Member member;
  final StatusAnswer? status;
  final double? grade;
  final String idAnswer;
  final bool isDisable;
  const TopicAnswerItem({
    required this.member,
    required this.idAnswer,
    this.status,
    this.grade,
    Key? key,
    this.isDisable = false,
  }) : super(key: key);

  Widget _nullableText(String value) {
    if (value.isEmpty) return const SizedBox(height: 0.0, width: 0.0);
    return Text(value, style: const TextStyle(color: kWhiteColor));
  }

  @override
  Widget build(BuildContext context) {
    final color =
        context.isLightTheme ? kSecondarySuperDarkColor : kSecondaryDarkColor;
    return DecoratedBox(
      decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(25.0)),
          boxShadow: [
            const BoxShadow(
              color: kPrimaryColor,
              offset: Offset(0.0, 4.0),
              blurRadius: 5.0,
            ),
          ]),
      child: ListTile(
        onTap: isDisable ? null : () => _goToAnswers(context),
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

  void _goToAnswers(BuildContext context) async {
    final isAuth = BlocProvider.of<AppBloc>(context).isAuth();
    if (isAuth) {
      _gradedAnswer(context);
    } else {
      _createAnswer(context);
    }
  }

  Future<void> _createAnswer(BuildContext context) async {
    final idTopic = BlocProvider.of<TopicMembersBloc>(context).id;
    final expiredDate = BlocProvider.of<TopicBloc>(context).topic.expiredDate;

    final isNeedRefresh = await Topics.adapter.goToAnswerCreate(context,
        member: member,
        idTopic: idTopic,
        expiredDate: expiredDate,
        status: status ?? StatusAnswer.empty,
        id: idAnswer);
    if (isNeedRefresh) {
      BlocProvider.of<TopicMembersBloc>(context).refreshMembers();
    }
  }

  Future<void> _gradedAnswer(BuildContext context) async {
    if (status == StatusAnswer.empty) {
      BlocProvider.of<AppBloc>(context).showError(context, 'Answer is empty');
      return;
    }
    final isNeedRefresh =
        await Topics.adapter.goToAnswerGrade(context, idAnswer);
    if (isNeedRefresh) {
      BlocProvider.of<TopicMembersBloc>(context)
          .refreshMembers(listen: isNeedRefresh);
    }
  }
}
