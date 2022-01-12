import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:education_helper/views/widgets/deorate/box_decorate_separate_number.dart';
import 'package:flutter/material.dart';

class MemberBodyHeader extends StatelessWidget {
  final String name;
  final int numExams;
  final int numMembers;

  const MemberBodyHeader({
    required this.name,
    required this.numExams,
    required this.numMembers,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = context.mediaSize.width;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: width * 2 / 3),
            child: Text(
              name,
              maxLines: 2,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ),
          BoxDecorateSeparateNumber(
            totalExams: numExams,
            totalMembers: numMembers,
          )
        ],
      ),
    );
  }
}
