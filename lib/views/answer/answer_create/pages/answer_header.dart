import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:education_helper/helpers/extensions/datetime_x.dart';
import 'package:education_helper/helpers/extensions/string_x.dart';
import 'package:education_helper/models/answer.model.dart';
import 'package:education_helper/models/members.model.dart';
import 'package:education_helper/views/answer/bloc/answer_bloc.dart';
import 'package:education_helper/views/answer/widgets/status_answer_decorate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnswerHeader extends StatelessWidget {
  const AnswerHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLightTheme = context.isLightTheme;
    final state = BlocProvider.of<AnswerBloc>(context);
    final member = state.member;
    final expired = state.expiredDate;
    final status = state.status;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          member?.name ?? 'Loading ...',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isLightTheme ? kSecondaryDarkColor : kPrimaryLightColor,
            fontWeight: FontWeight.bold,
            fontSize: SPACING.LG.size,
          ),
        ),
        SPACING.M.vertical,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMember(member),
            _buildInfoTopic(status, expired),
          ],
        )
      ],
    );
  }

  Widget _buildInfoTopic(StatusAnswer status, DateTime? expiredDate) =>
      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Expired date',
              style: TextStyle(
                fontSize: SPACING.M.size,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              expiredDate?.toStringFormat(format: 'MMM dd, yyyy - hh:mm') ??
                  'Loading ...',
              style: TextStyle(
                fontSize: SPACING.M.size,
              ),
            ),
            StatusAnswerDecorate(status: status),
          ],
        ),
      );

  Widget _buildMember(Member? member) => Expanded(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            member?.gender.toUperCaseFirst() ?? 'Loading ...',
            style: TextStyle(
              fontSize: SPACING.M.size,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (member?.mail?.isNotEmpty ?? false)
            Text(
              member!.mail ?? '',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: SPACING.M.size,
              ),
            ),
          if (member?.phoneNumber?.isNotEmpty ?? false)
            Text(
              member!.phoneNumber!.toPhone(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: SPACING.M.size,
              ),
            ),
        ],
      ));
}
