import 'package:education_helper/constants/colors.dart';
import 'package:flutter/material.dart';

class ClassroomExamsTotal extends StatelessWidget {
  final int totalMembers;
  final int totalExams;
  const ClassroomExamsTotal({
    required this.totalMembers,
    required this.totalExams,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 54.0,
      height: 27.0,
      decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(5.0),
          boxShadow: [
            BoxShadow(
              color: kBlackColor.withOpacity(0.25),
              offset: const Offset(0, 4),
              blurRadius: 4.0,
            )
          ]),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: ClipPath(
              clipper: const Clipper(radius: 10.0),
              child: Container(
                alignment: Alignment.centerLeft,
                width: 38.0,
                padding: const EdgeInsets.only(left: 6.0),
                decoration: const BoxDecoration(
                  color: kSecondaryDarkColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5.0),
                    bottomLeft: Radius.circular(5.0),
                  ),
                ),
                child: Text(
                  '$totalExams',
                  style: const TextStyle(color: kWhiteColor),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 6.0),
              child: Text(
                '$totalMembers',
                style: const TextStyle(color: kBlackColor),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Clipper extends CustomClipper<Path> {
  final double radius;
  const Clipper({required this.radius});

  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.quadraticBezierTo(
      size.width - radius,
      0.0,
      size.width * 2 / 3,
      size.height,
    );
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
