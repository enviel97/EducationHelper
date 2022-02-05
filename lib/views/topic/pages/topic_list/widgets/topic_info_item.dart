import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:flutter/material.dart';

class TopicInfoItem extends StatelessWidget {
  final String name;

  final String expiredDate;

  final String totalMembers;

  const TopicInfoItem({
    required this.name,
    required this.expiredDate,
    required this.totalMembers,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(name,
                  maxLines: 1,
                  softWrap: false,
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                      color: kWhiteColor,
                      fontSize: SPACING.LG.size,
                      fontWeight: FontWeight.bold)),
              _buildInfoRow(
                'Expired: ',
                expiredDate,
              ),
              _buildInfoRow('Members: ', totalMembers),
            ]));
  }

  Widget _buildInfoRow(String label, String value) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text.rich(
        TextSpan(
          text: label,
          style: TextStyle(
            color: kWhiteColor,
            fontWeight: FontWeight.bold,
            fontSize: SPACING.M.size,
          ),
          children: [
            TextSpan(
              text: value,
              style: const TextStyle(fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}
