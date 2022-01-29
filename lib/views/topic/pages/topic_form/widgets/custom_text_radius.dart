import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:flutter/material.dart';

class KTextRadius extends StatelessWidget {
  final String label;
  final String? value;

  const KTextRadius({
    required this.label,
    this.value,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.0,
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      decoration: const BoxDecoration(
        color: kBlackColor,
        borderRadius: BorderRadius.all(Radius.circular(40.0)),
      ),
      child: Row(
        children: [
          Text(
            '$label:',
            style: const TextStyle(
              color: kWhiteColor,
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          SPACING.S.horizontal,
          Expanded(
            child: Text(
              value?.isEmpty ?? true ? '...' : value!,
              maxLines: 1,
              overflow: TextOverflow.fade,
              softWrap: false,
              style: const TextStyle(
                color: kSecondaryLightColor,
                fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
