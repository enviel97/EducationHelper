import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/datetime_x.dart';
import 'package:education_helper/views/home/home.dart';
import 'package:education_helper/views/topic/typings/color_schema.dart';
import 'package:flutter/material.dart';

class TopicItem extends StatelessWidget {
  final String id;
  final String examsName;
  final String type;
  final DateTime expiredDate;
  final int members;
  final int ansSuccess;
  final int ansMiss;
  final int ansLate;
  final Future<void> Function() refresh;

  const TopicItem({
    required this.id,
    required this.type,
    required this.examsName,
    required this.members,
    required this.ansSuccess,
    required this.ansMiss,
    required this.ansLate,
    required this.expiredDate,
    required this.refresh,
    Key? key,
  }) : super(key: key);

  Color get color => ColorSchema.industry(type).color;

  @override
  Widget build(BuildContext context) {
    final type = this.type.toUpperCase();
    return GestureDetector(
      onTap: () => _onTap(context),
      child: Container(
          height: 250,
          width: 175,
          decoration: BoxDecoration(color: color, boxShadow: [
            BoxShadow(
                color: kBlackColor.withOpacity(.25),
                offset: const Offset(4.0, 4.0),
                blurRadius: 4.0)
          ]),
          child: Stack(children: [
            Positioned(
                child: Container(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(examsName,
                              maxLines: 2,
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: kWhiteColor,
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold)),
                          SPACING.S.vertical,
                          Text(expiredDate.toStringFormat(format: 'dd/MM/yyyy'),
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  color: kWhiteColor,
                                  fontSize: SPACING.M.size,
                                  fontWeight: FontWeight.bold)),
                          Text('Member: $members',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  color: kWhiteColor,
                                  fontSize: SPACING.M.size,
                                  fontWeight: FontWeight.bold)),
                          Text('Answer: $ansSuccess | $ansLate | $ansMiss',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  color: kWhiteColor,
                                  fontSize: SPACING.M.size,
                                  fontWeight: FontWeight.bold))
                        ]))),
            Positioned(
                bottom: 0.0,
                right: -15.0,
                child: RotationTransition(
                    alignment: Alignment.center,
                    turns: const AlwaysStoppedAnimation(25 / 360),
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 25.0),
                        decoration: BoxDecoration(
                          color: kWhiteColor,
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        child: Text('.$type',
                            style: TextStyle(
                                color: color,
                                fontSize: SPACING.XXL.size,
                                fontWeight: FontWeight.bold)))))
          ])),
    );
  }

  Future<void> _onTap(BuildContext context) async {
    final isNeedRefresh = await Home.adapter.goToTopic(context, id: id);
    if (isNeedRefresh) {
      refresh();
    }
  }
}
