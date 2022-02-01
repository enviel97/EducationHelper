import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/helpers/ultils/funtions.dart';
import 'package:flutter/material.dart';

class AnswersFiles extends StatelessWidget {
  final String name;
  const AnswersFiles({
    required this.name,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Theme.of(context).hintColor)),
      child: Stack(
        children: [
          Center(
            child: Image.asset(
              ImageFromLocal.asPng('rar-icon'),
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Wrap(children: [
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    color: kWhiteColor,
                    borderRadius: BorderRadius.circular(20.0)),
                child: Text(
                  '.$name',
                  style: const TextStyle(
                    fontSize: 60.0,
                    color: kBlackColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }
}
