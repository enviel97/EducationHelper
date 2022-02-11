import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/build_context_x.dart';
import 'package:education_helper/views/widgets/button/download_button.dart';
import 'package:education_helper/views/widgets/button/share_button.dart';
import 'package:flutter/material.dart';

class ExamAppbarBottom extends StatelessWidget {
  final String name;
  final String publicLink;
  final String downloadLink;
  const ExamAppbarBottom({
    required this.name,
    required this.publicLink,
    required this.downloadLink,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLightTheme = context.isLightTheme;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15.0,
        vertical: 5.0,
      ),
      decoration: BoxDecoration(
        color: isLightTheme ? kBlackColor : kWhiteColor,
        borderRadius: const BorderRadius.all(Radius.circular(25.0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                name.split('.')[0],
                maxLines: 1,
                style: TextStyle(
                  color:
                      isLightTheme ? kSecondaryLightColor : kPrimaryDarkColor,
                  fontWeight: FontWeight.bold,
                  fontSize: SPACING.M.size * 1.2,
                ),
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DownloadButton(
                name: name,
                download: downloadLink,
                iconSize: 24.0,
              ),
              ShareButton(
                publicLink: publicLink,
                subject: 'Click link to get homework',
                iconSize: 24.0,
              ),
            ],
          )
        ],
      ),
    );
  }
}
