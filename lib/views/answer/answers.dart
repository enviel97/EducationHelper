import 'package:flutter/material.dart';

class Answers extends StatefulWidget {
  final String id;

  const Answers({
    required this.id,
    Key? key,
  }) : super(key: key);

  @override
  State<Answers> createState() => _AnswersState();
}

class _AnswersState extends State<Answers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).backgroundColor,
        child: Column(
          children: [
            Expanded(flex: 7, child: Container()),
            Expanded(flex: 3, child: Container()),
          ],
        ),
      ),
    );
  }
}
