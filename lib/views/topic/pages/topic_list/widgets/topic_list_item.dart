import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/datetime_x.dart';
import 'package:education_helper/models/topic.model.dart';
import 'package:education_helper/views/topic/typings/color_schema.dart';
import 'package:education_helper/views/topic/widgets/answer_status.dart';
import 'package:flutter/material.dart';

class TopicListItem extends StatelessWidget {
  final Topic topic;
  const TopicListItem({
    required this.topic,
    Key? key,
  }) : super(key: key);

  ColorSchema get colorSchema => ColorSchema.industry(topic.type);

  Widget get info {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(topic.name,
                  maxLines: 1,
                  softWrap: false,
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                      color: kWhiteColor,
                      fontSize: SPACING.LG.size,
                      fontWeight: FontWeight.bold)),
              Align(
                  alignment: Alignment.centerRight,
                  child: Text.rich(TextSpan(
                      text: 'Expired: ',
                      style: TextStyle(
                          color: kWhiteColor,
                          fontWeight: FontWeight.bold,
                          fontSize: SPACING.M.size),
                      children: [
                        TextSpan(
                            text: topic.expiredDate
                                .toStringFormat(format: 'dd MMM, yyyy'),
                            style:
                                const TextStyle(fontWeight: FontWeight.normal))
                      ]))),
              Align(
                  alignment: Alignment.centerRight,
                  child: Text.rich(TextSpan(
                      text: 'Members: ',
                      style: TextStyle(
                          color: kWhiteColor,
                          fontWeight: FontWeight.bold,
                          fontSize: SPACING.M.size),
                      children: [
                        TextSpan(
                            text: '${topic.members}',
                            style:
                                const TextStyle(fontWeight: FontWeight.normal))
                      ])))
            ]));
  }

  Widget get status {
    const radius = 25.0;
    const height = 210.0;
    return Row(children: [
      Flexible(
          child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Answers: ${topic.answers.length}',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: SPACING.M.size,
                            fontWeight: FontWeight.bold,
                            color: kWhiteColor)),
                    SPACING.M.vertical,
                    Flexible(
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                          AnswerStatus(
                            number: topic.success,
                            type: AnswerType.submited,
                            tooltip: 'Submitted',
                          ),
                          AnswerStatus(
                              number: topic.lated,
                              type: AnswerType.lated,
                              tooltip: 'Lated'),
                          AnswerStatus(
                              number: topic.missing,
                              type: AnswerType.missed,
                              tooltip: 'Missing')
                        ]))
                  ]))),
      Flexible(
          child: Container(
              decoration: const BoxDecoration(
                  color: kWhiteColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(radius),
                      bottomRight: Radius.circular(radius))),
              alignment: Alignment.center,
              child: Text('.${topic.type}',
                  style: TextStyle(
                      color: colorSchema.color,
                      fontSize: height / 4,
                      fontWeight: FontWeight.bold))))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    const radius = 25.0;
    const height = 210.0;
    return Container(
      height: height,
      decoration: BoxDecoration(
          color: kWhiteColor,
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: colorSchema.gradient,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(radius)),
          boxShadow: [
            BoxShadow(
              color: kBlackColor.withOpacity(.5),
              offset: const Offset(4.0, 4.0),
              blurRadius: 4.0,
            )
          ]),
      child: Column(
        children: [Expanded(child: info), Expanded(child: status)],
      ),
    );
  }
}
