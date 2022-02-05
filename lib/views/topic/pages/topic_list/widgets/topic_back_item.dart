import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/helpers/extensions/datetime_x.dart';
import 'package:education_helper/models/topic.model.dart';
import 'package:education_helper/views/topic/dialogs/topic_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class TopicBackItem extends StatelessWidget {
  final Topic topic;
  final BoxDecoration decoration;
  final Function() gotoDetail;
  const TopicBackItem({
    required this.topic,
    required this.decoration,
    required this.gotoDetail,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210.0,
      decoration: decoration,
      child: Column(
        children: [
          Expanded(
              flex: 2,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Container(
                            color: kWhiteColor,
                            width: double.infinity,
                            margin:
                                const EdgeInsets.only(top: 40.0, bottom: 10.0),
                            padding: const EdgeInsets.all(10.0),
                            alignment: Alignment.center,
                            child: Text(
                                topic.note?.isEmpty ?? true
                                    ? "Don't have any note"
                                    : topic.note!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: kBlackColor, fontSize: 16.0)))),
                    Container(
                        margin: const EdgeInsets.only(right: 10.0),
                        alignment: Alignment.centerRight,
                        child: Text.rich(TextSpan(
                            text: 'Expired: ',
                            style: const TextStyle(
                                color: kWhiteColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0),
                            children: [
                              TextSpan(
                                  text: topic.expiredDate.toStringFormat(
                                    format: 'dd/MM/yyyy - hh:mm',
                                  ),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.normal))
                            ])))
                  ])),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () => editBottomSheet(
                    context,
                    id: topic.id,
                    expired: topic.expiredDate,
                    note: topic.note,
                  ),
                  color: kWhiteColor,
                  icon: const Icon(Feather.edit),
                ),
                IconButton(
                  onPressed: () => deleteTopic(context, topic.id, topic.name),
                  color: kWhiteColor,
                  icon: const Icon(Feather.x_circle),
                ),
                IconButton(
                  onPressed: gotoDetail,
                  color: kWhiteColor,
                  icon: const Icon(Feather.eye),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
