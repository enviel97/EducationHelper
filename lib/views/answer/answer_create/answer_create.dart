import 'package:education_helper/models/members.model.dart';
import 'package:flutter/material.dart';

class AnswerCreate extends StatefulWidget {
  final Member member;
  final String idTopic;

  const AnswerCreate({
    required this.member,
    required this.idTopic,
    Key? key,
  }) : super(key: key);

  @override
  State<AnswerCreate> createState() => _AnswerCreateState();
}

class _AnswerCreateState extends State<AnswerCreate> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
