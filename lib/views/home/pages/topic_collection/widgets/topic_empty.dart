import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/views/widgets/button/custom_text_button.dart';
import 'package:flutter/material.dart';

class TopicEmpty extends StatelessWidget {
  final String messenger;
  final Function() onPressed;
  final String buttonText;
  const TopicEmpty({
    required this.onPressed,
    Key? key,
    this.messenger = "Woohoo! Don't have topics this time",
    this.buttonText = 'Go to topics',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(32),
          child: Text(
            messenger,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: SPACING.LG.size),
          ),
        ),
        KTextButton(
          onPressed: onPressed,
          text: buttonText,
        )
      ],
    );
  }
}
