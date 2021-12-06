import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/ultils/funtions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DecorateHeader extends StatelessWidget {
  const DecorateHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          alignment: Alignment.bottomLeft,
          height: 150,
          width: double.infinity,
          // color: kPrimaryDarkColor,
          child: const Text(
            'SIGN IN',
            style: titleStyle,
          ),
        ),
        ClipPath(
          clipper: BottomWavesClipper(),
          child: Image.asset(
            ImageFromLocal.asPng('background'),
            height: 150.0,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}

class FlagWavesClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final h = size.height;
    final w = size.width;

    path.lineTo(0, h);
    path.lineTo(0, h - 50);
    path.quadraticBezierTo(0, h, 60, h);

    // path.lineTo(w, h);
    path.lineTo(w * 2 / 3, h);
    path.quadraticBezierTo(w, h, w - 40, h - 60);
    path.lineTo(w, 0);
    // path.quadraticBezierTo(w * 2, h / 2, w / 2, h + 100);
    // path.quadraticBezierTo(w - w / 4, h - 50, w, h - 100);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

class BottomWavesClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final h = size.height;
    final w = size.width;
    final lowPoint = size.height - 65;
    final highPoint = size.height - 120;

    path.lineTo(0, h - 100);
    path.quadraticBezierTo(w / 4, highPoint, w / 2, lowPoint);
    path.quadraticBezierTo(3 / 4 * w, h, w, h);
    path.lineTo(w, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
